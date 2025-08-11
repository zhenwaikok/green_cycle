import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/constant/images_manager.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/location_repository.dart';
import 'package:green_cycle_fyp/repository/pickup_request_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/location_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/pickup_request_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/profile_image.dart';
import 'package:provider/provider.dart';

@RoutePage()
class RequestLocationTrackingScreen extends StatelessWidget {
  const RequestLocationTrackingScreen({
    super.key,
    required this.pickupRequestID,
  });

  final String pickupRequestID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        UserViewModel(
          firebaseRepository: FirebaseRepository(
            firebaseServices: FirebaseServices(),
          ),
          userRepository: UserRepository(
            sharePreferenceHandler: SharedPreferenceHandler(),
            userServices: UserServices(),
          ),
        );
        LocationViewModel(locationRepository: LocationRepository());
        PickupRequestViewModel(
          firebaseRepository: FirebaseRepository(
            firebaseServices: FirebaseServices(),
          ),
          pickupRequestRepository: PickupRequestRepository(),
          userRepository: UserRepository(
            sharePreferenceHandler: SharedPreferenceHandler(),
            userServices: UserServices(),
          ),
        );
      },
      child: _RequestLocationTrackingScreen(pickupRequestID: pickupRequestID),
    );
  }
}

class _RequestLocationTrackingScreen extends BaseStatefulPage {
  const _RequestLocationTrackingScreen({required this.pickupRequestID});

  final String pickupRequestID;
  @override
  State<_RequestLocationTrackingScreen> createState() =>
      _RequestLocationTrackingScreenState();
}

class _RequestLocationTrackingScreenState
    extends BaseStatefulState<_RequestLocationTrackingScreen> {
  Set<Marker> markers = {};
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng? customerLocation;
  LatLng? collectorInitialLocation;
  LatLng? collectorCurrentLocation;
  CameraPosition get cameraPosition => CameraPosition(
    target: collectorCurrentLocation ?? LatLng(0, 0),
    zoom: 15,
  );

  Timer? locationTimer;
  BitmapDescriptor collectorCurrentMarkerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor customerMarkerIcon = BitmapDescriptor.defaultMarker;
  PolylinePoints polylinePoints = PolylinePoints(
    apiKey: EnvValues.googleApiKey,
  );
  List<LatLng> points = [];

  int distance = 0;
  double duration = 0.0;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  EdgeInsets defaultPadding() {
    return EdgeInsets.zero;
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  void initState() {
    super.initState();
    initialLoad();
    getCollectorCurrentLocation();
  }

  @override
  void dispose() {
    locationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget body() {
    final collectorDetails = context.select(
      (UserViewModel vm) => vm.userDetails,
    );

    return Stack(
      children: [
        getGoogleMap(),
        Positioned(top: 40, left: 15, child: getBackButton()),
        Align(
          alignment: Alignment.bottomCenter,
          child: getBottomSheet(
            profileImageURL: collectorDetails?.profileImageURL ?? '',
            collectorName: collectorDetails?.fullName ?? '-',
            vehicle: collectorDetails?.vehicleType ?? '-',
            vehiclePlatNum: collectorDetails?.vehiclePlateNumber ?? '-',
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _RequestLocationTrackingScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void initialLoad() async {
    await fetchData();
    await setCustomMarkerIcon();
    await updatePolylines();
    await animateToCustomerLocation(isInitial: true);
  }

  void getCollectorCurrentLocation() {
    locationTimer = Timer.periodic((Duration(seconds: 8)), (timer) async {
      await fetchCollectorLocation(isInitial: false);
      await updatePolylines();
      if (mounted) {
        await animateToCustomerLocation(isInitial: false);
      }
    });
  }

  Future<void> setCustomMarkerIcon() async {
    final iconResult = await Future.wait([
      BitmapDescriptor.asset(
        ImageConfiguration(size: _Styles.markerIconSize),
        Images.homeMarkerIcon,
      ),

      BitmapDescriptor.asset(
        ImageConfiguration(size: _Styles.currentLocationMarkerIconSize),
        Images.carMarkerIcon,
      ),
    ]);

    _setState(() {
      customerMarkerIcon = iconResult[0];
      collectorCurrentMarkerIcon = iconResult[1];
    });
  }

  Future<void> updatePolylines() async {
    RoutesApiRequest request = RoutesApiRequest(
      origin: PointLatLng(
        collectorCurrentLocation?.latitude ?? 0.0,
        collectorCurrentLocation?.longitude ?? 0.0,
      ),
      destination: PointLatLng(
        customerLocation?.latitude ?? 0.0,
        customerLocation?.longitude ?? 0.0,
      ),
      travelMode: TravelMode.driving,
      routingPreference: RoutingPreference.trafficAware,
    );

    RoutesApiResponse response = await polylinePoints
        .getRouteBetweenCoordinatesV2(request: request);

    if (response.routes.isNotEmpty) {
      Route route = response.routes.first;

      duration = route.durationMinutes ?? 0.0;
      distance = route.distanceMeters ?? 0;
      points =
          route.polylinePoints
              ?.map((point) => LatLng(point.latitude, point.longitude))
              .toList() ??
          [];
    }
  }

  Future<void> fetchData() async {
    final pickupRequestVM = context.read<PickupRequestViewModel>();

    await tryLoad(
      context,
      () => pickupRequestVM.getPickupRequestDetails(
        pickupRequestID: widget.pickupRequestID,
      ),
    );

    _setState(() {
      customerLocation = LatLng(
        pickupRequestVM.pickupRequestDetails?.pickupLatitude ?? 0.0,
        pickupRequestVM.pickupRequestDetails?.pickupLongtitude ?? 0.0,
      );
    });

    final collectorUserID = mounted
        ? context
              .read<PickupRequestViewModel>()
              .pickupRequestDetails
              ?.collectorUserID
        : null;

    await fetchCollectorLocation(isInitial: true);

    if (mounted) {
      await tryLoad(
        context,
        () => context.read<UserViewModel>().getUserDetails(
          userID: collectorUserID ?? '',
          noNeedUpdateUserSharedPreference: true,
        ),
      );
    }
  }

  Future<void> fetchCollectorLocation({required bool isInitial}) async {
    final locationVM = context.read<LocationViewModel>();
    final pickupRequestVM = context.read<PickupRequestViewModel>();

    final collectorUserID =
        pickupRequestVM.pickupRequestDetails?.collectorUserID;

    await tryCatch(
      context,
      () => locationVM.getCollectorLocations(
        collectorUserID: collectorUserID ?? '',
      ),
    );

    _setState(() {
      if (isInitial) {
        collectorInitialLocation = LatLng(
          locationVM.collectorLocationDetails?.collectorLatitude ?? 0.0,
          locationVM.collectorLocationDetails?.collectorLongtitude ?? 0.0,
        );
      }
      collectorCurrentLocation = LatLng(
        locationVM.collectorLocationDetails?.collectorLatitude ?? 0.0,
        locationVM.collectorLocationDetails?.collectorLongtitude ?? 0.0,
      );
    });
  }

  Future<void> animateToCustomerLocation({required bool isInitial}) async {
    final GoogleMapController controller = await _controller.future;

    if (isInitial) {
      _setState(() {
        markers.clear();
        markers.addAll([
          Marker(
            markerId: MarkerId('customer_location'),
            position: customerLocation ?? LatLng(0, 0),
            icon: customerMarkerIcon,
          ),
          Marker(
            markerId: MarkerId('collector_current_location'),
            position: collectorCurrentLocation ?? LatLng(0, 0),
            icon: collectorCurrentMarkerIcon,
          ),
        ]);
      });
    } else {
      markers.removeWhere(
        (m) => m.markerId.value == 'collector_current_location',
      );
      markers.add(
        Marker(
          markerId: MarkerId('collector_current_location'),
          position: collectorCurrentLocation ?? LatLng(0, 0),
          icon: collectorCurrentMarkerIcon,
        ),
      );
    }

    await controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _RequestLocationTrackingScreenState {
  Widget getGoogleMap() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: cameraPosition,
      markers: markers,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      polylines: {
        Polyline(
          polylineId: PolylineId('route'),
          points: points,
          width: _Styles.polylineWidth,
          color: ColorManager.primary,
        ),
      },
    );
  }

  Widget getBackButton() {
    return getTopButton(
      icon: Icons.arrow_back_rounded,
      onPressed: onBackButtonPressed,
    );
  }

  Widget getTopButton({required IconData icon, required Function() onPressed}) {
    return Container(
      width: _Styles.backButtonContainerSize,
      height: _Styles.backButtonContainerSize,
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: ColorManager.blackColor.withValues(alpha: 0.15),
            blurRadius: 8,
            spreadRadius: 0.2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: IconButton(
          icon: Icon(icon, color: ColorManager.blackColor),
          onPressed: onPressed,
        ),
      ),
    );
  }

  Widget getBottomSheet({
    required String profileImageURL,
    required String collectorName,
    required String vehicle,
    required String vehiclePlatNum,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(_Styles.bottomSheetBorderRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorManager.blackColor.withValues(alpha: 0.5),
            blurRadius: 8,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Padding(
        padding: _Styles.screenPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            getDistanceAndTimeDetails(),
            SizedBox(height: 20),
            getCollectorDetails(
              profileImageURL: profileImageURL,
              collectorName: collectorName,
              vehicle: vehicle,
              vehiclePlatNum: vehiclePlatNum,
            ),
          ],
        ),
      ),
    );
  }

  Widget getDistanceAndTimeDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getTrackingElement(
          title: 'Distance',
          data: WidgetUtil.distanceFormatter(distance),
        ),
        SizedBox(width: 20),
        getTrackingElement(
          title: 'Estimated Time',
          data: WidgetUtil.durationFormatter(duration),
        ),
      ],
    );
  }

  Widget getTrackingElement({required String title, required String data}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _Styles.blackTextStyle),
        Text(data, style: _Styles.greenTextStyle),
      ],
    );
  }

  Widget getCollectorDetails({
    required String profileImageURL,
    required String collectorName,
    required String vehicle,
    required String vehiclePlatNum,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Collector Details', style: _Styles.blackTextStyle),
        SizedBox(height: 20),
        Row(
          children: [
            CustomProfileImage(
              imageSize: _Styles.collectorImageSize,
              imageURL: profileImageURL,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    collectorName,
                    style: _Styles.collectorNameTextStyle,
                    maxLines: _Styles.maxTextLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '$vehicle, $vehiclePlatNum',
                    style: _Styles.vehicleTextStyle,
                    maxLines: _Styles.maxTextLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.phone,
                color: ColorManager.primary,
                size: _Styles.dialButtonSize,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const backButtonContainerSize = 50.0;
  static const bottomSheetBorderRadius = 20.0;
  static const collectorImageSize = 70.0;
  static const dialButtonSize = 25.0;
  static const maxTextLines = 2;
  static const markerIconSize = Size(60, 60);
  static const currentLocationMarkerIconSize = Size(30, 30);
  static const polylineWidth = 6;

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 30,
    vertical: 30,
  );

  static const blackTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.medium,
    color: ColorManager.blackColor,
  );

  static const greenTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.medium,
    color: ColorManager.primary,
  );

  static const collectorNameTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const vehicleTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.greyColor,
  );
}

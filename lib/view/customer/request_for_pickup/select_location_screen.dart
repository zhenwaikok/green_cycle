import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/repository/location_repository.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/location_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/pickup_request_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SelectLocationScreen extends StatelessWidget {
  const SelectLocationScreen({super.key, required this.isEdit});

  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          LocationViewModel(locationRepository: LocationRepository()),
      child: _SelectLocationScreen(isEdit: isEdit),
    );
  }
}

class _SelectLocationScreen extends BaseStatefulPage {
  const _SelectLocationScreen({required this.isEdit});

  final bool isEdit;

  @override
  State<_SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState
    extends BaseStatefulState<_SelectLocationScreen> {
  final _formkey = GlobalKey<FormBuilderState>();
  TextEditingController searchController = TextEditingController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final focusNode = FocusNode();

  String? _pickupAddress;
  String? googleAPIKey = EnvValues.googleApiKey;
  LatLng? selectedLatLng;
  Set<Marker> markers = {};

  CameraPosition get cameraPosition =>
      CameraPosition(target: selectedLatLng ?? LatLng(0, 0), zoom: 15);

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    initializeCurrentLocation(isEdit: widget.isEdit);
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
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Select Location',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget body() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTitle(),
            Expanded(child: getGoogleMap()),
          ],
        ),
        getBottomDraggableScrollableSheet(
          searchController: searchController,
          googleAPIkey: googleAPIKey,
          formKey: _formkey,
          isEdit: widget.isEdit,
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + kToolbarHeight + 60,
          right: 10,
          child: getMyCurrentLocationButton(),
        ),
      ],
    );
  }
}

// * ---------------------------- Helpers ----------------------------
extension _Helpers on _SelectLocationScreenState {
  String get pickupLocation => _pickupAddress ?? '';

  String? get remarks => _formkey
      .currentState
      ?.fields[RequestForPickupFormFieldsEnum.remarks.name]
      ?.value;

  LatLng get pickupLatLng => selectedLatLng ?? LatLng(0, 0);
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _SelectLocationScreenState {
  void onBackButtonPressed() {
    if (!widget.isEdit) {
      context.read<PickupRequestViewModel>().clearAll();
    }

    context.router.maybePop();
  }

  Future<void> loadData() async {
    final vm = context.read<PickupRequestViewModel>();
    _setState(() {
      selectedLatLng = vm.selectedLatLng;
      _pickupAddress = vm.pickupLocation;
    });
  }

  void onNextButtonPressed({required bool isEdit}) async {
    if (_pickupAddress != null) {
      context.read<PickupRequestViewModel>().updateLocation(
        pickupLocation: pickupLocation,
        selectedLatLng: pickupLatLng,
        remarks: remarks,
      );

      if (isEdit) {
        WidgetUtil.showSnackBar(text: 'Updated successfully');
        context.router.maybePop(true);
      } else {
        final result = await context.router.push(
          SchedulePickupRoute(isEdit: false),
        );

        if (result == true && mounted) {
          await loadData();
          await animateToSelectedLocation();
        }
      }
    }
  }

  void onSuggestionPlaceClick(Prediction prediction) {
    searchController.text = prediction.description ?? '';
    searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: prediction.description?.length ?? 0),
    );

    _setState(() {
      _pickupAddress = prediction.description;
    });
  }

  Future<void> initializeCurrentLocation({required bool isEdit}) async {
    if (isEdit) {
      final initialLatLng = context
          .read<PickupRequestViewModel>()
          .selectedLatLng;

      await onLocationSelected(initialLatLng ?? LatLng(0, 0));
    } else {
      try {
        await tryLoad(context, () => getCurrentLocation());
      } catch (e) {
        _setState(() {
          selectedLatLng = LatLng(3.1390, 101.6869);
          markers.add(
            Marker(
              markerId: MarkerId('fallback_location'),
              position: selectedLatLng ?? LatLng(0, 0),
            ),
          );
        });

        await convertCoordinatesToAddress(selectedLatLng ?? LatLng(0, 0));

        final controller = await _controller.future;
        controller.animateCamera(
          CameraUpdate.newLatLngZoom(selectedLatLng!, 16),
        );
      }
    }
  }

  Future<void> onLocationSelected(LatLng latLng) async {
    _setState(() {
      selectedLatLng = latLng;
    });

    await convertCoordinatesToAddress(latLng);

    await animateToSelectedLocation();
  }

  Future<void> convertCoordinatesToAddress(LatLng latLng) async {
    final pickupAddress = await tryCatch(
      context,
      () => context.read<LocationViewModel>().convertCoordinatesToAddress(
        latLng: latLng,
      ),
    );

    if (pickupAddress != null) {
      _setState(() {
        _pickupAddress = pickupAddress;
      });
    }
  }

  Future<void> animateToSelectedLocation() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );

    print('Selected latlng: $selectedLatLng');

    _setState(() {
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId('Current Location'),
          position: selectedLatLng ?? LatLng(0, 0),
        ),
      );
    });
  }

  Future<void> getCurrentLocation() async {
    print('get current location');
    Position? position = await context
        .read<LocationViewModel>()
        .currentLocation();
    print('Current position: $position');
    if (position != null) {
      await onLocationSelected(LatLng(position.latitude, position.longitude));
    } else {
      WidgetUtil.showSnackBar(
        text: 'Unable to get current location, please enable GPS',
      );
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _SelectLocationScreenState {
  Widget getTitle() {
    return Padding(
      padding: _Styles.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Choose the pickup location', style: _Styles.titleTextStyle),
          Text(
            'Please provide the location where the pickup should take place. This helps ensure a smooth and accurate collection process.',
            style: _Styles.descriptionTextStyle,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget getGoogleMap() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      initialCameraPosition: cameraPosition,
      markers: markers,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  Widget getMyCurrentLocationButton() {
    return FloatingActionButton(
      onPressed: getCurrentLocation,
      backgroundColor: ColorManager.whiteColor,
      child: Icon(
        Icons.my_location,
        size: _Styles.iconSize,
        color: ColorManager.blackColor,
      ),
    );
  }

  Widget getBottomDraggableScrollableSheet({
    required TextEditingController searchController,
    required String? googleAPIkey,
    required GlobalKey<FormBuilderState> formKey,
    required bool isEdit,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final minChildSize = 100 / screenHeight;
    final maxChildSize = 450 / screenHeight;

    return DraggableScrollableSheet(
      initialChildSize: maxChildSize / 2,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: ColorManager.blackColor.withValues(alpha: 0.5),
                blurRadius: 8,
                offset: Offset(0, -1),
              ),
            ],
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: getBottomSheetContent(
              searchController: searchController,
              googleAPIkey: googleAPIkey,
              pickupLocation: _pickupAddress ?? '-',
              formKey: formKey,
              isEdit: isEdit,
            ),
          ),
        );
      },
    );
  }

  Widget getBottomSheetContent({
    required TextEditingController searchController,
    required String? googleAPIkey,
    required String pickupLocation,
    required GlobalKey<FormBuilderState> formKey,
    required bool isEdit,
  }) {
    return Padding(
      padding: _Styles.screenPadding,
      child: FormBuilder(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            getGoogleMapSearchBar(
              searchController: searchController,
              googleAPIkey: googleAPIkey,
            ),
            SizedBox(height: 25),
            getPickupLocationSection(pickupLocation: pickupLocation),
            SizedBox(height: 20),
            getRemarkSection(),
            SizedBox(height: 40),
            getNextButton(isEdit: isEdit),
          ],
        ),
      ),
    );
  }

  Widget getGoogleMapSearchBar({
    required TextEditingController searchController,
    required String? googleAPIkey,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black),
      ),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: searchController,
        focusNode: focusNode,
        googleAPIKey: googleAPIkey ?? '',
        countries: ['my'],
        debounceTime: _Styles.debounceTime,
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) async {
          if (prediction.lat != null && prediction.lng != null) {
            await onLocationSelected(
              LatLng(
                double.parse(prediction.lat ?? ''),
                double.parse(prediction.lng ?? ''),
              ),
            );
          }
        },
        inputDecoration: InputDecoration(
          hintText: 'Search your address here',
          contentPadding: _Styles.contentPadding,
          prefixIcon: Icon(
            Icons.search,
            color: ColorManager.blackColor,
            size: _Styles.searchIconSize,
          ),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        boxDecoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(_Styles.searchBarBorderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 8,
              spreadRadius: 0.5,
              offset: Offset(0, 0),
            ),
          ],
        ),
        itemClick: (Prediction prediction) {
          onSuggestionPlaceClick(prediction);
        },
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            color: ColorManager.whiteColor,
            padding: _Styles.searchAddressListPadding,
            child: Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(width: 10),
                Expanded(child: Text(prediction.description ?? "")),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget getPickupLocationSection({required String pickupLocation}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getSectionTitle(
          title: 'Pickup Location',
          icon: Icons.location_on_rounded,
        ),
        SizedBox(height: 5),
        Text(
          pickupLocation,
          style: _Styles.descriptionTextStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget getRemarkSection() {
    return Column(
      children: [
        getSectionTitle(
          title: 'Remarks (Optional)',
          icon: FontAwesomeIcons.tags,
        ),
        SizedBox(height: 5),
        CustomTextField(
          fontSize: 15,
          color: ColorManager.primary,
          formName: RequestForPickupFormFieldsEnum.remarks.name,
          needTitle: false,
        ),
      ],
    );
  }

  Widget getSectionTitle({required String title, required IconData icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, color: ColorManager.primary, size: _Styles.iconSize),
        SizedBox(width: 5),
        Text(title, style: _Styles.sectionTitleTextStyle),
      ],
    );
  }

  Widget getNextButton({required bool isEdit}) {
    return CustomButton(
      text: isEdit ? 'Update' : 'Next',
      textColor: ColorManager.whiteColor,
      onPressed: () => onNextButtonPressed(isEdit: isEdit),
      backgroundColor: ColorManager.primary,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const searchIconSize = 25.0;
  static const contentPadding = EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 10,
  );

  static const searchAddressListPadding = EdgeInsets.all(10);

  static const iconSize = 30.0;
  static const searchBarBorderRadius = 20.0;
  static const debounceTime = 400;

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const titleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const descriptionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const sectionTitleTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );
}

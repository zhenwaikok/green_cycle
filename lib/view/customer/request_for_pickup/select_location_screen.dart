import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:green_cycle_fyp/widget/search_bar.dart';

@RoutePage()
class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Select Location',
        isBackButtonVisible: true,
        onPressed: onBackButtonPressed,
      ),
      bottomNavigationBar: Padding(
        padding: _Styles.screenPadding,
        child: getNextButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getTitle(),
                SizedBox(height: 20),
                getGoogleMap(),
                SizedBox(height: 30),
                getSearchBar(),
                SizedBox(height: 25),
                getPickupLocationSection(),
                SizedBox(height: 20),
                getRemarkSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _SelectLocationScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onNextButtonPressed() {
    context.router.push(SchedulePickupRoute());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _SelectLocationScreenState {
  Widget getTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Choose the pickup location', style: _Styles.titleTextStyle),
        Text(
          'Please provide the location where the pickup should take place. This helps ensure a smooth and accurate collection process.',
          style: _Styles.descriptionTextStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget getGoogleMap() {
    return SizedBox(
      height: 400,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          //TODO: Change to current location of user later
          target: LatLng(3.0551, 101.7006),
          zoom: 18,
        ),
        markers: {
          Marker(
            markerId: MarkerId("currentLocation"),
            position: LatLng(3.0551, 101.7006),
            icon: BitmapDescriptor.defaultMarker,
          ),
        },
      ),
    );
  }

  Widget getSearchBar() {
    return CustomSearchBar(hintText: 'Search your address here');
  }

  Widget getPickupLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getSectionTitle(
          title: 'Pickup Location',
          icon: Icons.location_on_rounded,
        ),
        SizedBox(height: 5),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc varius urna eu ultricies egestas.',
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

  Widget getNextButton() {
    return CustomButton(
      text: 'Next',
      textColor: ColorManager.whiteColor,
      onPressed: onNextButtonPressed,
      backgroundColor: ColorManager.primary,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const iconSize = 30.0;

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

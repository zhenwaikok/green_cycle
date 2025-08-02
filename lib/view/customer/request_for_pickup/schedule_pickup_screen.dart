import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/viewmodel/pickup_request_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_date_picker_field.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SchedulePickupScreen extends StatelessWidget {
  const SchedulePickupScreen({super.key, required this.isEdit});

  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return _SchedulePickupScreen(isEdit: isEdit);
  }
}

class _SchedulePickupScreen extends StatefulWidget {
  const _SchedulePickupScreen({required this.isEdit});

  final bool isEdit;
  @override
  State<_SchedulePickupScreen> createState() => _SchedulePickupScreenState();
}

class _SchedulePickupScreenState extends State<_SchedulePickupScreen> {
  final _formkey = GlobalKey<FormBuilderState>();
  final pickUpTimeOptions = DropDownItems.pickUpTimeOptions;

  int selectedPickUpTimeOptionIndex = 0;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Schedule Pickup',
        isBackButtonVisible: true,
        onPressed: onBackButtonPressed,
      ),
      bottomNavigationBar: Padding(
        padding: _Styles.screenPadding,
        child: getNextButton(isEdit: widget.isEdit),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: _Styles.screenPadding,
            child: FormBuilder(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getTitle(),
                  SizedBox(height: 35),
                  getPickupDateSection(),
                  SizedBox(height: 25),
                  getPickupTimeSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Helpers ----------------------------
extension _Helpers on _SchedulePickupScreenState {
  DateTime get pickupDate => _formkey
      .currentState
      ?.fields[RequestForPickupFormFieldsEnum.pickupDate.name]
      ?.value;

  String get pickupTimeRange =>
      DropDownItems.pickUpTimeOptions[selectedPickUpTimeOptionIndex];
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _SchedulePickupScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onPickupTimeOptionPressed(int index) {
    _setState(() {
      selectedPickUpTimeOptionIndex = index;
    });
  }

  void onNextButtonPressed({required bool isEdit}) {
    context.read<PickupRequestViewModel>().updatePickupDateAndTime(
      pickupDate: pickupDate,
      pickupTimeRange: pickupTimeRange,
    );
    if (isEdit) {
      WidgetUtil.showSnackBar(text: 'Updated successfully');
      context.router.maybePop();
    } else {
      context.router.push(RequestItemDetailsRoute(isEdit: false));
    }
  }

  void loadData() {
    final vm = context.read<PickupRequestViewModel>();
    if (vm.pickupTimeRange != null) {
      selectedPickUpTimeOptionIndex = pickUpTimeOptions.indexOf(
        vm.pickupTimeRange ?? '',
      );
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _SchedulePickupScreenState {
  Widget getTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Schedule Pickup', style: _Styles.titleTextStyle),
        Text(
          'Select a convenient date and time for the pickup. This allows collector to arrange the collection based on your availability.',
          style: _Styles.descriptionTextStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget getPickupDateSection() {
    final vm = context.read<PickupRequestViewModel>();
    return Column(
      children: [
        getSectionTitle(
          title: 'Preferred Pickup Date',
          icon: Icons.calendar_month,
        ),
        SizedBox(height: 10),
        CustomDatePickerField(
          formName: RequestForPickupFormFieldsEnum.pickupDate.name,
          suffixIcon: Icon(
            Icons.calendar_today,
            color: ColorManager.greyColor,
            size: _Styles.datePickerIconSize,
          ),
          initialValue: vm.pickupDate,
        ),
      ],
    );
  }

  Widget getPickupTimeSection() {
    return Column(
      children: [
        getSectionTitle(
          title: 'Prefered Pickup Time',
          icon: Icons.access_time_rounded,
        ),
        SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: pickUpTimeOptions.length,
          itemBuilder: (context, index) {
            return getAvailableTimeCard(
              timeRange: pickUpTimeOptions[index],
              isSelected: selectedPickUpTimeOptionIndex == index,
              onTap: () => onPickupTimeOptionPressed(index),
            );
          },
        ),
      ],
    );
  }

  Widget getSectionTitle({required String title, required IconData icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, color: ColorManager.primary, size: _Styles.sectionIconSize),
        SizedBox(width: 5),
        Text(title, style: _Styles.sectionTitleTextStyle),
      ],
    );
  }

  Widget getAvailableTimeCard({
    required String timeRange,
    required bool isSelected,
    void Function()? onTap,
  }) {
    final parts = timeRange.split(' - ');

    return TouchableOpacity(
      onPressed: onTap,
      child: Container(
        width: _Styles.pickupTimeCardSize,
        height: _Styles.pickupTimeCardSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_Styles.borderRadius),
          border: isSelected == true
              ? Border.all(color: ColorManager.primary)
              : Border.all(color: ColorManager.greyColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              parts[0],
              style: _Styles.availableTimeTextStyle(isSelected: isSelected),
            ),
            Text(
              '-',
              style: _Styles.availableTimeTextStyle(isSelected: isSelected),
            ),
            Text(
              parts[1],
              style: _Styles.availableTimeTextStyle(isSelected: isSelected),
            ),
          ],
        ),
      ),
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

  static const sectionIconSize = 30.0;
  static const datePickerIconSize = 20.0;
  static const borderRadius = 5.0;
  static const pickupTimeCardSize = 100.0;

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

  static TextStyle availableTimeTextStyle({required bool isSelected}) =>
      TextStyle(
        fontSize: 16,
        fontWeight: isSelected
            ? FontWeightManager.bold
            : FontWeightManager.regular,
        color: isSelected ? ColorManager.primary : ColorManager.greyColor,
      );
}

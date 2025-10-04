import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/user/user_model.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_dropdown.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:provider/provider.dart';

@RoutePage()
class AddOrEditAddressScreen extends StatelessWidget {
  const AddOrEditAddressScreen({super.key, required this.isAddAddress});

  final bool isAddAddress;

  @override
  Widget build(BuildContext context) {
    return _AddOrEditAddressScreen(isAddAddress: isAddAddress);
  }
}

class _AddOrEditAddressScreen extends BaseStatefulPage {
  const _AddOrEditAddressScreen({required this.isAddAddress});

  final bool isAddAddress;

  @override
  State<_AddOrEditAddressScreen> createState() => _AddEditAddressScreenState();
}

class _AddEditAddressScreenState
    extends BaseStatefulState<_AddOrEditAddressScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final states = DropDownItems.malaysiaStates;
  UserModel? userDetails;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: widget.isAddAddress ? 'Add Address' : 'Edit Address',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget bottomNavigationBar() {
    return getBottomButton(
      isAddAddress: widget.isAddAddress,
      userDetails: userDetails ?? UserModel(),
    );
  }

  @override
  Widget body() {
    final user = context.select((UserViewModel vm) => vm.userDetails);

    final address1 = user?.address1;
    final address2 = user?.address2;
    final city = user?.city;
    final postalCode = user?.postalCode;
    final state = user?.state;

    return SingleChildScrollView(
      child: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            getAddressTextField(address1: address1 ?? ''),
            SizedBox(height: 25),
            getAddress2TextField(address2: address2 ?? ''),
            SizedBox(height: 25),
            getCityTextField(city: city ?? ''),
            SizedBox(height: 25),
            getStateDropdownField(state: state ?? states.first),
            SizedBox(height: 25),
            getPostalCodeTextField(postalCode: postalCode ?? ''),
          ],
        ),
      ),
    );
  }
}

// * ---------------------------- Helpers ----------------------------
extension _Helpers on _AddEditAddressScreenState {
  String get address1 => _formKey
      .currentState
      ?.fields[AddEditAddressFormFieldsEnum.address1.name]
      ?.value;

  String get address2 => _formKey
      .currentState
      ?.fields[AddEditAddressFormFieldsEnum.address2.name]
      ?.value;

  String get city => _formKey
      .currentState
      ?.fields[AddEditAddressFormFieldsEnum.city.name]
      ?.value;

  String get state => _formKey
      .currentState
      ?.fields[AddEditAddressFormFieldsEnum.state.name]
      ?.value;

  String get postalCode => _formKey
      .currentState
      ?.fields[AddEditAddressFormFieldsEnum.postalCode.name]
      ?.value;
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _AddEditAddressScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  Future<void> onBottomButtonPressed({required UserModel userDetails}) async {
    final formValid = _formKey.currentState?.saveAndValidate() ?? false;

    if (formValid) {
      final result =
          await tryLoad(
            context,
            () => context.read<UserViewModel>().updateUser(
              userID: userDetails.userID,
              userRole: userDetails.userRole,
              firstName: userDetails.firstName,
              lastName: userDetails.lastName,
              emailAddress: userDetails.emailAddress,
              gender: userDetails.gender,
              phoneNumber: userDetails.phoneNumber,
              password: userDetails.password,
              address1: address1,
              address2: address2,
              city: city,
              postalCode: postalCode,
              state: state,
              profileImageURL: userDetails.profileImageURL,
              point: userDetails.currentPoint,
              createdDate: userDetails.createdDate,
            ),
          ) ??
          false;

      if (result) {
        unawaited(
          WidgetUtil.showSnackBar(
            text:
                'Address ${widget.isAddAddress ? 'added' : 'updated'} successfully',
          ),
        );
        if (mounted) {
          await context.router.maybePop(true);
        }
      }
    }
  }

  Future<void> fetchData() async {
    final userVM = context.read<UserViewModel>();
    final userID = userVM.user?.userID ?? '';

    await tryLoad(context, () => userVM.getUserDetails(userID: userID));
    final userDetails = userVM.userDetails;
    _setState(() {
      this.userDetails = userDetails;
    });
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _AddEditAddressScreenState {
  Widget getAddressTextField({required String address1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          title: 'Address 1',
          fontSize: _Styles.textFieldFontSize,
          color: ColorManager.primary,
          formName: AddEditAddressFormFieldsEnum.address1.name,
          validator: FormBuilderValidators.required(),
          initialValue: address1,
        ),
        getNoteText(noteText: '*House number, floor number or building name'),
      ],
    );
  }

  Widget getAddress2TextField({required String address2}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          title: 'Address 2',
          fontSize: _Styles.textFieldFontSize,
          color: ColorManager.primary,
          formName: AddEditAddressFormFieldsEnum.address2.name,
          validator: FormBuilderValidators.required(),
          initialValue: address2,
        ),
        getNoteText(noteText: '*Street name'),
      ],
    );
  }

  Widget getCityTextField({required String city}) {
    return CustomTextField(
      title: 'City',
      fontSize: _Styles.textFieldFontSize,
      color: ColorManager.primary,
      formName: AddEditAddressFormFieldsEnum.city.name,
      validator: FormBuilderValidators.required(),
      initialValue: city,
    );
  }

  Widget getStateDropdownField({required String state}) {
    return CustomDropdown(
      formName: AddEditAddressFormFieldsEnum.state.name,
      items: states,
      title: 'State',
      fontSize: _Styles.textFieldFontSize,
      color: ColorManager.primary,
      validator: FormBuilderValidators.required(),
      initialValue: state,
    );
  }

  Widget getPostalCodeTextField({required String postalCode}) {
    return CustomTextField(
      title: 'Postal Code',
      fontSize: _Styles.textFieldFontSize,
      color: ColorManager.primary,
      formName: AddEditAddressFormFieldsEnum.postalCode.name,
      validator: FormBuilderValidators.required(),
      keyboardType: TextInputType.number,
      initialValue: postalCode,
    );
  }

  Widget getNoteText({required String noteText}) {
    return Text(noteText, style: _Styles.noteTextStyle);
  }

  Widget getBottomButton({
    required bool isAddAddress,
    required UserModel userDetails,
  }) {
    return CustomButton(
      text: isAddAddress ? 'Submit' : 'Save',
      textColor: ColorManager.whiteColor,
      onPressed: () => onBottomButtonPressed(userDetails: userDetails),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const textFieldFontSize = 18.0;

  static const noteTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );
}

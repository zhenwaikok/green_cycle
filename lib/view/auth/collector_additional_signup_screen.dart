import 'dart:async';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/mixins/error_handling_mixin.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_dropdown.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:green_cycle_fyp/widget/image_picker_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CollectorAdditionalSignupScreen extends StatelessWidget {
  const CollectorAdditionalSignupScreen({
    super.key,
    required this.userRole,
    required this.fullName,
    required this.emailAddress,
    required this.gender,
    required this.phoneNumber,
    required this.password,
  });

  final String userRole;
  final String fullName;
  final String emailAddress;
  final String gender;
  final String phoneNumber;
  final String password;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel(
        userRepository: UserRepository(
          sharePreferenceHandler: SharedPreferenceHandler(),
          userServices: UserServices(),
        ),
        firebaseRepository: FirebaseRepository(
          firebaseServices: FirebaseServices(),
        ),
      ),
      child: _CollectorAdditionalSignupScreen(
        userRole: userRole,
        fullName: fullName,
        emailAddress: emailAddress,
        gender: gender,
        phoneNumber: phoneNumber,
        password: password,
      ),
    );
  }
}

class _CollectorAdditionalSignupScreen extends StatefulWidget {
  @override
  State<_CollectorAdditionalSignupScreen> createState() =>
      _CollectorAdditionalSignupScreenState();

  const _CollectorAdditionalSignupScreen({
    required this.userRole,
    required this.fullName,
    required this.emailAddress,
    required this.gender,
    required this.phoneNumber,
    required this.password,
  });

  final String userRole;
  final String fullName;
  final String emailAddress;
  final String gender;
  final String phoneNumber;
  final String password;
}

class _CollectorAdditionalSignupScreenState
    extends State<_CollectorAdditionalSignupScreen>
    with ErrorHandlingMixin {
  final vehicleTypes = DropDownItems.vehicleTypes;
  final _formkey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Collector Additional Info',
        onPressed: backButtonPressed,
        isBackButtonVisible: true,
      ),
      bottomNavigationBar: Padding(
        padding: _Styles.screenPadding,
        child: getButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Center(
              child: FormBuilder(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getVehicleTypeDropdown(),
                    SizedBox(height: 20),
                    getVehiclePlateNumberTextField(),
                    SizedBox(height: 20),
                    getCompanyTextField(),
                    SizedBox(height: 20),
                    getFacePhotoField(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Helper ----------------------------
extension _Helper on _CollectorAdditionalSignupScreenState {
  String get vehicleType =>
      _formkey
          .currentState
          ?.fields[SignUpFormFieldsEnum.vehicleType.name]
          ?.value ??
      '';

  String get vehiclePlateNumber =>
      _formkey
          .currentState
          ?.fields[SignUpFormFieldsEnum.vehiclePlateNum.name]
          ?.value ??
      '';

  String get organizationName =>
      _formkey
          .currentState
          ?.fields[SignUpFormFieldsEnum.organizationName.name]
          ?.value ??
      '';

  File get facePhoto =>
      _formkey
          .currentState
          ?.fields[SignUpFormFieldsEnum.facePhoto.name]
          ?.value ??
      File('');
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CollectorAdditionalSignupScreenState {
  void backButtonPressed() {
    context.router.maybePop();
  }

  Future<void> onFacePhotoUploadPressed(FormFieldState<File> field) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final image = File(pickedFile.path);
      field.didChange(image);
    }
  }

  void onSubmitButtonPressed() async {
    if (_formkey.currentState?.validate() ?? false) {
      final result =
          await tryLoad(
            context,
            () => context.read<UserViewModel>().signUpWithEmailPassword(
              userRole: widget.userRole,
              fullName: widget.fullName,
              email: widget.emailAddress,
              gender: widget.gender,
              phoneNumber: widget.phoneNumber,
              password: widget.password,
              vehicleType: vehicleType,
              vehiclePlateNumber: vehiclePlateNumber,
              companyName: organizationName,
              profileImage: facePhoto,
            ),
          ) ??
          false;
      if (result) {
        if (mounted) {
          unawaited(WidgetUtil.showSnackBar(text: 'Sign Up Successful'));
          await context.router.replaceAll([
            CustomBottomNavBar(userRole: widget.userRole),
          ]);
        }
      }
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CollectorAdditionalSignupScreenState {
  Widget getVehicleTypeDropdown() {
    return CustomDropdown(
      formName: SignUpFormFieldsEnum.vehicleType.name,
      items: vehicleTypes,
      title: 'Vehicle Type',
      fontSize: _Styles.fontSize,
      color: ColorManager.primary,
      validator: FormBuilderValidators.required(),
    );
  }

  Widget getVehiclePlateNumberTextField() {
    return CustomTextField(
      fontSize: _Styles.fontSize,
      color: ColorManager.primary,
      title: 'Vehicle Plate Number',
      formName: SignUpFormFieldsEnum.vehiclePlateNum.name,
      validator: FormBuilderValidators.required(),
    );
  }

  Widget getCompanyTextField() {
    return CustomTextField(
      fontSize: _Styles.fontSize,
      color: ColorManager.primary,
      title: 'Company/Organization',
      formName: SignUpFormFieldsEnum.organizationName.name,
      validator: FormBuilderValidators.required(),
    );
  }

  Widget getFacePhotoField() {
    return FormBuilderField<File>(
      name: SignUpFormFieldsEnum.facePhoto.name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null) return '  This field cannot be empty.';
        return null;
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Upload A Clear Face Photo', style: _Styles.titleTextStyle),
            SizedBox(height: 10),
            PhotoPicker(
              onTap: () {
                onFacePhotoUploadPressed(field);
              },
              selectedImage: field.value ?? File(''),
            ),
            if (field.hasError)
              Padding(
                padding: _Styles.errorTextPadding,
                child: Text(
                  field.errorText ?? '',
                  style: _Styles.errorTextStyle,
                ),
              ),
          ],
        );
      },
    );
  }

  Widget getButton() {
    return CustomButton(
      text: 'Submit for Approval',
      textColor: ColorManager.whiteColor,
      onPressed: onSubmitButtonPressed,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const fontSize = 16.0;

  static const titleTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );
  static const errorTextStyle = TextStyle(fontSize: 12, color: Colors.red);

  static const errorTextPadding = EdgeInsets.only(top: 5);
}

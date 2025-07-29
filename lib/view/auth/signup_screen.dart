import 'dart:async';

import 'package:auto_route/auto_route.dart';
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
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_dropdown.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
      child: _SignUpScreen(),
    );
  }
}

class _SignUpScreen extends StatefulWidget {
  @override
  State<_SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<_SignUpScreen> with ErrorHandlingMixin {
  final roles = DropDownItems.roles;
  final genders = DropDownItems.genders;
  String? selectedRole;
  String? selectedGender;
  String? _phoneNumber;
  final _formKey = GlobalKey<FormBuilderState>();
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;

  @override
  void initState() {
    selectedRole = roles.first;
    selectedGender = genders.first;
    super.initState();
  }

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Center(
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    getLogo(),
                    SizedBox(height: 15),
                    getTitle(),
                    SizedBox(height: 30),
                    getSignUpForms(),
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
extension _Helper on _SignUpScreenState {
  String get userRole => selectedRole ?? '';

  String get fullName =>
      _formKey
          .currentState
          ?.fields[SignUpFormFieldsEnum.fullName.name]
          ?.value ??
      '';

  String get firstName =>
      _formKey
          .currentState
          ?.fields[SignUpFormFieldsEnum.firstName.name]
          ?.value ??
      '';

  String get lastName =>
      _formKey
          .currentState
          ?.fields[SignUpFormFieldsEnum.lastName.name]
          ?.value ??
      '';

  String get email =>
      _formKey.currentState?.fields[SignUpFormFieldsEnum.email.name]?.value ??
      '';

  String get gender => selectedGender ?? '';

  String get phoneNumber => _phoneNumber ?? '';

  String get password =>
      _formKey
          .currentState
          ?.fields[SignUpFormFieldsEnum.password.name]
          ?.value ??
      '';
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _SignUpScreenState {
  void onRoleChanged(String? value) {
    _setState(() {
      selectedRole = value;
    });
  }

  void onGenderChanged(String? value) {
    _setState(() {
      selectedGender = value;
    });
  }

  void onSignInButtonPressed() async {
    context.router.pushAndPopUntil(LoginRoute(), predicate: (route) => false);
  }

  void onSignUpButtonPressed() async {
    final formValid = _formKey.currentState?.saveAndValidate() ?? false;

    if (selectedRole == roles[1] && formValid) {
      context.router.push(
        CollectorAdditionalSignupRoute(
          userRole: userRole,
          fullName: fullName,
          emailAddress: email,
          gender: gender,
          phoneNumber: phoneNumber,
          password: password,
        ),
      );
    } else {
      if (formValid) {
        final result =
            await tryLoad(
              context,
              () => context.read<UserViewModel>().signUpWithEmailPassword(
                userRole: userRole,
                firstName: firstName,
                lastName: lastName,
                email: email,
                gender: gender,
                phoneNumber: phoneNumber,
                password: password,
              ),
            ) ??
            false;

        if (result) {
          final userRole = mounted
              ? context.read<UserViewModel>().user?.userRole ?? ''
              : '';
          if (mounted) {
            unawaited(WidgetUtil.showSnackBar(text: 'Sign Up Successful'));

            await context.router.replaceAll([
              CustomBottomNavBar(userRole: userRole),
            ]);
          }
        }
      }
    }
  }

  void togglePasswordVisibility({required bool passwordField}) {
    _setState(() {
      if (passwordField) {
        isPasswordObscure = !isPasswordObscure;
      } else {
        isConfirmPasswordObscure = !isConfirmPasswordObscure;
      }
    });
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _SignUpScreenState {
  Widget getLogo() {
    return Image.asset(
      "assets/images/GreenCycleLogo.png",
      width: _Styles.logoSize,
      height: _Styles.logoSize,
    );
  }

  Widget getTitle() {
    return Text(
      'JOIN US!',
      style: _Styles.titleTextStyle,
      textAlign: TextAlign.center,
    );
  }

  Widget getSignUpForms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCardTitleDescription(),
        SizedBox(height: 20),
        getSignUpTextField(),
        SizedBox(height: 20),
        getTextField(),
      ],
    );
  }

  Widget getCardTitleDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sign Up', style: _Styles.cardTitleTextStyle),
        SizedBox(height: 20),
        Text(
          'Enter details below to create an account.',
          style: _Styles.cardDescriptionTextStyle,
        ),
      ],
    );
  }

  Widget getSignUpTextField() {
    return Column(
      children: [
        CustomDropdown(
          formName: SignUpFormFieldsEnum.role.name,
          items: roles,
          validator: FormBuilderValidators.required(),
          title: 'Role',
          fontSize: _Styles.signUpFormFieldFontSize,
          color: _Styles.signUpFormFieldColor,
          onChanged: (value) {
            onRoleChanged(value);
          },
        ),
      ],
    );
  }

  Widget getTextField() {
    return Column(
      children: [
        getCustomerNameTextField(),
        SizedBox(height: 20),
        getEmailTextField(),
        SizedBox(height: 20),
        getGenderDropdown(),
        SizedBox(height: 20),
        getPhoneTextField(),
        SizedBox(height: 20),
        getPasswordTextField(),
        SizedBox(height: 30),
        getButtons(),
      ],
    );
  }

  Widget getGenderDropdown() {
    return CustomDropdown(
      formName: SignUpFormFieldsEnum.gender.name,
      items: genders,
      title: 'Gender',
      fontSize: _Styles.signUpFormFieldFontSize,
      color: _Styles.signUpFormFieldColor,
      validator: FormBuilderValidators.required(),
      onChanged: (value) {
        onGenderChanged(value);
      },
    );
  }

  Widget getEmailTextField() {
    return CustomTextField(
      fontSize: _Styles.signUpFormFieldFontSize,
      color: _Styles.signUpFormFieldColor,
      title: 'Email Address',
      prefixIcon: Icon(Icons.email_outlined, color: ColorManager.greyColor),
      formName: SignUpFormFieldsEnum.email.name,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.email(),
      ]),
    );
  }

  Widget getCustomerNameTextField() {
    if (selectedRole != 'Customer') {
      return CustomTextField(
        fontSize: _Styles.signUpFormFieldFontSize,
        color: _Styles.signUpFormFieldColor,
        title: 'Full Name',
        formName: SignUpFormFieldsEnum.fullName.name,
        validator: FormBuilderValidators.required(),
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: CustomTextField(
              fontSize: _Styles.signUpFormFieldFontSize,
              color: _Styles.signUpFormFieldColor,
              title: 'First Name',
              formName: SignUpFormFieldsEnum.firstName.name,
              validator: FormBuilderValidators.required(),
            ),
          ),
          SizedBox(width: 25),
          Expanded(
            child: CustomTextField(
              fontSize: _Styles.signUpFormFieldFontSize,
              color: _Styles.signUpFormFieldColor,
              title: 'Last Name',
              formName: SignUpFormFieldsEnum.lastName.name,
              validator: FormBuilderValidators.required(),
            ),
          ),
        ],
      );
    }
  }

  Widget getPhoneTextField() {
    return FormBuilderField<String>(
      name: SignUpFormFieldsEnum.phoneNum.name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        (value) {
          if (!RegexConstants.malaysianPhoneRegex.hasMatch(value ?? '')) {
            return 'Invalid phone number, only 10 or 11 digits allowed';
          }
          return null;
        },
      ]),
      builder: (FormFieldState<String> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Phone Number', style: _Styles.phoneNumTextStyle),
            const SizedBox(height: 10),
            IntlPhoneField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                contentPadding: _Styles.contentPadding,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.greyColor,
                    width: _Styles.textFieldBorderWidth,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.greyColor,
                    width: _Styles.textFieldBorderWidth,
                  ),
                ),
                errorBorder: _Styles.outlineErrorInputBorder,
                focusedErrorBorder: _Styles.outlineErrorInputBorder,
                errorText: field.errorText,
              ),
              disableLengthCheck: true,
              countries: [countries.firstWhere((c) => c.code == 'MY')],
              cursorColor: ColorManager.blackColor,
              onChanged: (phone) {
                _setState(() {
                  _phoneNumber = phone.completeNumber.trim();
                  field.didChange(_phoneNumber);
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget getPasswordTextField() {
    return Column(
      children: [
        CustomTextField(
          fontSize: _Styles.signUpFormFieldFontSize,
          color: _Styles.signUpFormFieldColor,
          title: 'Password',
          prefixIcon: Icon(Icons.lock_outline, color: ColorManager.greyColor),
          suffixIcon: getTogglePasswordButton(passwordField: true),
          isPassword: isPasswordObscure,
          formName: SignUpFormFieldsEnum.password.name,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(
              6,
              errorText: 'Password must be at least 6 characters long',
            ),
          ]),
        ),
        SizedBox(height: 20),
        CustomTextField(
          fontSize: _Styles.signUpFormFieldFontSize,
          color: _Styles.signUpFormFieldColor,
          title: 'Confirm Password',
          prefixIcon: Icon(Icons.lock_outline, color: ColorManager.greyColor),
          suffixIcon: getTogglePasswordButton(passwordField: false),
          isPassword: isConfirmPasswordObscure,
          formName: SignUpFormFieldsEnum.confirmPassword.name,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            (value) {
              final password = _formKey
                  .currentState
                  ?.fields[SignUpFormFieldsEnum.password.name]
                  ?.value;
              if (password != value) {
                return 'Password does not match';
              }
              return null;
            },
          ]),
        ),
      ],
    );
  }

  Widget getButtons() {
    return Column(
      children: [
        CustomButton(
          text: 'Sign Up',
          textColor: ColorManager.whiteColor,
          onPressed: onSignUpButtonPressed,
        ),
        TextButton(
          style: _Styles.alreadyHaveAccButtonStyle,
          onPressed: onSignInButtonPressed,
          child: RichText(
            text: const TextSpan(
              text: "Already have an account? ",
              style: _Styles.alreadyHaveAccTextStyle,
              children: [
                TextSpan(text: "Sign In", style: _Styles.signInTextStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }

  IconButton getTogglePasswordButton({required bool passwordField}) {
    return IconButton(
      onPressed: () => togglePasswordVisibility(passwordField: passwordField),
      icon: passwordField
          ? (isPasswordObscure
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility))
          : (isConfirmPasswordObscure
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility)),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const logoSize = 200.0;
  static const signUpFormFieldFontSize = 16.0;
  static const signUpFormFieldColor = ColorManager.blackColor;
  static const textFieldBorderWidth = 2.0;

  static const contentPadding = EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 10,
  );

  static final outlineErrorInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: ColorManager.redColor),
  );

  static const titleTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const cardTitleTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const cardDescriptionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const phoneNumTextStyle = TextStyle(
    fontSize: signUpFormFieldFontSize,
    fontWeight: FontWeightManager.bold,
    color: signUpFormFieldColor,
  );

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const alreadyHaveAccTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const signInTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
    decoration: TextDecoration.underline,
  );

  static final alreadyHaveAccButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(Colors.transparent),
  );
}

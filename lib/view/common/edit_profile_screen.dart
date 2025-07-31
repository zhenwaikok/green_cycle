import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/user/user_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
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
import 'package:green_cycle_fyp/widget/profile_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

@RoutePage()
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({
    super.key,
    required this.userRole,
    required this.userID,
  });

  final String userRole;
  final String userID;

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
      child: _EditProfileScreen(userRole: userRole, userID: userID),
    );
  }
}

class _EditProfileScreen extends StatefulWidget {
  const _EditProfileScreen({required this.userRole, required this.userID});

  final String userRole;
  final String userID;

  @override
  State<_EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<_EditProfileScreen>
    with ErrorHandlingMixin {
  final roles = DropDownItems.roles;
  final genders = DropDownItems.genders;
  String? _phoneNumber;
  File? _selectedImage;
  UserModel? get userDetails => context.read<UserViewModel>().userDetails;

  final _formKey = GlobalKey<FormBuilderState>();

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialLoad(userID: widget.userID);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = context.select((UserViewModel vm) => vm.userDetails);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Profile',
        isBackButtonVisible: true,
        onPressed: onBackButtonPressed,
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
                key: _formKey,
                child: Column(
                  children: [
                    if (userDetails != null) ...[
                      getProfileImage(
                        imageURL: userDetails.profileImageURL ?? '',
                      ),
                      SizedBox(height: 60),
                      getProfileTextFields(userDetails: userDetails),
                    ],
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

// * ---------------------------- Helpers ----------------------------
extension _Helpers on _EditProfileScreenState {
  File? get profileImageFile => _selectedImage;

  String? get userRole => userDetails?.userRole;

  String? get emailAddress => userDetails?.emailAddress;

  String? get password => userDetails?.password;

  String? get fullName => _formKey
      .currentState
      ?.fields[EditProfileFormFieldsEnum.fullName.name]
      ?.value;

  String? get firstName => _formKey
      .currentState
      ?.fields[EditProfileFormFieldsEnum.firstName.name]
      ?.value;

  String? get lastName => _formKey
      .currentState
      ?.fields[EditProfileFormFieldsEnum.lastName.name]
      ?.value;

  String? get gender => _formKey
      .currentState
      ?.fields[EditProfileFormFieldsEnum.gender.name]
      ?.value;

  String? get phoneNumber => _phoneNumber;

  String? get address {
    final value = _formKey
        .currentState
        ?.fields[EditProfileFormFieldsEnum.address.name]
        ?.value;
    return (value?.trim().isEmpty ?? true) ? null : value.trim();
  }

  String? get vehicleType => userDetails?.vehicleType;

  String? get vehiclePlateNumber => userDetails?.vehiclePlateNumber;

  String? get companyName => userDetails?.companyName;

  String? get profileImageURL => userDetails?.profileImageURL;

  String get approvalStatus => userDetails?.approvalStatus ?? '';

  String get accountRejectMessage => userDetails?.accountRejectMessage ?? '';

  DateTime get createdDate => userDetails?.createdDate ?? DateTime.now();
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _EditProfileScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  Future<void> onFacePhotoUploadPressed() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      _setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> initialLoad({required String userID}) async {
    await tryLoad(
      context,
      () => context.read<UserViewModel>().getUserDetails(userID: userID),
    );
    _setState(() {
      _phoneNumber = userDetails?.phoneNumber?.trim();
    });
  }

  Future<void> onSaveButtonPressed() async {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      final result =
          await tryLoad(
            context,
            () => context.read<UserViewModel>().updateUser(
              userID: widget.userID,
              firstName: firstName,
              lastName: lastName,
              gender: gender,
              phoneNumber: phoneNumber,
              address: address,
              profileImage: profileImageFile,
              emailAddress: emailAddress,
              password: password,
              userRole: userRole,
              fullName: fullName,
              vehicleType: vehicleType,
              vehiclePlateNumber: vehiclePlateNumber,
              companyName: companyName,
              profileImageURL: profileImageURL,
              approvalStatus: approvalStatus,
              accountRejectMessage: accountRejectMessage,
              createdDate: createdDate,
            ),
          ) ??
          false;

      if (result) {
        unawaited(
          WidgetUtil.showSnackBar(text: 'Profile Updated Successfully'),
        );
        if (mounted) await context.router.maybePop(true);
      } else {
        unawaited(WidgetUtil.showSnackBar(text: 'Failed to update profile'));
      }
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _EditProfileScreenState {
  Widget getProfileImage({required String imageURL}) {
    return Stack(
      children: [
        CustomProfileImage(
          imageFile: _selectedImage,
          imageURL: _selectedImage == null ? imageURL : null,
          imageSize: _Styles.imageSize,
        ),
        Positioned(
          bottom: -2,
          left: 90,
          child: Container(
            decoration: BoxDecoration(
              color: ColorManager.lightGreyColor2,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: onFacePhotoUploadPressed,
              icon: Icon(
                Icons.camera_alt,
                color: ColorManager.blackColor,
                size: _Styles.cameraIconSize,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getProfileTextFields({required UserModel userDetails}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCustomerNameTextField(
          fullName: userDetails.fullName ?? '',
          firstName: userDetails.firstName ?? '',
          lastName: userDetails.lastName ?? '',
        ),
        SizedBox(height: 20),
        getEmailText(email: userDetails.emailAddress ?? ''),
        SizedBox(height: 20),
        getGenderDropdown(gender: userDetails.gender ?? ''),
        if (widget.userRole == 'Customer') ...[
          SizedBox(height: 20),
          getPhoneTextField(phoneNumber: userDetails.phoneNumber ?? ''),
          SizedBox(height: 20),
          getAddressTextField(address: userDetails.address ?? ''),
        ],
        if (widget.userRole == 'Collector') ...[
          SizedBox(height: 20),
          getCollectorAdditionalInfo(
            vehicleNumber: userDetails.vehiclePlateNumber ?? '',
            companyName: userDetails.companyName ?? '',
            vehicleType: userDetails.vehicleType ?? '',
          ),
        ],
      ],
    );
  }

  Widget getGenderDropdown({required String gender}) {
    return CustomDropdown(
      formName: EditProfileFormFieldsEnum.gender.name,
      items: genders,
      title: 'Gender',
      fontSize: _Styles.editProfileFormFieldFontSize,
      color: _Styles.editProfileFormFieldColor,
      initialValue: gender,
    );
  }

  Widget getEmailText({required String email}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email Address', style: _Styles.titleTextStyle),
        SizedBox(height: 5),
        Text(email, style: _Styles.valueTextStyle),
      ],
    );
  }

  Widget getCustomerNameTextField({
    required String fullName,
    required String firstName,
    required String lastName,
  }) {
    if (widget.userRole != 'Customer') {
      return CustomTextField(
        fontSize: _Styles.editProfileFormFieldFontSize,
        color: _Styles.editProfileFormFieldColor,
        title: 'Full Name',
        formName: EditProfileFormFieldsEnum.fullName.name,
        initialValue: fullName,
        validator: FormBuilderValidators.required(),
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: CustomTextField(
              fontSize: _Styles.editProfileFormFieldFontSize,
              color: _Styles.editProfileFormFieldColor,
              title: 'First Name',
              formName: EditProfileFormFieldsEnum.firstName.name,
              initialValue: firstName,
              validator: FormBuilderValidators.required(),
            ),
          ),
          SizedBox(width: 25),
          Expanded(
            child: CustomTextField(
              fontSize: _Styles.editProfileFormFieldFontSize,
              color: _Styles.editProfileFormFieldColor,
              title: 'Last Name',
              formName: EditProfileFormFieldsEnum.lastName.name,
              initialValue: lastName,
              validator: FormBuilderValidators.required(),
            ),
          ),
        ],
      );
    }
  }

  Widget getPhoneTextField({required String phoneNumber}) {
    return FormBuilderField<String>(
      name: EditProfileFormFieldsEnum.phoneNum.name,
      initialValue: phoneNumber.isNotEmpty ? phoneNumber : null,
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
              initialValue: phoneNumber,
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

  Widget getAddressTextField({required String address}) {
    return CustomTextField(
      fontSize: _Styles.editProfileFormFieldFontSize,
      color: _Styles.editProfileFormFieldColor,
      title: 'Address',
      prefixIcon: Icon(Icons.location_on, color: ColorManager.blackColor),
      formName: EditProfileFormFieldsEnum.address.name,
      initialValue: address,
    );
  }

  Widget getCollectorAdditionalInfo({
    required String vehicleNumber,
    required String companyName,
    required String vehicleType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCollectorAdditionalInfoItem(
          title: 'Vehicle Plate Number',
          value: vehicleNumber,
        ),
        SizedBox(height: 20),
        getCollectorAdditionalInfoItem(
          title: 'Company/Organization',
          value: companyName,
        ),
        SizedBox(height: 20),
        getCollectorAdditionalInfoItem(
          title: 'Vehicle Type',
          value: vehicleType,
        ),
      ],
    );
  }

  Widget getCollectorAdditionalInfoItem({
    required String title,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _Styles.titleTextStyle),
        SizedBox(height: 5),
        Text(value, style: _Styles.valueTextStyle),
      ],
    );
  }

  Widget getButton() {
    return CustomButton(
      text: 'Save',
      textColor: ColorManager.whiteColor,
      onPressed: onSaveButtonPressed,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const cameraIconSize = 25.0;
  static const imageSize = 150.0;

  static const editProfileFormFieldFontSize = 16.0;
  static const editProfileFormFieldColor = ColorManager.blackColor;
  static const textFieldBorderWidth = 2.0;

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static final outlineErrorInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: ColorManager.redColor),
  );

  static const contentPadding = EdgeInsets.symmetric(horizontal: 10);

  static const phoneNumTextStyle = TextStyle(
    fontSize: editProfileFormFieldFontSize,
    fontWeight: FontWeightManager.bold,
    color: editProfileFormFieldColor,
  );

  static const titleTextStyle = TextStyle(
    fontSize: editProfileFormFieldFontSize,
    fontWeight: FontWeightManager.bold,
    color: editProfileFormFieldColor,
  );

  static const valueTextStyle = TextStyle(
    fontSize: editProfileFormFieldFontSize,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );
}

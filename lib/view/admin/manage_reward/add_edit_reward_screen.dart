import 'dart:async';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/reward/reward_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/reward_repository.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/reward_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_date_picker_field.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:green_cycle_fyp/widget/image_picker_widget.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

@RoutePage()
class AddOrEditRewardScreen extends StatelessWidget {
  const AddOrEditRewardScreen({super.key, required this.isEdit, this.rewardId});

  final bool isEdit;
  final int? rewardId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RewardViewModel(
        rewardRepository: RewardRepository(),
        firebaseRepository: FirebaseRepository(
          firebaseServices: FirebaseServices(),
        ),
      ),
      child: _AddOrEditRewardScreen(isEdit: isEdit, rewardId: rewardId ?? 0),
    );
  }
}

class _AddOrEditRewardScreen extends BaseStatefulPage {
  const _AddOrEditRewardScreen({required this.isEdit, this.rewardId});

  final bool isEdit;
  final int? rewardId;

  @override
  State<_AddOrEditRewardScreen> createState() => _AddEditRewardScreenState();
}

class _AddEditRewardScreenState
    extends BaseStatefulState<_AddOrEditRewardScreen> {
  RewardModel? _rewardDetails;
  double sliderValue = 100;
  final _formKey = GlobalKey<FormBuilderState>();

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      initialLoad();
    }
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: widget.isEdit ? 'Edit Reward' : 'Add Reward',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget bottomNavigationBar() {
    return getAddButton();
  }

  @override
  Widget body() {
    return SingleChildScrollView(
      child: FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.isEdit) ...[
              getTitleDescription(),
              SizedBox(height: 35),
              getAddRewardField(),
            ],

            if (widget.isEdit && _rewardDetails != null) ...[
              getEditRewardField(),
            ],
          ],
        ),
      ),
    );
  }
}

// * ---------------------------- Helpers ----------------------------
extension _Helpers on _AddEditRewardScreenState {
  File? get rewardImage => _formKey
      .currentState
      ?.fields[AddEditRewardFormFieldsEnum.rewardPhoto.name]
      ?.value;

  String get rewardName =>
      _formKey
          .currentState
          ?.fields[AddEditRewardFormFieldsEnum.rewardTitle.name]
          ?.value ??
      '';

  String get rewardDescription =>
      _formKey
          .currentState
          ?.fields[AddEditRewardFormFieldsEnum.rewardDescription.name]
          ?.value ??
      '';

  DateTime get rewardExpiryDate => _formKey
      .currentState
      ?.fields[AddEditRewardFormFieldsEnum.rewardExpiryDate.name]
      ?.value;

  int get pointsRequired => sliderValue.round();

  String get rewardImageURL => _rewardDetails?.rewardImageURL ?? '';

  DateTime get createdDate => _rewardDetails?.createdDate ?? DateTime.now();

  bool get isActive => _rewardDetails?.isActive ?? false;
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _AddEditRewardScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  Future<void> initialLoad() async {
    final rewardDetails = await tryLoad(
      context,
      () => context.read<RewardViewModel>().getRewardDetails(
        rewardID: widget.rewardId ?? 0,
      ),
    );

    if (rewardDetails != null) {
      _setState(() {
        _rewardDetails = rewardDetails;
        sliderValue = rewardDetails.pointsRequired?.toDouble() ?? 100;
      });
    }
  }

  Future<void> onPhotoUploadPressed(FormFieldState<File> field) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final image = File(pickedFile.path);
      field.didChange(image);
    }
  }

  void onSliderChanged(double value) {
    _setState(() {
      sliderValue = value;
    });
  }

  Future<void> onAddButtonPressed() async {
    final formValid = _formKey.currentState?.saveAndValidate() ?? false;
    if (formValid) {
      if (!widget.isEdit) {
        final result =
            await tryLoad(
              context,
              () => context.read<RewardViewModel>().insertReward(
                rewardImage: rewardImage,
                rewardName: rewardName,
                rewardDescription: rewardDescription,
                pointsRequired: pointsRequired,
                expiryDate: rewardExpiryDate,
              ),
            ) ??
            false;

        if (result) {
          unawaited(WidgetUtil.showSnackBar(text: 'Reward added successfully'));
          if (mounted) {
            context.router.maybePop(true);
          }
        } else {
          unawaited(WidgetUtil.showSnackBar(text: 'Failed to add reward'));
        }
      } else {
        final result =
            await tryLoad(
              context,
              () => context.read<RewardViewModel>().updateReward(
                rewardID: widget.rewardId ?? 0,
                rewardName: rewardName,
                rewardDescription: rewardDescription,
                pointsRequired: pointsRequired,
                rewardImageURL: rewardImageURL,
                createdDate: createdDate,
                expiryDate: rewardExpiryDate,
                isActive: isActive,
                rewardImage: rewardImage,
              ),
            ) ??
            false;

        if (result) {
          unawaited(
            WidgetUtil.showSnackBar(text: 'Reward updated successfully'),
          );
          if (mounted) {
            context.router.maybePop(true);
          }
        } else {
          unawaited(WidgetUtil.showSnackBar(text: 'Failed to update reward'));
        }
      }
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _AddEditRewardScreenState {
  Widget getAddRewardField() {
    return Column(
      children: [
        getPhotoField(isEdit: widget.isEdit),
        SizedBox(height: 25),
        getRewardTitleField(),
        SizedBox(height: 25),
        getRewardDescriptionField(),
        SizedBox(height: 25),
        getPointsRequiredField(),
        SizedBox(height: 25),
        getExpiryDateField(),
      ],
    );
  }

  Widget getEditRewardField() {
    return Column(
      children: [
        getPhotoField(
          rewardImageURL: _rewardDetails?.rewardImageURL ?? '',
          isEdit: widget.isEdit,
        ),
        SizedBox(height: 25),
        getRewardTitleField(rewardName: _rewardDetails?.rewardName ?? ''),
        SizedBox(height: 25),
        getRewardDescriptionField(
          rewardDescription: _rewardDetails?.rewardDescription ?? '',
        ),
        SizedBox(height: 25),
        getPointsRequiredField(),
        SizedBox(height: 25),
        getExpiryDateField(
          expiryDate: _rewardDetails?.expiryDate ?? DateTime.now(),
        ),
      ],
    );
  }

  Widget getTitleDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Add Reward', style: _Styles.titleTextStyle),
        Text(
          'Fill in the details below to add reward.',
          style: _Styles.descriptionTextStyle,
        ),
      ],
    );
  }

  Widget getPhotoField({String? rewardImageURL, required bool isEdit}) {
    return FormBuilderField<File>(
      name: AddEditRewardFormFieldsEnum.rewardPhoto.name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null && !isEdit) return '  This field cannot be empty.';
        return null;
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reward Photo', style: _Styles.titleTextStyle),
            if (isEdit)
              Text('**Tap photo to change', style: _Styles.noteTextStyle),
            SizedBox(height: 10),

            rewardImageURL != null && field.value == null
                ? TouchableOpacity(
                    onPressed: () => onPhotoUploadPressed(field),
                    child: CustomImage(
                      imageURL: rewardImageURL,
                      imageWidth: double.infinity,
                      imageSize: _Styles.imageHeight,
                    ),
                  )
                : PhotoPicker(
                    borderRadius: _Styles.borderRadius,
                    onTap: () {
                      onPhotoUploadPressed(field);
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

  Widget getRewardTitleField({String? rewardName}) {
    return CustomTextField(
      title: 'Reward Title',
      fontSize: 18,
      color: ColorManager.primary,
      formName: AddEditRewardFormFieldsEnum.rewardTitle.name,
      validator: FormBuilderValidators.required(),
      initialValue: rewardName,
    );
  }

  Widget getRewardDescriptionField({String? rewardDescription}) {
    return CustomTextField(
      title: 'Reward Description',
      fontSize: 18,
      color: ColorManager.primary,
      formName: AddEditRewardFormFieldsEnum.rewardDescription.name,
      validator: FormBuilderValidators.required(),
      initialValue: rewardDescription,
    );
  }

  Widget getAddButton() {
    return CustomButton(
      text: widget.isEdit ? 'Save' : 'Add',
      textColor: ColorManager.whiteColor,
      onPressed: onAddButtonPressed,
    );
  }

  Widget getPointsRequiredField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Points Required: ',
            style: _Styles.titleTextStyle,
            children: [
              TextSpan(
                text: '${sliderValue.round()}',
                style: _Styles.pointsTextStyle,
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Slider(
          padding: _Styles.sliderPadding,
          activeColor: ColorManager.primary,
          value: sliderValue,
          min: 50,
          max: 500,
          onChanged: (value) {
            onSliderChanged(value);
          },
        ),
      ],
    );
  }

  Widget getExpiryDateField({DateTime? expiryDate}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reward Expiry Date', style: _Styles.titleTextStyle),
        SizedBox(height: 15),
        CustomDatePickerField(
          formName: AddEditRewardFormFieldsEnum.rewardExpiryDate.name,
          suffixIcon: Icon(
            Icons.calendar_today,
            color: ColorManager.greyColor,
            size: _Styles.datePickerIconSize,
          ),
          initialValue: expiryDate,
        ),
      ],
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const borderRadius = 15.0;
  static const datePickerIconSize = 20.0;
  static const imageHeight = 200.0;
  static const sliderPadding = EdgeInsets.zero;
  static const errorTextPadding = EdgeInsets.only(top: 5);

  static const errorTextStyle = TextStyle(fontSize: 12, color: Colors.red);

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

  static const pointsTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.greyColor,
  );

  static const noteTextStyle = TextStyle(
    fontSize: 15,
    color: ColorManager.greyColor,
  );
}

import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/awareness/awareness_model.dart';
import 'package:green_cycle_fyp/repository/awareness_repository.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/services/awareness_services.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/utils/mixins/error_handling_mixin.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/viewmodel/awareness_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:green_cycle_fyp/widget/image_picker_widget.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

@RoutePage()
class AddOrEditAwarenessScreen extends StatelessWidget {
  const AddOrEditAwarenessScreen({
    super.key,
    required this.isEdit,
    this.awarenessId,
  });

  final bool isEdit;
  final int? awarenessId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AwarenessViewModel(
        awarenessRepository: AwarenessRepository(
          awarenessServices: AwarenessServices(),
        ),
        firebaseRepository: FirebaseRepository(
          firebaseServices: FirebaseServices(),
        ),
      ),
      child: _AddOrEditAwarenessScreen(
        isEdit: isEdit,
        awarenessId: awarenessId ?? 0,
      ),
    );
  }
}

class _AddOrEditAwarenessScreen extends StatefulWidget {
  const _AddOrEditAwarenessScreen({
    required this.isEdit,
    required this.awarenessId,
  });

  final bool isEdit;
  final int awarenessId;

  @override
  State<_AddOrEditAwarenessScreen> createState() =>
      _AddOrEditAwarenessScreenState();
}

class _AddOrEditAwarenessScreenState extends State<_AddOrEditAwarenessScreen>
    with ErrorHandlingMixin {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isEdit) {
        initialLoad(awarenessID: widget.awarenessId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final awarenessDetails = context.select(
      (AwarenessViewModel vm) => vm.awarenessDetails,
    );
    print('awarenessDetails: $awarenessDetails');

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.isEdit
            ? 'Edit Awareness Content'
            : 'Add Awareness Content',
        isBackButtonVisible: true,
        onPressed: onBackButtonPressed,
      ),
      bottomNavigationBar: Padding(
        padding: _Styles.screenPadding,
        child: getAddButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: _Styles.screenPadding,
            child: FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!widget.isEdit) ...[
                    getTitleDescription(),
                    SizedBox(height: 35),
                    getAddAwarenessField(),
                  ],
                  if (awarenessDetails != null && widget.isEdit) ...[
                    getEditAwarenessField(
                      awarenessDetails: awarenessDetails,
                      isEdit: widget.isEdit,
                    ),
                  ],
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
extension _Helpers on _AddOrEditAwarenessScreenState {
  String get awarenessTitle =>
      _formKey
          .currentState
          ?.fields[AddEditAwarenessFormFieldsEnum.awarenessTitle.name]
          ?.value ??
      '';

  String get awarenessContent =>
      _formKey
          .currentState
          ?.fields[AddEditAwarenessFormFieldsEnum.awarenessContent.name]
          ?.value ??
      '';

  File? get awarenessImage => _formKey
      .currentState
      ?.fields[AddEditAwarenessFormFieldsEnum.awarenessPhoto.name]
      ?.value;
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _AddOrEditAwarenessScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
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

  Future<void> initialLoad({required int awarenessID}) async {
    await tryLoad(
      context,
      () => context.read<AwarenessViewModel>().getAwarenessDetails(
        awarenessID: awarenessID,
      ),
    );
  }

  void onAddButtonPressed() async {
    final formValid = _formKey.currentState?.saveAndValidate() ?? false;
    if (formValid) {
      if (!widget.isEdit) {
        final result =
            await tryLoad(
              context,
              () => context.read<AwarenessViewModel>().addAwareness(
                awarenessTitle: awarenessTitle,
                awarenessContent: awarenessContent,
                image: awarenessImage,
              ),
            ) ??
            false;
        if (result) {
          unawaited(
            WidgetUtil.showSnackBar(
              text: widget.isEdit
                  ? 'Awareness content updated successfully'
                  : 'Awareness content added successfully',
            ),
          );
          if (mounted) await context.router.maybePop(result);
        } else {
          unawaited(
            WidgetUtil.showSnackBar(
              text: widget.isEdit
                  ? 'Failed to update awareness content, please try again.'
                  : 'Failed to add awareness content, please try again.',
            ),
          );
        }
      } else {
        final result =
            await tryLoad(
              context,
              () => context.read<AwarenessViewModel>().updateAwareness(
                awarenessID: widget.awarenessId,
                awarenessTitle: awarenessTitle,
                awarenessContent: awarenessContent,
                awarenessImage: awarenessImage,
              ),
            ) ??
            false;

        if (result) {
          unawaited(
            WidgetUtil.showSnackBar(
              text: 'Awareness content updated successfully',
            ),
          );
          if (mounted) await context.router.maybePop(result);
        } else {
          unawaited(
            WidgetUtil.showSnackBar(
              text: 'Failed to update awareness content, please try again.',
            ),
          );
        }
      }
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _AddOrEditAwarenessScreenState {
  Widget getAddAwarenessField() {
    return Column(
      children: [
        getPhotoField(awarenessImageURL: null, isEdit: false),
        SizedBox(height: 25),
        getAwarenessTitleField(awarenessTitle: null),
        SizedBox(height: 25),
        getAwarenessContentField(awarenessContent: null),
      ],
    );
  }

  Widget getEditAwarenessField({
    required AwarenessModel awarenessDetails,
    required bool isEdit,
  }) {
    return Column(
      children: [
        getPhotoField(
          awarenessImageURL: awarenessDetails.awarenessImageURL ?? '',
          isEdit: isEdit,
        ),
        SizedBox(height: 25),
        getAwarenessTitleField(
          awarenessTitle: awarenessDetails.awarenessTitle ?? '',
        ),
        SizedBox(height: 25),
        getAwarenessContentField(
          awarenessContent: awarenessDetails.awarenessContent ?? '',
        ),
      ],
    );
  }

  Widget getTitleDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Add Awareness Content', style: _Styles.titleTextStyle),
        Text(
          'Fill in the details below to add awareness content.',
          style: _Styles.descriptionTextStyle,
        ),
      ],
    );
  }

  Widget getPhotoField({String? awarenessImageURL, required bool isEdit}) {
    return FormBuilderField<File>(
      name: AddEditAwarenessFormFieldsEnum.awarenessPhoto.name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null && !isEdit) return '  This field cannot be empty.';
        return null;
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Awareness Photo', style: _Styles.itemListingTitleTextStyle),
            SizedBox(height: 10),

            awarenessImageURL != null && field.value == null
                ? TouchableOpacity(
                    onPressed: () => onPhotoUploadPressed(field),
                    child: CustomImage(
                      imageURL: awarenessImageURL,
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

  Widget getAwarenessTitleField({String? awarenessTitle}) {
    return CustomTextField(
      title: 'Awareness Title',
      fontSize: 18,
      color: ColorManager.primary,
      formName: AddEditAwarenessFormFieldsEnum.awarenessTitle.name,
      initialValue: awarenessTitle,
      validator: FormBuilderValidators.required(),
    );
  }

  Widget getAwarenessContentField({String? awarenessContent}) {
    return CustomTextField(
      title: 'Awareness Content',
      fontSize: 18,
      color: ColorManager.primary,
      formName: AddEditAwarenessFormFieldsEnum.awarenessContent.name,
      initialValue: awarenessContent,
      validator: FormBuilderValidators.required(),
    );
  }

  Widget getAddButton() {
    return CustomButton(
      text: widget.isEdit ? 'Save' : 'Add',
      textColor: ColorManager.whiteColor,
      onPressed: onAddButtonPressed,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const borderRadius = 15.0;

  static const imageHeight = 200.0;

  static const itemListingTitleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

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

  static const errorTextStyle = TextStyle(fontSize: 12, color: Colors.red);

  static const errorTextPadding = EdgeInsets.only(top: 5);
}

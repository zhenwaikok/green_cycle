import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:green_cycle_fyp/widget/item_photo_add_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

@RoutePage()
class AddOrEditAwarenessScreen extends StatefulWidget {
  const AddOrEditAwarenessScreen({super.key, required this.isEdit});

  final bool isEdit;

  @override
  State<AddOrEditAwarenessScreen> createState() =>
      _AddOrEditAwarenessScreenState();
}

class _AddOrEditAwarenessScreenState extends State<AddOrEditAwarenessScreen> {
  late MultiImagePickerController controller;

  //TODO: Put this 2 methods in to VM later
  Future<List<XFile>> pickMultipleImages(int pickCount) async {
    final ImagePicker imagePicker = ImagePicker();
    final List<XFile> images = await imagePicker.pickMultiImage();
    return images;
  }

  //TODO: Put this 2 methods in to VM later
  ImageFile convertToImageFile(XFile file) {
    return ImageFile(
      UniqueKey().toString(),
      name: file.name,
      extension: file.path.split('.').last,
      bytes: File(file.path).readAsBytesSync(),
    );
  }

  @override
  void initState() {
    controller = MultiImagePickerController(
      maxImages: 1,
      picker: (int pickCount, Object? params) async {
        final pickedImages = await pickMultipleImages(pickCount);

        return pickedImages.map((e) => convertToImageFile(e)).toList();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!widget.isEdit) ...[
                  getTitleDescription(),
                  SizedBox(height: 35),
                ],
                getPhotoField(),
                SizedBox(height: 10),
                getAwarenessTitleField(),
                SizedBox(height: 25),
                getAwarenessContentField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _AddOrEditAwarenessScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _AddOrEditAwarenessScreenState {
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

  Widget getPhotoField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Photo(s)', style: _Styles.itemListingTitleTextStyle),
        SizedBox(height: 10),
        getMultiImagePickerView(context: context),
      ],
    );
  }

  Widget getMultiImagePickerView({required BuildContext context}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: MultiImagePickerView(
        controller: controller,
        builder: (context, ImageFile imageFile) {
          return DefaultDraggableItemWidget(
            imageFile: imageFile,
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            closeButtonAlignment: Alignment.topRight,
            fit: BoxFit.cover,
            closeButtonIcon: Icon(Icons.close, color: ColorManager.blackColor),
            closeButtonBoxDecoration: null,
            showCloseButton: true,
            closeButtonMargin: _Styles.closeButtonPadding,
            closeButtonPadding: _Styles.closeButtonPadding,
          );
        },
        initialWidget: getAddPhotoButton(),
        addMoreButton: getAddPhotoButton(),
      ),
    );
  }

  Widget getAddPhotoButton() {
    return InkWell(onTap: controller.pickImages, child: ItemPhotoAddButton());
  }

  Widget getAwarenessTitleField() {
    return CustomTextField(
      title: 'Awareness Title',
      fontSize: 18,
      color: ColorManager.primary,
      formName: AddAwarenessFormFieldsEnum.awarenessTitle.name,
    );
  }

  Widget getAwarenessContentField() {
    return CustomTextField(
      title: 'Awareness Content',
      fontSize: 18,
      color: ColorManager.primary,
      formName: AddAwarenessFormFieldsEnum.awarenessContent.name,
    );
  }

  Widget getAddButton() {
    return CustomButton(
      text: widget.isEdit ? 'Save' : 'Add',
      textColor: ColorManager.whiteColor,
      onPressed: () {},
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const closeButtonPadding = EdgeInsets.all(3);

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
}

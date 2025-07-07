import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_dropdown.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:green_cycle_fyp/widget/item_photo_add_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

@RoutePage()
class EditListingScreen extends StatefulWidget {
  const EditListingScreen({super.key});

  @override
  State<EditListingScreen> createState() => _EditListingScreenState();
}

class _EditListingScreenState extends State<EditListingScreen> {
  late MultiImagePickerController controller;

  final List<String> conditionItems = [
    'Brand New',
    'Like New',
    'Very Good',
    'Good',
  ];

  final List<String> categoryItems = [
    'Large Household Appliances',
    'Small Household Appliances',
    'Consumer Electronics',
    'Information & Communication Technology (ICT)',
    'Lighting Equipment',
    'Batteries & Accumulators',
    'Electrical & Electronic Tools',
    'Medical Devices',
    'Monitoring & Control Instruments',
  ];

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
      maxImages: 3,
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
        title: 'Edit Listing',
        isBackButtonVisible: true,
        onPressed: onBackButtonPressed,
      ),
      bottomNavigationBar: Padding(
        padding: _Styles.screenPadding,
        child: getSaveButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [getListingTextFields()],
            ),
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _EditListingScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _EditListingScreenState {
  Widget getListingTextFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getItemPhotoField(),
        SizedBox(height: 5),
        CustomTextField(
          fontSize: _Styles.createListingFormFieldFontSize,
          color: _Styles.createListingFormFieldColor,
          title: 'Item Name',
          formName: EditListingFormFieldsEnum.name.name,
        ),
        SizedBox(height: 15),
        CustomTextField(
          fontSize: _Styles.createListingFormFieldFontSize,
          color: _Styles.createListingFormFieldColor,
          title: 'Description',
          formName: EditListingFormFieldsEnum.description.name,
        ),
        SizedBox(height: 15),
        CustomTextField(
          fontSize: _Styles.createListingFormFieldFontSize,
          color: _Styles.createListingFormFieldColor,
          title: 'Price',
          formName: EditListingFormFieldsEnum.price.name,
        ),
        SizedBox(height: 15),
        CustomDropdown(
          formName: EditListingFormFieldsEnum.condition.name,
          items: conditionItems,
          title: 'Condition',
          fontSize: _Styles.createListingFormFieldFontSize,
          color: _Styles.createListingFormFieldColor,
        ),
        SizedBox(height: 15),
        CustomDropdown(
          formName: EditListingFormFieldsEnum.category.name,
          items: categoryItems,
          title: 'Category',
          fontSize: _Styles.createListingFormFieldFontSize,
          color: _Styles.createListingFormFieldColor,
        ),
      ],
    );
  }

  Widget getItemPhotoField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Item Photo(s)', style: _Styles.itemListingTitleTextStyle),
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

  Widget getSaveButton() {
    return CustomButton(
      text: 'Save',
      textColor: ColorManager.whiteColor,
      onPressed: () {},
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const createListingFormFieldFontSize = 18.0;
  static const createListingFormFieldColor = ColorManager.primary;

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const closeButtonPadding = EdgeInsets.all(3);

  static const itemListingTitleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );
}

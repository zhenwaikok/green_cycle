import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_dropdown.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:green_cycle_fyp/widget/item_photo_add_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

@RoutePage()
class CreateListingScreen extends StatelessWidget {
  const CreateListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _CreateListingScreen();
  }
}

class _CreateListingScreen extends BaseStatefulPage {
  @override
  State<_CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState
    extends BaseStatefulState<_CreateListingScreen> {
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
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Create Listing',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget bottomNavigationBar() {
    return getSubmitButton();
  }

  @override
  Widget body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getItemListingTitleDescription(),
          SizedBox(height: 20),
          getListingTextFields(),
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CreateListingScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CreateListingScreenState {
  Widget getItemListingTitleDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Item Listing', style: _Styles.itemListingTitleTextStyle),
        Text(
          'Fill in the details below to list your item for sale',
          style: _Styles.itemListingDescTextStyle,
        ),
      ],
    );
  }

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
          formName: CreateListingFormFieldsEnum.name.name,
        ),
        SizedBox(height: 15),
        CustomTextField(
          fontSize: _Styles.createListingFormFieldFontSize,
          color: _Styles.createListingFormFieldColor,
          title: 'Description',
          formName: CreateListingFormFieldsEnum.description.name,
        ),
        SizedBox(height: 15),
        CustomTextField(
          fontSize: _Styles.createListingFormFieldFontSize,
          color: _Styles.createListingFormFieldColor,
          title: 'Price',
          formName: CreateListingFormFieldsEnum.price.name,
        ),
        SizedBox(height: 15),
        CustomDropdown(
          formName: CreateListingFormFieldsEnum.condition.name,
          items: conditionItems,
          title: 'Condition',
          fontSize: _Styles.createListingFormFieldFontSize,
          color: _Styles.createListingFormFieldColor,
        ),
        SizedBox(height: 15),
        CustomDropdown(
          formName: CreateListingFormFieldsEnum.category.name,
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

  Widget getSubmitButton() {
    return CustomButton(
      text: 'Submit',
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
  static const closeButtonPadding = EdgeInsets.all(3);

  static const itemListingTitleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const itemListingDescTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}

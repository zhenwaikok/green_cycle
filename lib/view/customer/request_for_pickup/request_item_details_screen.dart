import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_dropdown.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:green_cycle_fyp/widget/item_photo_add_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

@RoutePage()
class RequestItemDetailsScreen extends StatefulWidget {
  const RequestItemDetailsScreen({super.key});

  @override
  State<RequestItemDetailsScreen> createState() =>
      _RequestItemDetailsScreenState();
}

class _RequestItemDetailsScreenState extends State<RequestItemDetailsScreen> {
  late MultiImagePickerController controller;

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
        title: 'Item Details',
        isBackButtonVisible: true,
        onPressed: onBackButtonPressed,
      ),
      bottomNavigationBar: Padding(
        padding: _Styles.screenPadding,
        child: getNextButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: _Styles.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getTitle(),
                SizedBox(height: 35),
                getItemPhotoField(),
                SizedBox(height: 10),
                getItemDescriptionSection(),
                SizedBox(height: 25),
                getCategorySection(),
                SizedBox(height: 25),
                getQuantitySection(),
                SizedBox(height: 25),
                getConditionInfoSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _RequestItemDetailsScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onNextButtonPressed() {
    context.router.push(RequestSummaryRoute());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _RequestItemDetailsScreenState {
  Widget getTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Provide Item Details', style: _Styles.titleTextStyle),
        Text(
          'Provide clear and accurate information about the e-waste item you wish to recycle to help collectors understand the nature of the item and ensure proper handling during pickup.',
          style: _Styles.descriptionTextStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget getItemPhotoField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Item Photo(s)', style: _Styles.sectionTitleTextStyle),
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

  Widget getItemDescriptionSection() {
    return getSectionTextField(
      title: 'Item Description (Eg: Brand, Model and etc)',
      formName: RequestForPickupFormFieldsEnum.itemDescription.name,
      icon: Icons.description,
    );
  }

  Widget getCategorySection() {
    return Column(
      children: [
        getSectionTitle(title: 'Category', icon: Icons.category_outlined),
        CustomDropdown(
          formName: RequestForPickupFormFieldsEnum.category.name,
          items: categoryItems,
        ),
      ],
    );
  }

  Widget getQuantitySection() {
    return getSectionTextField(
      title: 'Quantity',
      formName: RequestForPickupFormFieldsEnum.quantity.name,
      icon: Icons.pie_chart,
      keyboardType: TextInputType.number,
    );
  }

  Widget getConditionInfoSection() {
    return getSectionTextField(
      title: 'Condition & Usage Info (Condition, Year of Usage and etc)',
      formName: RequestForPickupFormFieldsEnum.conditionInfo.name,
      icon: Icons.info,
    );
  }

  Widget getSectionTextField({
    required String title,
    required String formName,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Column(
      children: [
        getSectionTitle(title: title, icon: icon),
        SizedBox(height: 5),
        CustomTextField(
          fontSize: 15,
          color: ColorManager.primary,
          formName: formName,
          needTitle: false,
          keyboardType: keyboardType,
        ),
      ],
    );
  }

  Widget getSectionTitle({required String title, required IconData icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, color: ColorManager.primary, size: _Styles.iconSize),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            title,
            style: _Styles.sectionTitleTextStyle,
            maxLines: _Styles.maxTextLines,
          ),
        ),
      ],
    );
  }

  Widget getNextButton() {
    return CustomButton(
      text: 'Next',
      textColor: ColorManager.whiteColor,
      onPressed: onNextButtonPressed,
      backgroundColor: ColorManager.primary,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const iconSize = 30.0;
  static const maxTextLines = 2;

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const closeButtonPadding = EdgeInsets.all(3);

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
}

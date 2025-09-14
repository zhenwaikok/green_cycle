import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/pickup_request_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_dropdown.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:green_cycle_fyp/widget/item_photo_add_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:provider/provider.dart';

@RoutePage()
class RequestItemDetailsScreen extends StatelessWidget {
  const RequestItemDetailsScreen({super.key, required this.isEdit});

  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return _RequestItemDetailsScreen(isEdit: isEdit);
  }
}

class _RequestItemDetailsScreen extends BaseStatefulPage {
  const _RequestItemDetailsScreen({required this.isEdit});

  final bool isEdit;

  @override
  State<_RequestItemDetailsScreen> createState() =>
      _RequestItemDetailsScreenState();
}

class _RequestItemDetailsScreenState
    extends BaseStatefulState<_RequestItemDetailsScreen> {
  late MultiImagePickerController controller;
  final _formkey = GlobalKey<FormBuilderState>();
  final categoryItems = DropDownItems.itemCategoryItems;
  bool hasEdited = false;

  List<XFile> images = [];
  String? initialPickupItemDescription;
  String? initialPickupItemCategory;
  int? initialPickupItemQuantity;
  String? initialPickupItemCondition;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    imageControllerSetup();
    loadData();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Item Details',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget bottomNavigationBar() {
    return getNextButton(isEdit: widget.isEdit);
  }

  @override
  Widget body() {
    return SingleChildScrollView(
      child: FormBuilder(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTitle(),
            SizedBox(height: 35),
            getItemPhotoField(),
            SizedBox(height: 25),
            getItemDescriptionSection(
              itemDescription: initialPickupItemDescription ?? '',
            ),
            SizedBox(height: 25),
            getCategorySection(
              itemCategory: initialPickupItemCategory ?? categoryItems.first,
            ),
            SizedBox(height: 25),
            getQuantitySection(quantity: initialPickupItemQuantity ?? 1),
            SizedBox(height: 25),
            getConditionInfoSection(
              conditionInfo: initialPickupItemCondition ?? '',
            ),
          ],
        ),
      ),
    );
  }
}

// * ---------------------------- Helpers ----------------------------
extension _Helpers on _RequestItemDetailsScreenState {
  List<ImageFile> get itemImages => controller.images.toList();

  String get itemDescription => _formkey
      .currentState
      ?.fields[RequestForPickupFormFieldsEnum.itemDescription.name]
      ?.value;

  String get itemCategory => _formkey
      .currentState
      ?.fields[RequestForPickupFormFieldsEnum.category.name]
      ?.value;

  int get itemQuantity =>
      int.tryParse(
        _formkey
            .currentState
            ?.fields[RequestForPickupFormFieldsEnum.quantity.name]
            ?.value,
      ) ??
      0;

  String get itemCondition => _formkey
      .currentState
      ?.fields[RequestForPickupFormFieldsEnum.conditionInfo.name]
      ?.value;
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _RequestItemDetailsScreenState {
  void onBackButtonPressed() {
    context.router.maybePop(hasEdited);
  }

  void loadData() {
    final vm = context.read<PickupRequestViewModel>();
    if (vm.pickupItemImages.isNotEmpty) {
      controller.images = vm.pickupItemImages;
    }
    _setState(() {
      initialPickupItemDescription = vm.pickupItemDescription;
      initialPickupItemCategory = vm.pickupItemCategory;
      initialPickupItemQuantity = vm.pickupItemQuantity;
      initialPickupItemCondition = vm.pickupItemCondition;
    });

    if (hasEdited) {
      _formkey.currentState?.patchValue({
        'itemDescription': vm.pickupItemDescription,
        'category': vm.pickupItemCategory ?? categoryItems.first,
        'quantity': vm.pickupItemQuantity?.toString() ?? '1',
        'conditionInfo': vm.pickupItemCondition,
      });
    }
  }

  void onNextButtonPressed({required bool isEdit}) async {
    final formValid = _formkey.currentState?.saveAndValidate() ?? false;

    if (formValid) {
      context.read<PickupRequestViewModel>().updatePickupItemDetails(
        pickupItemImages: itemImages,
        pickupItemDescription: itemDescription,
        pickupItemCategory: itemCategory,
        pickupItemQuantity: itemQuantity,
        pickupItemCondition: itemCondition,
      );
      if (isEdit) {
        WidgetUtil.showSnackBar(text: 'Updated successfully');
        context.router.maybePop(true);
      } else {
        final result = await context.router.push(RequestSummaryRoute());

        if (result == true && mounted) {
          _setState(() {
            hasEdited = true;
          });
          loadData();
        }
      }
    }
  }

  void imageControllerSetup() {
    controller = MultiImagePickerController(
      maxImages: 3,
      picker: (int pickCount, Object? params) async {
        final pickedImages = await WidgetUtil.pickMultipleImages(
          images: images,
        );

        if (pickedImages.length > pickCount) {
          WidgetUtil.showSnackBar(
            text:
                'You can only select up to ${controller.maxImages - controller.images.length} image(s).',
          );
        }

        return pickedImages
            .map((e) => WidgetUtil.convertToImageFile(e))
            .toList();
      },
    );
  }

  void imagesChanged(FormFieldState<List<XFile>> field) {
    controller.removeListener(() {});
    controller.addListener(() {
      final currentImages = controller.images;
      field.didChange(currentImages.map((e) => XFile(e.path ?? '')).toList());
    });
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
    return FormBuilderField<List<XFile>>(
      name: RequestForPickupFormFieldsEnum.itemPhotos.name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (controller.images.isEmpty) {
          return '  This field cannot be empty.';
        }
        return null;
      },
      builder: (field) {
        imagesChanged(field);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Item Photo(s)', style: _Styles.sectionTitleTextStyle),
            Text('Note: Maximum 3 photos', style: _Styles.noteTextStyle),
            SizedBox(height: 10),
            getMultiImagePickerView(context: context),
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

  Widget getMultiImagePickerView({required BuildContext context}) {
    final hasImages = controller.images.isNotEmpty;

    return SizedBox(
      height: hasImages
          ? _Styles.hasImagePhotoFieldHeight
          : _Styles.noImagePhotoFieldHeight,
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

  Widget getItemDescriptionSection({required String itemDescription}) {
    return getSectionTextField(
      title: 'Item Description (Eg: Brand, Model and etc)',
      formName: RequestForPickupFormFieldsEnum.itemDescription.name,
      icon: Icons.description,
      initialValue: itemDescription,
    );
  }

  Widget getCategorySection({required String itemCategory}) {
    return Column(
      children: [
        getSectionTitle(title: 'Category', icon: Icons.category_outlined),
        CustomDropdown(
          formName: RequestForPickupFormFieldsEnum.category.name,
          items: categoryItems,
          validator: FormBuilderValidators.required(),
          initialValue: itemCategory,
        ),
      ],
    );
  }

  Widget getQuantitySection({required int quantity}) {
    return getSectionTextField(
      title: 'Quantity',
      formName: RequestForPickupFormFieldsEnum.quantity.name,
      icon: Icons.pie_chart,
      keyboardType: TextInputType.number,
      initialValue: quantity.toString(),
    );
  }

  Widget getConditionInfoSection({required String conditionInfo}) {
    return getSectionTextField(
      title: 'Condition & Usage Info (Condition, Year of Usage and etc)',
      formName: RequestForPickupFormFieldsEnum.conditionInfo.name,
      icon: Icons.info,
      initialValue: conditionInfo,
    );
  }

  Widget getSectionTextField({
    required String title,
    required String formName,
    required IconData icon,
    TextInputType? keyboardType,
    String? initialValue,
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
          validator: FormBuilderValidators.required(),
          initialValue: initialValue,
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

  Widget getNextButton({required bool isEdit}) {
    return CustomButton(
      text: isEdit ? 'Update' : 'Next',
      textColor: ColorManager.whiteColor,
      onPressed: () => onNextButtonPressed(isEdit: isEdit),
      backgroundColor: ColorManager.primary,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const iconSize = 30.0;
  static const maxTextLines = 2;
  static const hasImagePhotoFieldHeight = 120.0;
  static const noImagePhotoFieldHeight = 100.0;

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

  static const noteTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const errorTextStyle = TextStyle(fontSize: 12, color: Colors.red);

  static const errorTextPadding = EdgeInsets.only(top: 5);
}

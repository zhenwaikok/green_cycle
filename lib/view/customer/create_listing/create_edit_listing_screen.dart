import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/enums/form_type.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/item_listing/item_listing_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/item_listing_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/item_listing_view_model.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_dropdown.dart';
import 'package:green_cycle_fyp/widget/custom_text_field.dart';
import 'package:green_cycle_fyp/widget/item_photo_add_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CreateEditListingScreen extends StatelessWidget {
  const CreateEditListingScreen({
    super.key,
    required this.isEdit,
    this.itemListingID,
  });

  final bool isEdit;
  final int? itemListingID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ItemListingViewModel(
        itemListingRepository: ItemListingRepository(),
        firebaseRepository: FirebaseRepository(
          firebaseServices: FirebaseServices(),
        ),
        userRepository: UserRepository(
          sharePreferenceHandler: SharedPreferenceHandler(),
          userServices: UserServices(),
        ),
      ),
      child: _CreateEditListingScreen(
        isEdit: isEdit,
        itemListingID: itemListingID,
      ),
    );
  }
}

class _CreateEditListingScreen extends BaseStatefulPage {
  const _CreateEditListingScreen({required this.isEdit, this.itemListingID});

  final bool isEdit;
  final int? itemListingID;

  @override
  State<_CreateEditListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState
    extends BaseStatefulState<_CreateEditListingScreen> {
  late MultiImagePickerController controller;
  final conditionItems = DropDownItems.itemListingConditionItems;
  final categoryItems = DropDownItems.itemCategoryItems;
  final _formKey = GlobalKey<FormBuilderState>();
  List<XFile> images = [];

  @override
  void initState() {
    super.initState();
    setupAndLoad();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: widget.isEdit ? 'Edit Listing' : 'Create Listing',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget bottomNavigationBar() {
    return getSubmitButton(isEdit: widget.isEdit);
  }

  @override
  Widget body() {
    final itemListingDetails = context.select(
      (ItemListingViewModel vm) => vm.itemListingDetails,
    );

    if (widget.isEdit && itemListingDetails == null) {
      return SizedBox.shrink();
    }

    return SingleChildScrollView(
      child: FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.isEdit) ...[
              getItemListingTitleDescription(),
              SizedBox(height: 20),
            ],
            getListingTextFields(
              itemListingDetails: itemListingDetails ?? ItemListingModel(),
            ),
          ],
        ),
      ),
    );
  }
}

// * ---------------------------- Helpers ----------------------------
extension _Helpers on _CreateListingScreenState {
  List<ImageFile> get itemImages => controller.images.toList();

  String? get itemName => _formKey
      .currentState
      ?.fields[CreateOrEditListingFormFieldsEnum.name.name]
      ?.value;

  String? get itemDescription => _formKey
      .currentState
      ?.fields[CreateOrEditListingFormFieldsEnum.description.name]
      ?.value;

  double? get itemPrice => double.tryParse(
    _formKey
        .currentState
        ?.fields[CreateOrEditListingFormFieldsEnum.price.name]
        ?.value,
  );

  String? get itemCondition => _formKey
      .currentState
      ?.fields[CreateOrEditListingFormFieldsEnum.condition.name]
      ?.value;

  String? get itemCategory => _formKey
      .currentState
      ?.fields[CreateOrEditListingFormFieldsEnum.category.name]
      ?.value;
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CreateListingScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  Future<void> setupAndLoad() async {
    await imageControllerSetup();
    if (widget.isEdit) {
      await initialLoad(itemListingID: widget.itemListingID ?? 0);
    }
  }

  Future<void> imageControllerSetup() async {
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

  Future<void> initialLoad({required int itemListingID}) async {
    final vm = context.read<ItemListingViewModel>();

    await tryLoad(
      context,
      () => vm.getItemListingDetails(itemListingID: itemListingID),
    );

    final itemImageURLs = vm.itemListingDetails?.itemImageURL ?? [];

    if (itemImageURLs.isNotEmpty) {
      controller.images = WidgetUtil.convertImageURLsToImageFiles(
        itemImageURLs,
      );
    } else {
      controller.images = [];
    }
  }

  void imagesChanged(FormFieldState<List<XFile>> field) {
    controller.removeListener(() {});
    controller.addListener(() {
      final currentImages = controller.images;
      field.didChange(currentImages.map((e) => XFile(e.path ?? '')).toList());
    });
  }

  Future<void> onSubmitButtonPressed() async {
    final formValid = _formKey.currentState?.saveAndValidate() ?? false;
    if (formValid) {
      if (!widget.isEdit) {
        final result =
            await tryLoad(
              context,
              () => context.read<ItemListingViewModel>().insertItemListing(
                itemImages: itemImages,
                itemName: itemName ?? '',
                itemDescription: itemDescription ?? '',
                itemPrice: itemPrice ?? 0.0,
                itemCondition: itemCondition ?? '',
                itemCategory: itemCategory ?? '',
              ),
            ) ??
            false;

        if (result) {
          unawaited(
            WidgetUtil.showSnackBar(text: 'Item listing created successfully'),
          );
          if (mounted) await context.router.maybePop();
        } else {
          unawaited(
            WidgetUtil.showSnackBar(text: 'Failed to create item listing'),
          );
        }
      } else {
        final result =
            await tryLoad(
              context,
              () => context.read<ItemListingViewModel>().updateItemListing(
                itemImages: itemImages,
                itemName: itemName ?? '',
                itemDescription: itemDescription ?? '',
                itemPrice: itemPrice ?? 0.0,
                itemCondition: itemCondition ?? '',
                itemCategory: itemCategory ?? '',
              ),
            ) ??
            false;

        if (result) {
          unawaited(
            WidgetUtil.showSnackBar(text: 'Item listing updated successfully'),
          );
          if (mounted) await context.router.maybePop(widget.isEdit);
        } else {
          unawaited(
            WidgetUtil.showSnackBar(text: 'Failed to update item listing'),
          );
        }
      }
    }
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
          'Fill in the details below to list your second-hand item for sale',
          style: _Styles.itemListingDescTextStyle,
        ),
      ],
    );
  }

  Widget getListingTextFields({required ItemListingModel itemListingDetails}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getItemPhotoField(),
        SizedBox(height: 15),
        CustomTextField(
          fontSize: _Styles.createListingFormFieldFontSize,
          color: _Styles.createListingFormFieldColor,
          title: 'Item Name',
          formName: CreateOrEditListingFormFieldsEnum.name.name,
          validator: FormBuilderValidators.required(),
          initialValue: itemListingDetails.itemName ?? '',
        ),
        SizedBox(height: 15),
        CustomTextField(
          fontSize: _Styles.createListingFormFieldFontSize,
          color: _Styles.createListingFormFieldColor,
          title: 'Description',
          formName: CreateOrEditListingFormFieldsEnum.description.name,
          validator: FormBuilderValidators.required(),
          initialValue: itemListingDetails.itemDescription ?? '',
        ),
        SizedBox(height: 15),
        CustomTextField(
          fontSize: _Styles.createListingFormFieldFontSize,
          color: _Styles.createListingFormFieldColor,
          title: 'Price',
          formName: CreateOrEditListingFormFieldsEnum.price.name,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegexConstants.priceRegex),
          ],
          validator: FormBuilderValidators.required(),
          initialValue: itemListingDetails.itemPrice?.toString() ?? '',
        ),
        SizedBox(height: 15),
        CustomDropdown(
          formName: CreateOrEditListingFormFieldsEnum.condition.name,
          items: conditionItems,
          title: 'Condition',
          fontSize: _Styles.createListingFormFieldFontSize,
          color: _Styles.createListingFormFieldColor,
          validator: FormBuilderValidators.required(),
          initialValue:
              itemListingDetails.itemCondition ?? conditionItems.first,
        ),
        SizedBox(height: 15),
        CustomDropdown(
          formName: CreateOrEditListingFormFieldsEnum.category.name,
          items: categoryItems,
          title: 'Category',
          fontSize: _Styles.createListingFormFieldFontSize,
          color: _Styles.createListingFormFieldColor,
          validator: FormBuilderValidators.required(),
          initialValue: itemListingDetails.itemCategory ?? categoryItems.first,
        ),
      ],
    );
  }

  Widget getItemPhotoField() {
    return FormBuilderField<List<XFile>>(
      name: CreateOrEditListingFormFieldsEnum.itemPhotos.name,
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
            Text('Item Photo(s)', style: _Styles.itemListingTitleTextStyle),
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
          ? MediaQuery.of(context).size.height * 0.13
          : MediaQuery.of(context).size.height * 0.11,
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

  Widget getSubmitButton({required bool isEdit}) {
    return CustomButton(
      text: isEdit ? 'Save' : 'Submit',
      textColor: ColorManager.whiteColor,
      onPressed: onSubmitButtonPressed,
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

  static const noteTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const errorTextStyle = TextStyle(fontSize: 12, color: Colors.red);

  static const errorTextPadding = EdgeInsets.only(top: 5);
}

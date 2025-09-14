import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/model/api_model/item_listing/item_listing_model.dart';
import 'package:green_cycle_fyp/model/api_model/user/user_model.dart';
import 'package:green_cycle_fyp/repository/cart_repository.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/item_listing_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/view/common/loading_screen.dart';
import 'package:green_cycle_fyp/viewmodel/cart_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/item_listing_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/bottom_sheet_action.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/dot_indicator.dart';
import 'package:green_cycle_fyp/widget/image_slider.dart';
import 'package:green_cycle_fyp/widget/profile_image.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key, required this.itemListingID});

  final int itemListingID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        ItemListingViewModel(
          itemListingRepository: ItemListingRepository(),
          firebaseRepository: FirebaseRepository(
            firebaseServices: FirebaseServices(),
          ),
        );
        UserViewModel(
          userRepository: UserRepository(
            sharePreferenceHandler: SharedPreferenceHandler(),
            userServices: UserServices(),
          ),
          firebaseRepository: FirebaseRepository(
            firebaseServices: FirebaseServices(),
          ),
        );
        CartViewModel(
          cartRepository: CartRepository(),
          userRepository: UserRepository(
            sharePreferenceHandler: SharedPreferenceHandler(),
            userServices: UserServices(),
          ),
        );
      },
      child: _ItemDetailsScreen(itemListingID: itemListingID),
    );
  }
}

class _ItemDetailsScreen extends BaseStatefulPage {
  const _ItemDetailsScreen({required this.itemListingID});
  final int itemListingID;

  @override
  State<_ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends BaseStatefulState<_ItemDetailsScreen> {
  int currentIndex = 0;
  ItemListingModel? itemListingDetails;
  bool isUserItemOwner = false;
  bool _isLoading = true;
  bool refreshData = false;
  bool isAddedToCart = false;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchItemData();
  }

  @override
  EdgeInsets defaultPadding() {
    return EdgeInsets.zero;
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget bottomNavigationBar() {
    if (_isLoading) {
      return SizedBox.shrink();
    }

    return !isUserItemOwner
        ? getAddToCartButton(
            isAddedToCart: isAddedToCart,
            itemListingDetails: itemListingDetails ?? ItemListingModel(),
          )
        : getOwnerTag();
  }

  @override
  Widget body() {
    itemListingDetails = context.select(
      (ItemListingViewModel vm) => vm.itemListingDetails,
    );
    final sellerInfo = context.select((UserViewModel vm) => vm.userDetails);

    if (_isLoading) {
      return Center(child: LoadingScreen());
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              getItemImageSlider(
                itemImages: itemListingDetails?.itemImageURL ?? [],
              ),
              Positioned(top: 25, left: 15, child: getBackButton()),
              if (isUserItemOwner && itemListingDetails?.isSold == false) ...[
                Positioned(
                  top: 25,
                  right: 15,
                  child: getMoreButton(
                    itemListingID: itemListingDetails?.itemListingID ?? 0,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 10),
          getDotIndicator(itemImages: itemListingDetails?.itemImageURL ?? []),
          Padding(
            padding: _Styles.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getItemStatus(isSold: itemListingDetails?.isSold ?? false),
                SizedBox(height: 10),
                getConditionAndPosted(
                  itemStatus: itemListingDetails?.itemCondition ?? '-',
                  createdDate:
                      itemListingDetails?.createdDate ?? DateTime.now(),
                ),
                SizedBox(height: 20),
                getItemNamePrice(
                  itemName: itemListingDetails?.itemName ?? '-',
                  itemPrice: itemListingDetails?.itemPrice ?? 0.0,
                ),
                getDivider(),
                getItemCategory(
                  itemCategory: itemListingDetails?.itemCategory ?? '-',
                ),
                getDivider(),
                getItemDescription(
                  itemDescription: itemListingDetails?.itemDescription ?? '-',
                ),
                getDivider(),
                if (!isUserItemOwner)
                  getSellerDetails(sellerInfo: sellerInfo ?? UserModel()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ItemDetailsScreenState {
  void onBackButtonPressed() {
    context.router.maybePop(refreshData);
  }

  void onImageChanged(int index, dynamic reason) {
    _setState(() {
      currentIndex = index;
    });
  }

  void onMoreButtonPressed({required int itemListingID}) {
    showModalBottomSheet(
      backgroundColor: ColorManager.whiteColor,
      context: context,
      builder: (context) {
        return getListingBottomSheet(itemListingID: itemListingID);
      },
    );
  }

  void onCallButtonPressed({required String phoneNum}) async {
    await WidgetUtil.dialPhoneNum(phoneNum: phoneNum);
  }

  void onRemovePressed({required int itemListingID}) async {
    await context.router.maybePop();
    if (mounted) {
      WidgetUtil.showAlertDialog(
        context,
        title: 'Delete Confirmation',
        content: 'Are you sure you want to delete this item from your listing?',
        actions: [
          (dialogContext) => getAlertDialogTextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            text: 'No',
          ),
          (dialogContext) => getAlertDialogTextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onYesRemovePressed(itemListingID: itemListingID);
            },
            text: 'Yes',
          ),
        ],
      );
    }
  }

  void onEditPressed({required int itemListingID}) async {
    await context.router.maybePop();
    if (mounted) {
      final result = await context.router.push(
        CreateEditListingRoute(isEdit: true, itemListingID: itemListingID),
      );

      if (result == true && mounted) {
        _setState(() {
          refreshData = true;
        });
        await fetchItemData();
      }
    }
  }

  Future<void> onYesRemovePressed({required int itemListingID}) async {
    await context.router.maybePop();
    final result = mounted
        ? await tryLoad(
                context,
                () => context.read<ItemListingViewModel>().deleteItemListing(
                  itemListingID: itemListingID,
                ),
              ) ??
              false
        : false;

    if (result) {
      unawaited(
        WidgetUtil.showSnackBar(text: 'Item listing removed successfully.'),
      );
      await fetchItemData();
    } else {
      WidgetUtil.showSnackBar(text: 'Failed to remove item listing.');
    }
  }

  Future<void> addItemToCart({
    required ItemListingModel itemListingDetails,
  }) async {
    final userID = context.read<UserViewModel>().user?.userID ?? '';

    final result =
        await tryLoad(
          context,
          () => context.read<CartViewModel>().addToCart(
            buyerUserID: userID,
            sellerUserID: itemListingDetails.userID ?? '',
            itemListingID: itemListingDetails.itemListingID ?? 0,
          ),
        ) ??
        false;

    if (result) {
      unawaited(
        WidgetUtil.showSnackBar(text: 'Item added to cart successfully'),
      );
      _setState(() {
        isAddedToCart = true;
        refreshData = true;
      });
      await fetchItemData();
    }
  }

  Future<void> fetchItemData() async {
    _setState(() => _isLoading = true);
    await tryLoad(
      context,
      () => context.read<ItemListingViewModel>().getItemListingDetails(
        itemListingID: widget.itemListingID,
      ),
    );

    final sellerUserIDItemListing = itemListingDetails?.userID ?? '';
    if (mounted) {
      await tryCatch(
        context,
        () => context.read<UserViewModel>().getUserDetails(
          userID: sellerUserIDItemListing,
          noNeedUpdateUserSharedPreference: true,
        ),
      );
    }

    final userID = mounted
        ? context.read<UserViewModel>().user?.userID ?? ''
        : '';

    if (mounted) {
      await tryCatch(
        context,
        () => context.read<CartViewModel>().getUserCartItems(userID: userID),
      );
    }

    _setState(() {
      isAddedToCart = context.read<CartViewModel>().userCartItems.any(
        (item) => item.itemListingID == widget.itemListingID,
      );
      isUserItemOwner = sellerUserIDItemListing == userID;
      _isLoading = false;
    });
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ItemDetailsScreenState {
  Widget getItemImageSlider({required List<String> itemImages}) {
    return ImageSlider(
      items: itemImages,
      imageBorderRadius: 0,
      carouselHeight: _Styles.itemImageSize,
      containerMargin: _Styles.containerMargin,
      onImageChanged: onImageChanged,
    );
  }

  Widget getDotIndicator({required List<String> itemImages}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        itemImages.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: _Styles.indicatorRightPadding),
          child: DotIndicator(
            isActive: index == currentIndex,
            dotIndicatorSize: _Styles.dotIndicatorSize,
          ),
        ),
      ),
    );
  }

  Widget getBackButton() {
    return getTopButton(
      icon: Icons.arrow_back_rounded,
      onPressed: onBackButtonPressed,
    );
  }

  Widget getMoreButton({required int itemListingID}) {
    return getTopButton(
      icon: Icons.more_vert_rounded,
      onPressed: () => onMoreButtonPressed(itemListingID: itemListingID),
    );
  }

  Widget getTopButton({required IconData icon, required Function() onPressed}) {
    return Container(
      width: _Styles.backButtonContainerSize,
      height: _Styles.backButtonContainerSize,
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: IconButton(
          icon: Icon(icon, color: ColorManager.blackColor),
          onPressed: onPressed,
        ),
      ),
    );
  }

  Widget getItemStatus({required bool isSold}) {
    return Text(
      'Status: ${isSold ? 'Sold' : 'Active'}',
      style: _Styles.statusTextStyle(isSold: isSold),
    );
  }

  Widget getConditionAndPosted({
    required String itemStatus,
    required DateTime createdDate,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomStatusBar(text: itemStatus),
        Text(
          'Posted ${WidgetUtil.differenceBetweenDate(createdDate)}',
          style: _Styles.postedTextStyle,
        ),
      ],
    );
  }

  Widget getItemNamePrice({
    required String itemName,
    required double itemPrice,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(itemName, style: _Styles.productNameTextStyle),
        SizedBox(height: 10),
        Text(
          'RM ${WidgetUtil.priceFormatter(itemPrice)}',
          style: _Styles.productPriceTextStyle,
        ),
      ],
    );
  }

  Widget getItemCategory({required String itemCategory}) {
    return getTitleDescription(title: 'Category', description: itemCategory);
  }

  Widget getItemDescription({required String itemDescription}) {
    return getTitleDescription(
      title: 'Description',
      description: itemDescription,
    );
  }

  Widget getTitleDescription({
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _Styles.titleTextStyle),
        Text(
          description,
          style: _Styles.descriptionTextStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget getSellerDetails({required UserModel sellerInfo}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Seller Info', style: _Styles.titleTextStyle),
        SizedBox(height: 10),
        getSellerInfoCard(sellerInfo: sellerInfo),
      ],
    );
  }

  Widget getSellerInfoCard({required UserModel sellerInfo}) {
    return CustomCard(
      needBoxShadow: false,
      backgroundColor: ColorManager.primaryLight,
      child: Row(
        children: [
          getSellerProfileImage(imageURL: sellerInfo.profileImageURL ?? ''),
          SizedBox(width: 25),
          Expanded(
            child: getSellerNamePhoneNum(
              sellerName:
                  '${sellerInfo.firstName ?? '-'} ${sellerInfo.lastName ?? ''}',
              sellerPhoneNum: sellerInfo.phoneNumber ?? 'xxx-xxxxxxx',
            ),
          ),
        ],
      ),
    );
  }

  Widget getSellerProfileImage({required String imageURL}) {
    return CustomProfileImage(
      imageSize: _Styles.sellerImageSize,
      imageURL: imageURL,
    );
  }

  Widget getSellerNamePhoneNum({
    required String sellerName,
    required String sellerPhoneNum,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sellerName,
          style: _Styles.sellerNameTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 5),
        Row(
          children: [
            TouchableOpacity(
              onPressed: () => onCallButtonPressed(phoneNum: sellerPhoneNum),
              child: Icon(
                Icons.phone,
                size: _Styles.iconSize,
                color: ColorManager.blackColor,
              ),
            ),
            SizedBox(width: 8),
            Text(sellerPhoneNum, style: _Styles.sellerPhoneNumTextStyle),
          ],
        ),
      ],
    );
  }

  Widget getDivider() {
    return Padding(
      padding: _Styles.dividerPadding,
      child: Divider(color: ColorManager.lightGreyColor),
    );
  }

  Widget getAddToCartButton({
    required bool isAddedToCart,
    required ItemListingModel itemListingDetails,
  }) {
    return Padding(
      padding: _Styles.screenPadding,
      child: CustomButton(
        text: isAddedToCart ? 'Added to Cart' : 'Add To Cart',
        textColor: isAddedToCart
            ? ColorManager.blackColor
            : ColorManager.whiteColor,
        onPressed: isAddedToCart
            ? null
            : () {
                addItemToCart(itemListingDetails: itemListingDetails);
              },
        backgroundColor: ColorManager.primary,
      ),
    );
  }

  Widget getOwnerTag() {
    return Padding(
      padding: _Styles.screenPadding,
      child: Text(
        'This is your item listing',
        style: _Styles.ownerTagTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget getListingBottomSheet({required int itemListingID}) {
    return Padding(
      padding: _Styles.screenPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetAction(
            icon: Icons.edit,
            color: ColorManager.blackColor,
            text: 'Edit',
            onTap: () => onEditPressed(itemListingID: itemListingID),
          ),
          SizedBox(height: 10),
          BottomSheetAction(
            icon: Icons.delete_outline,
            color: ColorManager.redColor,
            text: 'Remove',
            onTap: () => onRemovePressed(itemListingID: itemListingID),
          ),
        ],
      ),
    );
  }

  Widget getAlertDialogTextButton({
    required void Function()? onPressed,
    required String text,
  }) {
    return TextButton(
      style: _Styles.textButtonStyle,
      onPressed: onPressed,
      child: Text(text, style: _Styles.textButtonTextStyle),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const itemImageSize = 220.0;
  static const sellerImageSize = 80.0;
  static const backButtonContainerSize = 50.0;
  static const iconSize = 20.0;
  static const dotIndicatorSize = 10.0;

  static const indicatorRightPadding = 8.0;

  static const dividerPadding = EdgeInsets.symmetric(vertical: 10);

  static const containerMargin = EdgeInsets.all(0);

  static const postedTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static TextStyle statusTextStyle({required bool isSold}) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeightManager.regular,
    color: isSold ? ColorManager.redColor : ColorManager.primary,
  );

  static const productNameTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const productPriceTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.redColor,
  );

  static const titleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const descriptionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const sellerNameTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const sellerPhoneNumTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const ownerTagTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static final textButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(ColorManager.lightGreyColor2),
  );

  static const textButtonTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );
}

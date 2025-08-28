import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/constant/images_manager.dart';
import 'package:green_cycle_fyp/model/api_model/awareness/awareness_model.dart';
import 'package:green_cycle_fyp/model/api_model/item_listing/item_listing_model.dart';
import 'package:green_cycle_fyp/model/api_model/pickup_request/pickup_request_model.dart';
import 'package:green_cycle_fyp/repository/awareness_repository.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/item_listing_repository.dart';
import 'package:green_cycle_fyp/repository/pickup_request_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/services/awareness_services.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/viewmodel/awareness_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/item_listing_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/pickup_request_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/second_hand_item.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        PickupRequestViewModel(
          pickupRequestRepository: PickupRequestRepository(),
          firebaseRepository: FirebaseRepository(
            firebaseServices: FirebaseServices(),
          ),
          userRepository: UserRepository(
            sharePreferenceHandler: SharedPreferenceHandler(),
            userServices: UserServices(),
          ),
        );
        ItemListingViewModel(
          itemListingRepository: ItemListingRepository(),
          firebaseRepository: FirebaseRepository(
            firebaseServices: FirebaseServices(),
          ),
        );
        AwarenessViewModel(
          awarenessRepository: AwarenessRepository(
            awarenessServices: AwarenessServices(),
          ),
          firebaseRepository: FirebaseRepository(
            firebaseServices: FirebaseServices(),
          ),
        );
      },
      child: _CustomerHomeScreen(),
    );
  }
}

class _CustomerHomeScreen extends BaseStatefulPage {
  @override
  State<_CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends BaseStatefulState<_CustomerHomeScreen> {
  List<AwarenessModel> _awarenessList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
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
  Widget body() {
    final userVM = context.read<UserViewModel>();
    final firstName = userVM.user?.firstName;
    final userID = userVM.user?.userID;

    final pickupRequestList = context.select(
      (PickupRequestViewModel vm) => vm.pickupRequestList,
    );
    final pendingPickupRequestList = pendingPickupRequest(
      pickupRequestList: pickupRequestList,
    );
    final ongoingPickupRequestList = ongoingPickupRequest(
      pickupRequestList: pickupRequestList,
    );
    final completedPickupRequestList = completedPickupRequest(
      pickupRequestList: pickupRequestList,
    );
    final loadingPickupRequestList = List.generate(
      5,
      (index) => PickupRequestModel(
        pickupRequestID: 'Loading...',
        pickupItemDescription: 'Loading...',
        pickupItemCategory: 'Loading...',
        pickupLocation: 'Loading...',
        pickupDate: DateTime.now(),
        pickupTimeRange: 'Loading...',
      ),
    );
    sortOngoingPickupRequest(pickupRequestList: ongoingPickupRequestList);

    final itemListingList = context.select(
      (ItemListingViewModel vm) => vm.itemListings
          .where((item) {
            return item.userID != userID && item.isSold == false;
          })
          .take(5)
          .toList(),
    );

    final loadingItemListingList = List.generate(
      5,
      (index) => ItemListingModel(
        itemName: 'Loading...',
        itemDescription: 'Loading...',
        itemCategory: 'Loading...',
        itemCondition: 'Loading...',
      ),
    );

    final awarenessList = _awarenessList
      ..sort(
        (a, b) =>
            b.createdDate?.compareTo(a.createdDate ?? DateTime.now()) ?? 0,
      );
    final latest5AwarenessList = awarenessList.take(5).toList();
    final loadingAwarenessList = List.generate(
      5,
      (index) => AwarenessModel(
        awarenessTitle: 'Loading...',
        createdDate: DateTime.now(),
      ),
    );

    return AdaptiveWidgets.buildRefreshableScrollView(
      context,
      onRefresh: fetchData,
      color: ColorManager.blackColor,
      refreshIndicatorBackgroundColor: ColorManager.whiteColor,
      slivers: [
        SliverMainAxisGroup(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  getTopBarInfo(
                    firstName: firstName ?? '-',
                    numOfPending: pendingPickupRequestList.length,
                    numOfOngoing: ongoingPickupRequestList.length,
                    numOfCompleted: completedPickupRequestList.length,
                  ),
                  Transform.translate(
                    offset: const Offset(0, -40),
                    child: Padding(
                      padding: _Styles.requestContainerPadding,
                      child: Skeletonizer(
                        enabled: isLoading,
                        child: getRequestPickupCard(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SliverPadding(
              padding: _Styles.screenPadding,
              sliver: SliverMainAxisGroup(
                slivers: [
                  SliverToBoxAdapter(
                    child: Skeletonizer(
                      enabled: isLoading,
                      child: getStartSellingSection(),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 40)),
                  SliverToBoxAdapter(
                    child: getRequestList(
                      ongoingPickupRequestList: isLoading
                          ? loadingPickupRequestList
                          : ongoingPickupRequestList.take(5).toList(),
                      isLoading: isLoading,
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 30)),
                  SliverToBoxAdapter(
                    child: getMarketplaceSection(
                      itemListingList: isLoading
                          ? loadingItemListingList
                          : itemListingList,
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 30)),
                  SliverToBoxAdapter(
                    child: getWhatNewSection(
                      awarenessList: isLoading
                          ? loadingAwarenessList
                          : latest5AwarenessList,
                      isLoading: isLoading,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// * ---------------------------- Helpers ----------------------------
extension _Helpers on _CustomerHomeScreenState {
  List<PickupRequestModel> pendingPickupRequest({
    required List<PickupRequestModel> pickupRequestList,
  }) {
    return pickupRequestList.where((request) {
      return request.pickupRequestStatus ==
          DropDownItems.requestDropdownItems[1];
    }).toList();
  }

  List<PickupRequestModel> ongoingPickupRequest({
    required List<PickupRequestModel> pickupRequestList,
  }) {
    return pickupRequestList.where((request) {
      return request.pickupRequestStatus ==
              DropDownItems.requestDropdownItems[3] ||
          request.pickupRequestStatus == DropDownItems.requestDropdownItems[4];
    }).toList();
  }

  List<PickupRequestModel> completedPickupRequest({
    required List<PickupRequestModel> pickupRequestList,
  }) {
    return pickupRequestList.where((request) {
      return request.pickupRequestStatus ==
          DropDownItems.requestDropdownItems[5];
    }).toList();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CustomerHomeScreenState {
  Future<void> fetchData() async {
    _setState(() => isLoading = true);
    await tryCatch(
      context,
      () =>
          context.read<PickupRequestViewModel>().getPickupRequestsWithUserID(),
    );

    if (mounted) {
      await tryCatch(
        context,
        () => context.read<ItemListingViewModel>().getAllItemListings(),
      );
    }

    final awarenessList = mounted
        ? await tryCatch(
            context,
            () => context.read<AwarenessViewModel>().getAwarenessList(),
          )
        : null;
    if (awarenessList != null) {
      _setState(() => _awarenessList = awarenessList);
    }
    _setState(() => isLoading = false);
  }

  void sortOngoingPickupRequest({
    required List<PickupRequestModel> pickupRequestList,
  }) async {
    pickupRequestList.sort(
      (a, b) => (b.requestedDate ?? DateTime.now()).compareTo(
        a.requestedDate ?? DateTime.now(),
      ),
    );
  }

  void onRequestPickupButtonPressed() {
    context.router.push(SelectLocationRoute(isEdit: false));
  }

  void onShowAllButtonPressed() {
    AutoTabsRouter.of(context).setActiveIndex(2);
  }

  void onMoreNewsButtonPressed() {
    context.router.push(AwarenessRoute());
  }

  void onStartSellingButtonPressed() {
    context.router.push(CreateEditListingRoute(isEdit: false));
  }

  void onNewsCardPressed({required int awarenessID}) {
    context.router.push(
      AwarenessDetailsRoute(userRole: 'Customer', awarenessId: awarenessID),
    );
  }

  void onItemListingCardPressed({required int itemListingID}) {
    context.router.push(ItemDetailsRoute(itemListingID: itemListingID));
  }

  void onPickupRequestCardPressed({required String pickupRequestID}) {
    context.router.push(RequestDetailsRoute(pickupRequestID: pickupRequestID));
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CustomerHomeScreenState {
  Widget getTopBarInfo({
    required String firstName,
    required int numOfPending,
    required int numOfOngoing,
    required int numOfCompleted,
  }) {
    return Container(
      width: double.infinity,
      height: _Styles.welcomeContainerHeight,
      padding: _Styles.welcomeContainerPadding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(_Styles.topBarBorderRadius),
          bottomRight: Radius.circular(_Styles.topBarBorderRadius),
        ),
        image: DecorationImage(
          image: AssetImage(Images.customerHomeImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            ColorManager.blackColor.withValues(alpha: 0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text('Welcome, $firstName', style: _Styles.welcomeTextStyle),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              getTopBarRequestStatus(number: numOfPending, status: 'Pending'),
              getTopBarRequestStatus(number: numOfOngoing, status: 'Ongoing'),
              getTopBarRequestStatus(
                number: numOfCompleted,
                status: 'Completed',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getTopBarRequestStatus({required int number, required String status}) {
    return Column(
      children: [
        Text(
          '$number',
          textAlign: TextAlign.center,
          style: _Styles.requestNumberTextStyle,
        ),
        Text(
          status,
          textAlign: TextAlign.center,
          style: _Styles.requestStatusTextStyle,
        ),
      ],
    );
  }

  Widget getRequestPickupCard() {
    return CustomCard(
      child: Column(
        children: [
          getRequestPickupImage(),
          SizedBox(height: 15),
          getRequestPickupCardContent(),
        ],
      ),
    );
  }

  Widget getRequestPickupImage() {
    return Image.asset(
      Images.requestPickupImage,
      width: _Styles.requestPickupImageSize,
      height: _Styles.requestPickupImageSize,
      fit: BoxFit.cover,
    );
  }

  Widget getRequestPickupCardContent() {
    return Column(
      children: [
        Text(
          'Schedule a Pickup',
          style: _Styles.requestPickupTitleTextStyle,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          'Too busy to drop off recyclables? No problem! Book a pickup and collector will collect them right from your home. It is a simple way to make a positive impact.',
          style: _Styles.requestPickupDescTextStyle,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        CustomButton(
          text: 'Request For Pickup',
          textColor: ColorManager.whiteColor,
          onPressed: onRequestPickupButtonPressed,
        ),
      ],
    );
  }

  Widget getStartSellingSection() {
    return TouchableOpacity(
      onPressed: onStartSellingButtonPressed,
      child: CustomCard(
        padding: _Styles.customCardPadding,
        child: Row(
          children: [
            Image.asset(
              Images.marketplaceImage,
              width: _Styles.marketplaceImageSize,
              height: _Styles.marketplaceImageSize,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Start Selling Your Old Electronics',
                style: _Styles.titleTextStyle,
              ),
            ),
            Container(
              width: _Styles.iconButtonContainerSize,
              height: _Styles.iconButtonContainerSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManager.lightGreyColor2,
              ),
              child: Icon(
                Icons.arrow_forward_sharp,
                color: ColorManager.blackColor,
                size: _Styles.iconButtonSize,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getRequestList({
    required List<PickupRequestModel> ongoingPickupRequestList,
    required bool isLoading,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('In Progress Pickup Requests', style: _Styles.titleTextStyle),
        SizedBox(height: 20),

        if (ongoingPickupRequestList.isEmpty) ...[
          Text('No ongoing pickup requests found yet. Request now!'),
        ] else ...[
          SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: ongoingPickupRequestList.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: getRequestCard(
                    pickupRequestDetails: ongoingPickupRequestList[index],
                    isLoading: isLoading,
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }

  Widget getRequestCard({
    required PickupRequestModel pickupRequestDetails,
    required bool isLoading,
  }) {
    return TouchableOpacity(
      onPressed: () => isLoading
          ? null
          : onPickupRequestCardPressed(
              pickupRequestID: pickupRequestDetails.pickupRequestID ?? '',
            ),
      child: Padding(
        padding: _Styles.cardPadding,
        child: CustomCard(
          padding: _Styles.customCardPadding,
          child: Skeletonizer(
            enabled: isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getRequestID(
                      pickupRequestID:
                          pickupRequestDetails.pickupRequestID ?? '',
                    ),
                    getRequestStatus(
                      status: pickupRequestDetails.pickupRequestStatus ?? '',
                    ),
                  ],
                ),
                getDivider(),
                getItemDetails(pickupRequestDetails: pickupRequestDetails),
                getDivider(),
                getRequestDetails(
                  requestedDate:
                      pickupRequestDetails.requestedDate ?? DateTime.now(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getRequestDetails({required DateTime requestedDate}) {
    return Text(
      'Requested: ${WidgetUtil.dateTimeFormatter(requestedDate)}',
      style: _Styles.completedTextStyle,
    );
  }

  Widget getDivider() {
    return Padding(
      padding: _Styles.dividerPadding,
      child: Divider(color: ColorManager.lightGreyColor),
    );
  }

  Widget getRequestID({required String pickupRequestID}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Request ID', style: _Styles.requestIDTitleTextStyle),
        Text('#$pickupRequestID', style: _Styles.requestIDTextStyle),
      ],
    );
  }

  Widget getRequestStatus({required String status}) {
    final backgroundColor = WidgetUtil.getPickupRequestStatusColor(status);

    return CustomStatusBar(text: status, backgroundColor: backgroundColor);
  }

  Widget getItemDetails({required PickupRequestModel pickupRequestDetails}) {
    return Row(
      children: [
        getItemImage(
          imageURL: pickupRequestDetails.pickupItemImageURL?.first ?? '',
        ),
        SizedBox(width: 15),
        Expanded(
          child: getItemDescription(
            itemDescription: pickupRequestDetails.pickupItemDescription ?? '',
            itemCategory: pickupRequestDetails.pickupItemCategory ?? '',
            itemQuantity: pickupRequestDetails.pickupItemQuantity ?? 0,
          ),
        ),
      ],
    );
  }

  Widget getItemImage({required String imageURL}) {
    return CustomImage(
      imageSize: _Styles.imageSize,
      imageURL: imageURL,
      borderRadius: _Styles.imageBorderRadius,
    );
  }

  Widget getItemDescription({
    required String itemDescription,
    required String itemCategory,
    required int itemQuantity,
  }) {
    return SizedBox(
      height: _Styles.imageSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemDescription,
                maxLines: _Styles.maxTextLines,
                overflow: TextOverflow.ellipsis,
                style: _Styles.itemDescriptionTextStyle,
              ),
              Text(itemCategory, style: _Styles.itemDescriptionTextStyle),
            ],
          ),
          Text('Quantity: $itemQuantity', style: _Styles.quantityTextStyle),
        ],
      ),
    );
  }

  Widget getMarketplaceSection({
    required List<ItemListingModel> itemListingList,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getMarketplaceTitle(),
        SizedBox(height: 10),
        getMarketplaceList(itemListingList: itemListingList),
      ],
    );
  }

  Widget getMarketplaceTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Old Electronics, New Value', style: _Styles.titleTextStyle),
        TextButton(
          style: _Styles.showAllButtonStyle,
          onPressed: onShowAllButtonPressed,
          child: Text(
            'Show All',
            style: _Styles.showAllTextStyle,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget getMarketplaceList({required List<ItemListingModel> itemListingList}) {
    if (itemListingList.isEmpty && !isLoading) {
      return Text('No item listing found yet from others.');
    }

    return SizedBox(
      height: 220,
      child: ListView.builder(
        itemCount: itemListingList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final itemListingDetails = itemListingList[index];
          return Padding(
            padding: _Styles.productCardPadding,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: TouchableOpacity(
                onPressed: () => isLoading
                    ? null
                    : onItemListingCardPressed(
                        itemListingID: itemListingDetails.itemListingID ?? 0,
                      ),
                child: Skeletonizer(
                  enabled: isLoading,
                  child: SecondHandItem(
                    imageURL: itemListingDetails.itemImageURL?.first ?? '',
                    productName: itemListingDetails.itemName ?? '',
                    productPrice:
                        'RM ${WidgetUtil.priceFormatter(itemListingDetails.itemPrice ?? 0.0)}',
                    text: itemListingDetails.itemCondition ?? '',
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getWhatNewSection({
    required List<AwarenessModel> awarenessList,
    required bool isLoading,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getWhatNewTitle(),
        SizedBox(height: 10),
        getWhatNewItems(awarenessList: awarenessList, isLoading: isLoading),
      ],
    );
  }

  Widget getWhatNewTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('What\'s News', style: _Styles.titleTextStyle),
        TextButton(
          style: _Styles.showAllButtonStyle,
          onPressed: onMoreNewsButtonPressed,
          child: Text(
            'More >',
            style: _Styles.moreTextStyle,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget getWhatNewItems({
    required List<AwarenessModel> awarenessList,
    required bool isLoading,
  }) {
    if (awarenessList.isEmpty && !isLoading) {
      return Text('No awarness feed found.');
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.builder(
        itemCount: awarenessList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: _Styles.productCardPadding,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: TouchableOpacity(
                onPressed: () => isLoading
                    ? null
                    : onNewsCardPressed(
                        awarenessID: awarenessList[index].awarenessID ?? 0,
                      ),
                child: SizedBox(
                  child: Skeletonizer(
                    enabled: isLoading,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImage(
                          imageURL:
                              awarenessList[index].awarenessImageURL ?? '',
                          imageSize: MediaQuery.of(context).size.height * 0.15,
                          imageWidth: double.infinity,
                          borderRadius: 10.0,
                        ),
                        SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              awarenessList[index].awarenessTitle ?? '',
                              style: _Styles.newsTitleTextStyle,
                              maxLines: _Styles.maxTextLines,
                            ),
                            SizedBox(height: 5),
                            Text(
                              WidgetUtil.dateFormatter(
                                awarenessList[index].createdDate ??
                                    DateTime.now(),
                              ),
                              style: _Styles.dateTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const marketplaceImageSize = 80.0;
  static const welcomeContainerHeight = 180.0;
  static const screenPadding = EdgeInsets.only(left: 20, right: 20, bottom: 20);
  static const customCardPadding = EdgeInsets.all(10);
  static const iconButtonContainerSize = 40.0;
  static const iconButtonSize = 20.0;
  static const requestPickupImageSize = 120.0;
  static const topBarBorderRadius = 20.0;

  static const welcomeContainerPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 15,
  );

  static const productCardPadding = EdgeInsetsGeometry.only(
    right: 20,
    left: 10,
    top: 10,
    bottom: 10,
  );

  static const requestContainerPadding = EdgeInsets.symmetric(horizontal: 20);

  static const requestNumberTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.whiteColor,
  );

  static const requestStatusTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.whiteColor,
  );

  static const welcomeTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.whiteColor,
  );

  static const requestPickupTitleTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const requestPickupDescTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const titleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static final showAllButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(Colors.transparent),
  );

  static const showAllTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.primary,
    decoration: TextDecoration.underline,
    decorationColor: ColorManager.primary,
  );

  static const moreTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.primary,
  );

  static const newsTitleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const dateTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const imageSize = 80.0;
  static const imageBorderRadius = 5.0;
  static const maxTextLines = 2;

  static const dividerPadding = EdgeInsets.symmetric(vertical: 6);

  static const cardPadding = EdgeInsets.only(
    right: 30,
    top: 10,
    bottom: 10,
    left: 5,
  );
  static const requestIDTitleTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const requestIDTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const itemDescriptionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const quantityTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.greyColor,
  );

  static const completedTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );
}

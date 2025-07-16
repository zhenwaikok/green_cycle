import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/constant/images_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/second_hand_item.dart';

@RoutePage()
class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              getTopBarInfo(),
              Transform.translate(
                offset: const Offset(0, -40),
                child: Padding(
                  padding: _Styles.requestContainerPadding,
                  child: getRequestPickupCard(),
                ),
              ),
              Padding(
                padding: _Styles.screenPadding,
                child: Column(
                  children: [
                    getStartSellingSection(),
                    SizedBox(height: 40),
                    getRequestList(),
                    SizedBox(height: 30),
                    getMarketplaceSection(),
                    SizedBox(height: 30),
                    getWhatNewSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CustomerHomeScreenState {
  void onRequestPickupButtonPressed() {
    context.router.push(SelectLocationRoute());
  }

  void onShowAllButtonPressed() {
    AutoTabsRouter.of(context).setActiveIndex(2);
  }

  void onMoreNewsButtonPressed() {
    context.router.push(AwarenessRoute());
  }

  void onStartSellingButtonPressed() {
    context.router.push(CreateListingRoute());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CustomerHomeScreenState {
  Widget getTopBarInfo() {
    return Container(
      width: double.infinity,
      height: _Styles.welcomeContainerHeight,
      padding: _Styles.welcomeContainerPadding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
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
          // TODO: Change to real username
          Text('Welcome,name', style: _Styles.welcomeTextStyle),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              getTopBarRequestStatus(number: '1', status: 'Pending'),
              getTopBarRequestStatus(number: '1', status: 'Ongoing'),
              getTopBarRequestStatus(number: '1', status: 'Completed'),
            ],
          ),
        ],
      ),
    );
  }

  Widget getTopBarRequestStatus({
    required String number,
    required String status,
  }) {
    return Column(
      children: [
        Text(
          number,
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
    return GestureDetector(
      onTap: onStartSellingButtonPressed,
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

  Widget getRequestList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Pickup Requests', style: _Styles.titleTextStyle),
        SizedBox(height: 20),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: getRequestCard(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget getRequestCard() {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: _Styles.cardPadding,
        child: CustomCard(
          padding: _Styles.customCardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getRequestID(),
                  getRequestStatus(status: 'Pending'),
                ],
              ),
              getDivider(),
              getItemDetails(),
              getDivider(),
              getRequestDetails(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRequestDetails() {
    return Text(
      'Requested: 29/4/2025, 11:22 PM',
      style: _Styles.completedTextStyle,
    );
  }

  Widget getDivider() {
    return Padding(
      padding: _Styles.dividerPadding,
      child: Divider(color: ColorManager.lightGreyColor),
    );
  }

  Widget getRequestID() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Request ID', style: _Styles.requestIDTitleTextStyle),
        Text('#REQ13113', style: _Styles.requestIDTextStyle),
      ],
    );
  }

  Widget getRequestStatus({required String status}) {
    return CustomStatusBar(text: status);
  }

  Widget getItemDetails() {
    return Row(
      children: [
        getItemImage(),
        SizedBox(width: 15),
        Expanded(child: getItemDescription()),
      ],
    );
  }

  Widget getItemImage() {
    return CustomImage(
      imageSize: _Styles.imageSize,
      imageURL:
          'https://thumbs.dreamstime.com/b/image-attractive-shopper-girl-dressed-casual-clothing-holding-paper-bags-standing-isolated-over-pyrple-iimage-attractive-150643339.jpg',
      borderRadius: _Styles.imageBorderRadius,
    );
  }

  Widget getItemDescription() {
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
                'Item Descriptionsas0',
                maxLines: _Styles.maxTextLines,
                overflow: TextOverflow.ellipsis,
                style: _Styles.itemDescriptionTextStyle,
              ),
              Text('Category', style: _Styles.itemDescriptionTextStyle),
            ],
          ),
          Text('Quantity: 1', style: _Styles.quantityTextStyle),
        ],
      ),
    );
  }

  Widget getMarketplaceSection() {
    return Column(
      children: [
        getMarketplaceTitle(),
        SizedBox(height: 10),
        getMarketplaceList(),
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

  Widget getMarketplaceList() {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: _Styles.productCardPadding,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: GestureDetector(
                onTap: () {},
                child: SecondHandItem(
                  imageURL:
                      'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D',
                  productName: 'Product Nameasdasdsad',
                  productPrice: 'RM xx.xx',
                  text: 'Like New',
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getWhatNewSection() {
    return Column(
      children: [getWhatNewTitle(), SizedBox(height: 10), getWhatNewItems()],
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

  Widget getWhatNewItems() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: _Styles.productCardPadding,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: GestureDetector(
                onTap: () {},
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: double.infinity,
                          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('News Title', style: _Styles.newsTitleTextStyle),
                          Text('Date', style: _Styles.dateTextStyle),
                        ],
                      ),
                    ],
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
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
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

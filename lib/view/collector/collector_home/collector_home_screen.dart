import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/constant/images_manager.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';

@RoutePage()
class CollectorHomeScreen extends StatefulWidget {
  const CollectorHomeScreen({super.key});

  @override
  State<CollectorHomeScreen> createState() => _CollectorHomeScreenState();
}

class _CollectorHomeScreenState extends State<CollectorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            getTopBarInfo(),
            Padding(
              padding: _Styles.screenPadding,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  getAvailablePickupRequestSection(),
                  SizedBox(height: 30),
                  getOngoingPickupRequestSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CollectorHomeScreenState {
  void onAvailablePickupRequestPressed() {
    AutoTabsRouter.of(context).setActiveIndex(1);
  }

  void onShowMoreButtonPressed() {
    AutoTabsRouter.of(context).setActiveIndex(2);
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CollectorHomeScreenState {
  Widget getTopBarInfo() {
    return Container(
      width: double.infinity,
      height: _Styles.welcomeContainerHeight,
      decoration: BoxDecoration(color: ColorManager.primaryLight),
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: _Styles.rightPadding,
              child: Align(
                alignment: Alignment.centerLeft,
                child: getCollectorInfo(),
              ),
            ),
          ),

          Positioned(
            right: -17,
            bottom: -6,
            child: Image.asset(
              Images.collectorImage,
              height: _Styles.collectorImageHeight,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget getCollectorInfo() {
    return Padding(
      padding: _Styles.collectorInfoPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomStatusBar(text: 'Welcome'),
              SizedBox(height: 5),
              Text(
                'Collector Nameasdasdasdasd',
                style: _Styles.collectorNameTextStyle,
                maxLines: _Styles.max1Line,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Completed Today', style: _Styles.titleTextStyle),
              Text(
                '5 Requestsasdasdasddasadasd',
                style: _Styles.infoTextStyle,
                maxLines: _Styles.max1Line,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getAvailablePickupRequestSection() {
    return GestureDetector(
      onTap: onAvailablePickupRequestPressed,
      child: CustomCard(
        padding: _Styles.customCardPadding,
        child: Row(
          children: [
            Image.asset(
              Images.ewasteItemImage,
              width: _Styles.ewasteItemImageSize,
              height: _Styles.ewasteItemImageSize,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  Text(
                    '5 Available Pickup Requests Found!',
                    style: _Styles.availablePickupTextStyle,
                  ),
                  Row(
                    children: [
                      Text('View Details', style: _Styles.titleTextStyle),
                      Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: ColorManager.primary,
                        size: _Styles.iconSize,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getOngoingPickupRequestSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ongoing Pickup Requests',
              style: _Styles.ongoingTitleTextStyle,
            ),
            TextButton(
              style: _Styles.showAllButtonStyle,
              onPressed: onShowMoreButtonPressed,
              child: Text(
                'See More',
                style: _Styles.moreTextStyle,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        getOngoingPickupRequestList(),
      ],
    );
  }

  Widget getOngoingPickupRequestList() {
    return SizedBox(
      height: 370,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: getPickupCard(),
          );
        },
      ),
    );
  }

  Widget getPickupCard() {
    return GestureDetector(
      child: Padding(
        padding: _Styles.cardPadding,
        child: CustomCard(
          padding: _Styles.onGoingPickupRequestCustomCardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [getRequestID(), getRequestStatus()],
              ),
              getDivider(),
              getItemDetails(),
              getDivider(),
              getRequestDetails(),
              SizedBox(height: 20),
              getButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRequestDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        getRequestDetailsText(
          icon: Icons.location_on,
          title: 'Pickup Location: ',
          text:
              'No. 1, Jalan Balakong Jaya 1, Taman Balakong Jaya, 43300 Seri Kembangan, Selangor, Malaysia. ',
        ),

        SizedBox(height: 10),

        getRequestDetailsText(
          icon: Icons.access_time,
          title: 'Pickup Time: ',
          text: '29/4/2025, 11pm - 12am',
        ),
      ],
    );
  }

  Widget getRequestDetailsText({
    required IconData icon,
    required String title,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: ColorManager.blackColor,
          size: _Styles.onGoingPickupRequestIconSize,
        ),
        SizedBox(width: 5),
        Expanded(
          child: RichText(
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: title,
              style: _Styles.blackTextStyle,
              children: [TextSpan(text: text, style: _Styles.greyTextStyle)],
            ),
          ),
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

  Widget getRequestID() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Request ID', style: _Styles.requestIDTitleTextStyle),
        Text('#REQ13113', style: _Styles.requestIDTextStyle),
      ],
    );
  }

  Widget getRequestStatus() {
    return CustomStatusBar(text: 'On The Way', color: ColorManager.orangeColor);
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
                'Item Descriptionsas0123213213',
                maxLines: _Styles.max2Lines,
                overflow: TextOverflow.ellipsis,
                style: _Styles.itemDescriptionTextStyle,
              ),
              Text(
                'Category',
                style: _Styles.itemDescriptionTextStyle,
                maxLines: _Styles.max1Line,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Text('Quantity: 1', style: _Styles.quantityTextStyle),
        ],
      ),
    );
  }

  Widget getButton() {
    return CustomButton(
      text: 'Arrived',
      textColor: ColorManager.whiteColor,
      onPressed: () {},
      backgroundColor: ColorManager.primary,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const max1Line = 1;
  static const iconSize = 20.0;

  static const welcomeContainerHeight = 210.0;
  static const collectorImageHeight = 180.0;
  static const ewasteItemImageSize = 80.0;

  static const collectorInfoPadding = EdgeInsets.only(left: 15);
  static const rightPadding = EdgeInsets.only(
    right: 20 + _Styles.collectorImageHeight,
  );

  static const customCardPadding = EdgeInsets.all(10);

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const titleTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.primary,
  );

  static const collectorNameTextStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const infoTextStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const availablePickupTextStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const imageSize = 100.0;
  static const imageBorderRadius = 5.0;
  static const max2Lines = 2;
  static const onGoingPickupRequestIconSize = 15.0;

  static const dividerPadding = EdgeInsets.symmetric(vertical: 6);

  static const cardPadding = EdgeInsets.only(
    bottom: 10,
    top: 10,
    right: 20,
    left: 5,
  );
  static const onGoingPickupRequestCustomCardPadding = EdgeInsets.symmetric(
    vertical: 10,
    horizontal: 10,
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

  static const blackTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const greyTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const ongoingTitleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static final showAllButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(Colors.transparent),
  );

  static const moreTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.primary,
  );
}

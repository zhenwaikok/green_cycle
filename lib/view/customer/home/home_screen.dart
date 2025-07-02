import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';

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
    print('object');
  }

  void onShowAllButtonPressed() {
    context.router.push(AwarenessRoute());
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
        color: ColorManager.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
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
    return CustomCard(children: [getRequestPickupCardContent()]);
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
          'Too busy to drop off recyclables? No problem! Book a pickup and we will collect them right from your home. It is a simple way to make a positive impact.',
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

  Widget getMarketplaceSection() {
    return Column(
      children: [
        getMarketplaceTitle(),
        SizedBox(height: 10),
        getMarketplaceItems(),
      ],
    );
  }

  Widget getMarketplaceTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Old Electronics, New Value', style: _Styles.marketplaceTextStyle),
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

  Widget getMarketplaceItems() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
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
                child: CustomCard(
                  padding: _Styles.customCardPadding,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          width: double.infinity,
                          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D',
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: _Styles.productDetailsPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Product Name',
                                style: _Styles.productNameTextStyle,
                              ),
                              Text(
                                'RM xx.xx',
                                style: _Styles.productPriceTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
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
        Text('What\'s News', style: _Styles.whatNewTextStyle),
        TextButton(
          style: _Styles.showAllButtonStyle,
          onPressed: onShowAllButtonPressed,
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

  static const welcomeContainerHeight = 180.0;

  static const screenPadding = EdgeInsets.only(left: 20, right: 20, bottom: 20);

  static const welcomeContainerPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 15,
  );

  static const customCardPadding = EdgeInsetsGeometry.all(0);

  static const productCardPadding = EdgeInsetsGeometry.only(
    right: 20,
    left: 10,
    top: 10,
    bottom: 10,
  );

  static const productDetailsPadding = EdgeInsetsGeometry.symmetric(
    horizontal: 10,
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

  static const marketplaceTextStyle = TextStyle(
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

  static const productNameTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const productPriceTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.redColor,
  );

  static const whatNewTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
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
}

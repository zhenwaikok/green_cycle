import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/constant/images_manager.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_button.dart';
import 'package:green_cycle_fyp/widget/custom_card.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:green_cycle_fyp/widget/custom_status_bar.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';

@RoutePage()
class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _CheckoutScreen();
  }
}

class _CheckoutScreen extends BaseStatefulPage {
  @override
  State<_CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends BaseStatefulState<_CheckoutScreen> {
  List<String> paymentOptions = ["FPX", 'Debit/Credit Card'];

  String? selectedPaymentOption;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    selectedPaymentOption = paymentOptions.first;
    super.initState();
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Checkout',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget bottomNavigationBar() {
    return getBottomSheet();
  }

  @override
  Widget body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getDeliveryDetailsSection(),
          SizedBox(height: 35),
          getCartItems(),
          SizedBox(height: 25),
          getPaymentOptionSection(),
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CheckoutScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onPaymentOptionChanged(String? value) {
    if (value != null) {
      _setState(() {
        selectedPaymentOption = value;
      });
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CheckoutScreenState {
  Widget getDeliveryDetailsSection() {
    return CustomCard(
      padding: _Styles.customCardPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          getDeliveryTitleAndEditButton(),
          SizedBox(height: 10),
          getDeliveryAddress(),
        ],
      ),
    );
  }

  Widget getDeliveryTitleAndEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Delivery Address', style: _Styles.greyTextStyle),
        TouchableOpacity(child: Text('Edit', style: _Styles.editTextStyle)),
      ],
    );
  }

  Widget getDeliveryAddress() {
    return Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc varius urna eu ultricies egestas.',
      textAlign: TextAlign.justify,
      style: _Styles.deliveryAddressTextStyle,
    );
  }

  Widget getCartItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your Items', style: _Styles.blackTextStyle),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return getCartItemCard();
          },
        ),
      ],
    );
  }

  Widget getCartItemCard() {
    return Padding(
      padding: _Styles.cardPadding,
      child: CustomCard(
        padding: _Styles.customCardPadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getItemImage(),
            SizedBox(width: 10),
            Expanded(child: getItemDetails()),
            getItemCondition(),
          ],
        ),
      ),
    );
  }

  Widget getItemImage() {
    return CustomImage(
      borderRadius: _Styles.itemImageBorderRadius,
      imageSize: _Styles.cartItemImageSize,
      imageURL:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D',
    );
  }

  Widget getItemDetails() {
    return SizedBox(
      height: _Styles.cartItemImageSize,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Product Name',
            style: _Styles.blackSmallTextStyle,
            maxLines: _Styles.maxTextLines,
            overflow: TextOverflow.ellipsis,
          ),
          Text('RM xx.xx', style: _Styles.productPriceTextStyle),
        ],
      ),
    );
  }

  Widget getItemCondition() {
    return CustomStatusBar(text: 'Like New');
  }

  Widget getPaymentOptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Options', style: _Styles.blackTextStyle),
        ...List.generate(
          paymentOptions.length,
          (index) => getPaymentOption(
            option: paymentOptions[index],
            selectedPaymentOption: selectedPaymentOption ?? '',
          ),
        ),
      ],
    );
  }

  Widget getPaymentOption({
    required String option,
    required String selectedPaymentOption,
  }) {
    return Padding(
      padding: _Styles.paymentOptionPadding,
      child: Row(
        children: [
          Image.asset(
            getPaymentOptionIcon(option),
            width: _Styles.paymentOptionIconSize,
            height: _Styles.paymentOptionIconSize,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 15),
          Expanded(child: Text(option, style: _Styles.blackSmallTextStyle)),
          Radio<String>(
            value: option,
            groupValue: selectedPaymentOption,
            onChanged: (value) => onPaymentOptionChanged(value),
            activeColor: ColorManager.primary,
          ),
        ],
      ),
    );
  }

  String getPaymentOptionIcon(String option) {
    switch (option) {
      case "FPX":
        return Images.fpxLogo;
      case "Debit/Credit Card":
        return Images.fpxLogo;
      default:
        return Images.fpxLogo;
    }
  }

  Widget getBottomSheet() {
    return Padding(
      padding: _Styles.bottomSheetPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summary', style: _Styles.blackTextStyle),
          SizedBox(height: 5),
          getOrderSummaryDetails(
            title: 'Items Total (x items)',
            amount: 'RM xx.xx',
          ),
          SizedBox(height: 5),
          getOrderSummaryDetails(title: 'Delivery Fee', amount: 'RM xx.xx'),
          SizedBox(height: 15),
          getTotalPriceDetails(title: 'Total', amount: 'RM xx.xx'),
          SizedBox(height: 15),
          getPlaceOrderButton(),
        ],
      ),
    );
  }

  Widget getOrderSummaryDetails({
    required String title,
    required String amount,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: _Styles.greyTextStyle),
        Text(amount, style: _Styles.blackSmallTextStyle),
      ],
    );
  }

  Widget getTotalPriceDetails({required String title, required String amount}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: _Styles.blackSmallTextStyle),
        Text(amount, style: _Styles.totalPriceTextStyle),
      ],
    );
  }

  Widget getPlaceOrderButton() {
    return CustomButton(
      text: 'Place Order',
      textColor: ColorManager.whiteColor,
      onPressed: () {},
      backgroundColor: ColorManager.primary,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const cartItemImageSize = 80.0;
  static const itemImageBorderRadius = 5.0;
  static const maxTextLines = 2;
  static const paymentOptionIconSize = 60.0;

  static const bottomSheetPadding = EdgeInsets.all(20);

  static const paymentOptionPadding = EdgeInsets.symmetric(vertical: 5);

  static const cardPadding = EdgeInsets.symmetric(vertical: 10);

  static const customCardPadding = EdgeInsets.all(15);

  static const greyTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.greyColor,
  );

  static const blackTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const editTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const deliveryAddressTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const blackSmallTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const productPriceTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.redColor,
  );

  static const totalPriceTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.redColor,
  );
}

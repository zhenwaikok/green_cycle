import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/router/router.gr.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/widget/appbar.dart';
import 'package:green_cycle_fyp/widget/custom_floating_action_button.dart';
import 'package:green_cycle_fyp/widget/search_bar.dart';
import 'package:green_cycle_fyp/widget/second_hand_item.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';

@RoutePage()
class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _MarketplaceScreen();
  }
}

class _MarketplaceScreen extends BaseStatefulPage {
  @override
  State<_MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends BaseStatefulState<_MarketplaceScreen> {
  @override
  EdgeInsets defaultPadding() {
    return EdgeInsets.zero;
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Secondhand Marketplace',
      isBackButtonVisible: false,
    );
  }

  @override
  Widget floatingActionButton() {
    return CustomFloatingActionButton(
      icon: Icon(Icons.shopping_cart_rounded, color: ColorManager.whiteColor),
      onPressed: onCartPressed,
      heroTag: 'marketplace_fab',
    );
  }

  @override
  Widget body() {
    return SingleChildScrollView(
      child: Padding(
        padding: _Styles.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getStartSellingButton(),
            SizedBox(height: 20),
            CustomSearchBar(hintText: 'Search here'),
            SizedBox(height: 25),
            getCategoriesSection(),
            SizedBox(height: 25),
            getRecommendSection(),
          ],
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _MarketplaceScreenState {
  void onCategoryCardPressed() {
    context.router.push(MarketplaceCategoryRoute(category: 'category'));
  }

  void onStartSellingPressed() {
    context.router.push(CreateListingRoute());
  }

  void onCartPressed() {
    context.router.push(CartRoute());
  }

  void onItemPressed() {
    context.router.push(ItemDetailsRoute());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MarketplaceScreenState {
  Widget getStartSellingButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          style: _Styles.startSellingButtonStyle,
          onPressed: onStartSellingPressed,
          child: Text('Start Selling', style: _Styles.startSellingTextStyle),
        ),
      ],
    );
  }

  Widget getCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Categories', style: _Styles.blackTextStyle),

        SizedBox(
          height: MediaQuery.of(context).size.width * 0.18,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (context, index) {
              return getCategoryCard(text: 'Category');
            },
          ),
        ),
      ],
    );
  }

  Widget getCategoryCard({required String text}) {
    return Padding(
      padding: _Styles.categoryCardPadding,
      child: TouchableOpacity(
        onPressed: onCategoryCardPressed,
        child: Container(
          padding: _Styles.categoriesPadding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              _Styles.categoryCardBorderRadius,
            ),
            color: ColorManager.whiteColor,
            boxShadow: [
              BoxShadow(
                color: ColorManager.blackColor.withValues(alpha: 0.15),
                blurRadius: 8,
                spreadRadius: 0.2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(text, style: _Styles.categoryCardTextStyle),
          ),
        ),
      ),
    );
  }

  Widget getRecommendSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recommended For You', style: _Styles.blackTextStyle),
        SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 30,
            crossAxisSpacing: 30,
            mainAxisExtent: 200,
          ),
          itemCount: 7,
          itemBuilder: (context, index) {
            return TouchableOpacity(
              onPressed: onItemPressed,
              child: SecondHandItem(
                imageURL:
                    'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D',
                productName: 'Product Nameasdasdsad',
                productPrice: 'RM xx.xx',
                text: 'Like New',
              ),
            );
          },
        ),
      ],
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const categoryCardBorderRadius = 30.0;

  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );

  static const categoryCardPadding = EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 15,
  );

  static const categoriesPadding = EdgeInsets.symmetric(
    horizontal: 15,
    vertical: 8,
  );

  static final startSellingButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(ColorManager.lightGreyColor2),
  );

  static const startSellingTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const blackTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const categoryCardTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.primary,
  );
}

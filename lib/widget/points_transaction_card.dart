import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PointsTransactionCard extends StatefulWidget {
  const PointsTransactionCard({
    super.key,
    required this.transactionName,
    required this.transactionDate,
    required this.points,
    required this.isEarned,
    required this.isLoading,
  });

  final String transactionName;
  final String transactionDate;
  final String points;
  final bool isEarned;
  final bool isLoading;

  @override
  State<PointsTransactionCard> createState() => _PointsTransactionCardState();
}

class _PointsTransactionCardState extends State<PointsTransactionCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _Styles.cardPadding,
      child: Container(
        padding: _Styles.cardContentPadding,
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.greyColor),
          borderRadius: BorderRadius.circular(_Styles.borderRadius),
        ),
        child: getPointsTransactionContent(isLoading: widget.isLoading),
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _PointsTransactionCardState {
  Widget getPointsTransactionContent({required bool isLoading}) {
    return Skeletonizer(
      enabled: isLoading,
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCoinIcon(),
                SizedBox(width: 15),
                getTransactionDetails(
                  transactionName: widget.transactionName,
                  transactionDate: widget.transactionDate,
                ),
              ],
            ),
          ),
          getPoints(points: widget.points),
        ],
      ),
    );
  }

  Widget getCoinIcon() {
    return Icon(
      FontAwesomeIcons.coins,
      color: ColorManager.primary,
      size: _Styles.coinIconSize,
    );
  }

  Widget getTransactionDetails({
    required String transactionName,
    required String transactionDate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          transactionName,
          style: _Styles.transactionNameTextStyle,
          maxLines: _Styles.textMaxLines,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 10),
        Text(transactionDate, style: _Styles.transactionDateTextStyle),
      ],
    );
  }

  Widget getPoints({required String points}) {
    return Text(
      points,
      style: _Styles.pointsNameTextStyle(isEarned: widget.isEarned),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const borderRadius = 15.0;
  static const coinIconSize = 20.0;
  static const textMaxLines = 2;

  static const cardContentPadding = EdgeInsets.symmetric(
    horizontal: 15,
    vertical: 20,
  );
  static const cardPadding = EdgeInsets.symmetric(vertical: 5, horizontal: 5);

  static const transactionNameTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static TextStyle pointsNameTextStyle({required bool isEarned}) => TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: isEarned ? ColorManager.primary : ColorManager.redColor,
  );

  static const transactionDateTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );
}

import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomAwarenessCard extends StatelessWidget {
  const CustomAwarenessCard({
    super.key,
    required this.imageURL,
    required this.awarenessTitle,
    required this.date,
  });

  final String imageURL;
  final String awarenessTitle;
  final String date;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          CustomImage(
            imageSize: MediaQuery.of(context).size.width * 0.3,
            borderRadius: _Styles.borderRadius,
            imageURL: imageURL,
          ),
          SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    awarenessTitle,
                    style: _Styles.awarenessTitleTextStyle,
                    textAlign: TextAlign.justify,
                    maxLines: _Styles.maxTextLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: _Styles.calendarIconSize,
                        color: ColorManager.greyColor,
                      ),
                      SizedBox(width: 5),
                      Text(date, style: _Styles.dateTextStyle),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 35),
          Skeleton.shade(
            child: Container(
              padding: _Styles.iconContainerPadding,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManager.primary,
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: _Styles.arrowIconSize,
                color: ColorManager.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const calendarIconSize = 15.0;
  static const arrowIconSize = 18.0;
  static const maxTextLines = 3;
  static const borderRadius = 15.0;

  static const iconContainerPadding = EdgeInsets.all(8);

  static const awarenessTitleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const dateTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.greyColor,
  );
}

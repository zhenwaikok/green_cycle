import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/images_manager.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.imageURL,
    this.imageSize,
    this.borderRadius,
    this.imageWidth,
  });

  final String imageURL;
  final double? imageSize;
  final double? borderRadius;
  final double? imageWidth;

  @override
  Widget build(BuildContext context) {
    if (imageURL.isEmpty) {
      return Container(
        height: imageSize,
        width: imageWidth ?? imageSize,
        decoration: BoxDecoration(
          color: ColorManager.lightGreyColor2,
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
        child: Image.asset(Images.greyLogo, fit: BoxFit.cover),
      );
    }

    return SizedBox(
      height: imageSize,
      width: imageWidth ?? imageSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        child: CachedNetworkImage(
          imageUrl: imageURL,
          placeholder: (context, url) => BlurHash(
            hash: 'LNG[ySoeIURj9XWBX5WC0Kt6Rjxa',
            imageFit: BoxFit.cover,
            curve: Curves.bounceInOut,
            duration: Duration(seconds: _Styles.blurDuration),
          ),
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            );
          },
        ),
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const blurDuration = 5;
}

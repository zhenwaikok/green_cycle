import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.imageURL,
    this.imageSize,
    required this.borderRadius,
    this.imageWidth,
  });

  final String imageURL;
  final double? imageSize;
  final double borderRadius;
  final double? imageWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: imageSize,
      width: imageWidth ?? imageSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
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

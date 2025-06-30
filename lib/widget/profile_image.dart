import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class CustomProfileImage extends StatefulWidget {
  const CustomProfileImage({super.key, required this.imageURL});

  final String imageURL;

  @override
  State<CustomProfileImage> createState() => _CustomProfileImageState();
}

class _CustomProfileImageState extends State<CustomProfileImage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _Styles.imageSize,
      width: _Styles.imageSize,
      child: CachedNetworkImage(
        imageUrl: widget.imageURL,
        placeholder: (context, url) => ClipRRect(
          borderRadius: BorderRadius.circular(_Styles.borderRadius),
          child: BlurHash(
            hash: 'LNG[ySoeIURj9XWBX5WC0Kt6Rjxa',
            imageFit: BoxFit.cover,
            curve: Curves.bounceInOut,
            duration: Duration(seconds: _Styles.blurDuration),
          ),
        ),
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_Styles.borderRadius),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
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

  static const blurDuration = 5;
  static const borderRadius = 100.0;
  static const imageSize = 80.0;
}

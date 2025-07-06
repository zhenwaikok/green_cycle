import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/widget/custom_image.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
    required this.items,
    this.onImageChanged,
    required this.imageBorderRadius,
    required this.carouselHeight,
    required this.containerMargin,
  });

  final List<String> items;
  final double imageBorderRadius;
  final double carouselHeight;
  final EdgeInsetsGeometry containerMargin;
  final Function(int, CarouselPageChangedReason)? onImageChanged;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: items
          .map(
            (imageURL) => Container(
              margin: containerMargin,
              width: MediaQuery.of(context).size.width,
              child: CustomImage(
                imageURL: imageURL,
                borderRadius: imageBorderRadius,
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        viewportFraction: 1.0,
        height: carouselHeight,
        onPageChanged: (index, reason) {
          if (onImageChanged != null) {
            onImageChanged!(index, reason);
          }
        },
      ),
    );
  }
}

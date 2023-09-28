import 'package:cached_network_image/cached_network_image.dart';
import 'package:feeds/helper/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ImageWidget extends StatelessWidget {
  final String? image;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final double? labelTopPosition;
  final bool isDissabled;
  final bool showAspect;
  final String? tagLabel;
  final String? itemType;
  final Color? tagBackgroundColor;
  final double? tagFontSize;
  final EdgeInsetsGeometry? tagPadding;
  final double ratio;

  const ImageWidget(
    this.image, {
    Key? key,
    this.fit,
    this.borderRadius,
    this.height,
    this.width,
    this.isDissabled = false,
    this.tagLabel,
    this.itemType,
    this.tagBackgroundColor,
    this.tagPadding,
    this.tagFontSize,
    this.labelTopPosition,
    this.showAspect = false,
    this.ratio = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final img = CachedNetworkImage(
      imageUrl: image ?? '',
      width: width,
      imageBuilder: (context, imageProvider) => AspectRatio(
        aspectRatio: ratio,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: whiteColor,
            image: DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.contain,
            ),
          ),
        ),
      ),
      errorWidget: (context, _, __) => Center(
        child: Image.asset(
          'assets/images/image_error.png',
          fit: fit ?? BoxFit.contain,
          height: 80.0,
        ),
      ),
      fit: fit ?? BoxFit.contain,
      placeholder: (context, _) => Center(
          child: Container(
        height: 200,
      ).animate().shimmer(
                duration: 450.ms,
              )),
    );
    return InteractiveViewer(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.zero,
        ),
        child: img,
      ),
    );
  }
}

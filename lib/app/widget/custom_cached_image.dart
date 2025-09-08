import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/image_manager.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    super.key,
    required this.image,
    this.fit = BoxFit.contain,
    this.height = 200,
    this.width,
    this.filterQuality = FilterQuality.medium,
  });

  final String image;
  final BoxFit fit;
  final double height;
  final double? width;
  final FilterQuality filterQuality;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      filterQuality: filterQuality,
      fit: fit,
      imageUrl: image,
      placeholder:
          (context, url) =>
              const CircularProgressIndicator(color: AppColors.primary),
      errorWidget:
          (context, url, error) => Image.asset(ImageManager.imageError),
    );
  }
}

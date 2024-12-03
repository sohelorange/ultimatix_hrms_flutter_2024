import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../app/app_images.dart';
import 'common_shimmer.dart';

/// Common app image which handles network, assets and local file paths
class CommonAppImage extends StatelessWidget {
  final String imagePath;
  final double radius;
  final double? height;
  final double? width;
  final BoxFit fit;
  final bool isCircle;
  final Color? color;

  const CommonAppImage({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.radius = 0,
    this.isCircle = false,
    this.fit = BoxFit.cover,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: isCircle ? null : BorderRadius.circular(radius), shape: isCircle ? BoxShape.circle : BoxShape.rectangle),
      child: imagePath.isEmpty
          ? Image.asset(
              AppImages.icBackGround,
              height: height,
              width: width,
            )
          : imagePath.startsWith('http')
              ? CachedNetworkImage(
                  imageUrl: imagePath,
                  height: height,
                  width: width,
                  fit: fit,
                  color: color,
                  placeholder: (context, url) => CommonAppShimmer.rectangular(
                    height: height!,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    AppImages.icBackGround,
                    height: height,
                    width: width,
                  ),
                )
              : imagePath.contains('assets')
                  ? Image.asset(
                      imagePath,
                      height: height,
                      width: width,
                      fit: fit,
                      color: color,
                    )
                  : Image.file(
                      File(imagePath),
                      height: height,
                      width: width,
                      fit: fit,
                      color: color,
                    ),
    );
  }
}

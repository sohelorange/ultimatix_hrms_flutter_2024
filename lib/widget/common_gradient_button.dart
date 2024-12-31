import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

class CommonGradientButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onTap;
  final LinearGradient? gradient; // Made it nullable
  final double borderRadius;

  const CommonGradientButton({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onTap,
    this.gradient, // Gradient will now be optional and nullable
    this.borderRadius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: gradient ?? AppColors.gradientBackground,
          // Assign default if null
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonAppImageSvg(
              imagePath: imagePath,
              height: 16,
              width: 16,
              color: AppColors.colorWhite,
            ).paddingOnly(right: 10),
            // CommonAppImage(
            //   color: AppColors.colorWhite,
            //   height: 16,
            //   width: 16,
            //   imagePath: imagePath,
            // ).paddingOnly(right: 10),
            CommonText(
              text: text,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.colorWhite,
            ),
          ],
        ),
      ).paddingOnly(top: 16, bottom: 8),
    );
  }
}

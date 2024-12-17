import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/widget/common_button.dart';

import '../app/app_dimensions.dart';
import '../app/app_font_weight.dart';
import 'common_text.dart';

class CommonMaterialDialog extends StatelessWidget {
  final String title;
  final String message;
  final String yesButtonText;
  final String noButtonText;
  final VoidCallback? onYesPressed;
  final VoidCallback? onNoPressed;

  const CommonMaterialDialog({
    super.key,
    required this.title,
    required this.message,
    required this.yesButtonText,
    required this.noButtonText,
    this.onYesPressed,
    this.onNoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      titlePadding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
      contentPadding: const EdgeInsets.fromLTRB(30, 0, 30, 16),

      // Title with Divider
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            textAlign: TextAlign.start,
            text: title,
            color: AppColors.colorDarkBlue,
            fontSize: AppDimensions.fontSizeLarge,
            fontWeight: AppFontWeight.w500,
          ),
          const SizedBox(height: 8),
          Divider(
              color: AppColors.colorDarkGray.withOpacity(0.2), thickness: 1),
        ],
      ),

      // Message + Actions in a Column
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Message Text
          CommonText(
            textAlign: TextAlign.start,
            text: message,
            color: AppColors.colorDarkBlue,
            fontSize: AppDimensions.fontSizeMedium,
            fontWeight: AppFontWeight.w400,
          ),
          const SizedBox(height: 24),

          // Vertical Buttons
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Yes Button
              CommonButton(
                  buttonText: yesButtonText,
                  onPressed: onYesPressed ?? () {},
                  isLoading: false),

              const SizedBox(height: 20), // Space between buttons

              // No Button
              TextButton(
                onPressed: onNoPressed ?? () => Get.back(),
                child: CommonText(
                  text: noButtonText,
                  color: AppColors.purpleSwatch,
                  fontSize: AppDimensions.fontSizeLarge,
                  fontWeight: AppFontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
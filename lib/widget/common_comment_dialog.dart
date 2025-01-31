import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_dimensions.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_input.dart';
import 'package:ultimatix_hrms_flutter/widget/common_button.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

class CommonCommentDialog extends StatelessWidget {
  final String title; // Dialog title
  final String hintText; // Hint text for input field
  final TextEditingController textController; // Controller for the input field
  final FocusNode focusNode; // Focus node for the input field
  final VoidCallback onConfirm; // Callback for confirm button
  final VoidCallback onCancel; // Callback for cancel button
  final RxBool isLoading; // Reactive variable for loader state

  const CommonCommentDialog({
    super.key,
    required this.title,
    required this.hintText,
    required this.textController,
    required this.focusNode,
    required this.onConfirm,
    required this.onCancel,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => AlertDialog(
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
                  color: AppColors.colorDarkGray.withValues(alpha: 0.2),
                  thickness: 1),
            ],
          ),

          // Message + Actions in a Column
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input Field
              CommonAppInput(
                maxLines: 3,
                textInputAction: TextInputAction.done,
                textEditingController: textController,
                hintText: "Comment",
                focusNode: focusNode,
                textAlign: TextAlign.start,
                // Aligns the input text horizontally to the start (left)
                labelStyle: const TextStyle(
                  color: AppColors.colorDarkBlue,
                ),
                hintStyle: const TextStyle(
                  color: AppColors.colorDarkBlue,
                ),
              ),
              const SizedBox(height: 24),
              isLoading.value
                  ? Center(child: Utils.commonCircularProgress()) // Loader
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CommonButton(
                            buttonText: 'Confirm',
                            onPressed: onConfirm,
                            isLoading: false),

                        const SizedBox(height: 20), // Space between buttons

                        // No Button
                        TextButton(
                          onPressed: onCancel,
                          style: TextButton.styleFrom(
                            overlayColor: Colors.transparent,
                          ),
                          child: CommonText(
                            text: 'Cancel',
                            color: AppColors.purpleSwatch,
                            fontSize: AppDimensions.fontSizeLarge,
                            fontWeight: AppFontWeight.w500,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ));
  }
}

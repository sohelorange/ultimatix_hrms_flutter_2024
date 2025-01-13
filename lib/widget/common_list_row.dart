import 'package:flutter/material.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

import '../app/app_colors.dart';

class CommonListRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? labelColor;
  final Color? valueColor; // New parameter for status color

  const CommonListRow({
    super.key,
    required this.label,
    required this.value,
    this.labelColor = AppColors.colorDarkBlue,
    this.valueColor =
        AppColors.colorDarkGray, // Update constructor to accept status color
  });

  @override
  Widget build(BuildContext context) {
    Color finalValueColor = valueColor ??
        AppColors.colorBlack; // Use provided status color or default color

    // Determine color based on status value
    if (value.toLowerCase() == 'pending' || value.toLowerCase() == 'medium') {
      finalValueColor = Colors.yellow;
    } else if (value.toLowerCase() == 'open' ||
        value.toLowerCase() == 'lower') {
      finalValueColor = Colors.green;
    } else if (value.toLowerCase() == 'close' ||
        value.toLowerCase() == 'higher') {
      finalValueColor = Colors.red;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // Align children to the top
        children: [
          Expanded(
            flex: 7,
            child: CommonText(
              text: label,
              color: labelColor,
              fontSize: 16,
              fontWeight: AppFontWeight.w700,
            ),
          ),
          CommonText(
            text: ' : ',
            fontSize: 14,
            fontWeight: AppFontWeight.w400,
          ),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Align text to the left
              mainAxisAlignment: MainAxisAlignment.center,
              // Center text vertically
              children: [
                CommonText(
                  text: value,
                  color: finalValueColor,
                  fontSize: 14,
                  fontWeight: AppFontWeight.w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

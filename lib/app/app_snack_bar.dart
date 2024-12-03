import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_dimensions.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';

import 'app_colors.dart';

class AppSnackBar {
  static void snackBarSuccessMsg(BuildContext context, String text) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: TextStyle(
            fontWeight: AppFontWeight.w400,
            fontSize: AppDimensions.fontSizeSmall,
            color: AppColors.colorWhite),
      ),
      elevation: 6.0,
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.colorGreen,
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: AppColors.colorWhite,
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void snackBarErrorMsg(BuildContext context, String text) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: TextStyle(
            fontWeight: AppFontWeight.w400,
            fontSize: AppDimensions.fontSizeSmall,
            color: AppColors.colorWhite),
      ),
      elevation: 6.0,
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.colorRed,
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: AppColors.colorWhite,
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showGetXCustomSnackBar(
      {required String message, Color backgroundColor = AppColors.colorRed}) {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        backgroundColor: backgroundColor,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16.0),
        duration: const Duration(seconds: 2),
        borderRadius: 5,
      ),
    );
  }
}

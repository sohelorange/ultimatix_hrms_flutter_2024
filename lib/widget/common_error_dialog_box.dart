import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/app_colors.dart';
import '../app/app_font_weight.dart';
import 'common_app_elevatedbutton.dart';
import 'common_text.dart';

class CommonErrorDialog extends StatelessWidget {
  final String msg;

  const CommonErrorDialog({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              text: "Error",
              fontWeight: AppFontWeight.w500,
              fontSize: 16,
              padding: const EdgeInsets.only(left: 15, right: 15),
              color: AppColors.colorBlack,
            ),
            IconButton(
              color: AppColors.colorBlack,
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.close,
              ),
            )
          ],
        ),
        CommonText(
          text: msg,
          fontWeight: AppFontWeight.w500,
          fontSize: 14,
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          color: AppColors.colorBlack,
        ),
        Row(
          children: [
            Expanded(
              child: CommonAppElevatedButton(
                text: "Ok",
                onClick: () {
                  Get.back();
                },
                isLoading: false,
                buttonBackgroundColor: AppColors.purpleSwatch,
                buttonSplashColor: AppColors.colorWhite,
                textColor: AppColors.colorWhite,
              ),
            ),
          ],
        ).paddingOnly(top: 20)
      ],
    ).paddingAll(15);
  }
}

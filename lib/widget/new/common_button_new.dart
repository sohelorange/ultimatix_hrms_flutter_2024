import 'package:flutter/material.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_style.dart';

import '../../app/app_colors.dart';
import '../../utility/preference_utils.dart';

class CommonButtonNew extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisable;

  const CommonButtonNew({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.isLoading,
    this.isDisable = false,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isDisable,
      child: Opacity(
        opacity: isDisable ? 0.5 : 1.0,
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.color7A1FA2, // Left color
                  //AppColors.color7A1FA2, // Center and Right color
                  AppColors.color303E9F, // Center and Right color
                ],
                stops: [0.05, 0.55],
                tileMode: TileMode.mirror,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.colorWhite),
                        strokeWidth: 3,
                      ),
                    )
                  : Text(buttonText,
                      style: AppFonts.interTextStyle().copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: PreferenceUtils.getIsTheme()
                              ? AppColors.colorWhite
                              : AppColors.colorWhite)
                      // TextStyle(
                      //     color: PreferenceUtils.getIsTheme()
                      //         ? AppColors.colorWhite
                      //         : AppColors.colorWhite,
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w400),
                      ),
            ),
          ),
        ),
      ),
    );
  }
}

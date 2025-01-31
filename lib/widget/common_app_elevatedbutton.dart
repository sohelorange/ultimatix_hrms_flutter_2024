import 'package:flutter/material.dart';

import '../app/app_colors.dart';
import '../app/app_font_weight.dart';
import 'common_text.dart';

/// Common app button used in whole app
// ignore: must_be_immutable
class CommonAppElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final bool isLoading;
  final double? buttonHeight;
  final double? buttonWidth;
  final FontWeight? buttonFontWeight;
  final double? buttonFontSize;
  final Color? textColor;
  int? textMaxLine;
  final Color? buttonSplashColor;
  final Color? buttonBorderColor;
  final Color? buttonBackgroundColor;
  final Gradient? gradient;
  final Color? circularProgressColor;

  CommonAppElevatedButton({
    super.key,
    required this.text,
    required this.onClick,
    required this.isLoading,
    this.buttonHeight,
    this.textMaxLine,
    this.buttonWidth,
    this.buttonFontSize,
    this.buttonFontWeight,
    this.textColor,
    this.circularProgressColor,
    this.gradient,
    this.buttonBorderColor,
    this.buttonBackgroundColor,
    this.buttonSplashColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight ?? 55,
      width: buttonWidth ?? double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: buttonBackgroundColor,
          gradient: gradient,
          borderRadius: BorderRadius.circular(10),
          // boxShadow: const <BoxShadow>[
          //   BoxShadow(
          //     color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
          //     blurRadius: 5,
          //   ) //blur radius of shadow
          // ],
        ),
        child: ElevatedButton(
          onPressed: onClick,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            foregroundColor: buttonSplashColor ?? Colors.white,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            disabledForegroundColor: Colors.transparent.withValues(alpha: 0.38),
            disabledBackgroundColor: Colors.transparent.withValues(alpha: 0.12),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            shape: RoundedRectangleBorder(
              side:
                  BorderSide(color: buttonBorderColor ?? AppColors.colorWhite),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
          child: isLoading
              ? CircularProgressIndicator(
                  color:
                      circularProgressColor ?? AppColors.purpleSwatch.shade900,
                  strokeWidth: 3,
                )
              : CommonText(
                  text: text,
                  fontSize: buttonFontSize ?? 16,
                  fontWeight: buttonFontWeight ?? AppFontWeight.w700,
                  maxLine: textMaxLine ?? 1,
                  color: textColor ?? AppColors.colorWhite,
                ),
        ),
      ),
    );
  }
}

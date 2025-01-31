import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/app_colors.dart';
import '../../app/app_font_style.dart';

/// Common app input used in whole app
class CommonAppInputDateNew extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final TextAlign? textAlign;
  final bool? isPassword;
  final double borderRadius;
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final IconData? suffixIcon;
  final IconData? prifixIcon;
  final Color? prifixColor;
  final Color? suffixColor;
  final VoidCallback? onSuffixClick;
  final VoidCallback? onPrifixClick;
  final TextInputAction textInputAction;
  final Function(String text)? onSubmitted;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String text)? onChanged;
  final Color borderColor;
  final Color? hintColor;
  final bool? isEnable;
  final EdgeInsets? padding;
  final EdgeInsets? prifixPadding;
  final int? maxLength;
  final int? maxLines;
  final String? suFixImage;
  final String? prifixImage;
  final double? inputHeight;
  final double? inputWidth;

  const CommonAppInputDateNew({
    super.key,
    required this.textEditingController,
    this.textInputType = TextInputType.text,
    this.textAlign,
    this.isPassword = false,
    this.borderRadius = 6,
    this.hintText = '',
    this.hintStyle,
    this.hintColor,
    this.labelStyle,
    this.suffixIcon,
    this.prifixIcon,
    this.onSuffixClick,
    this.onPrifixClick,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
    this.focusNode,
    this.nextFocusNode,
    this.inputFormatters,
    this.onChanged,
    this.isEnable,
    this.borderColor = AppColors.colorDCDCDC,
    this.padding,
    this.maxLength,
    this.maxLines,
    this.suFixImage,
    this.prifixImage,
    this.inputHeight,
    this.inputWidth,
    this.prifixPadding,
    this.prifixColor,
    this.suffixColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveBorderColor =
        isEnable == false ? AppColors.colorDCDCDC : borderColor;

    return SizedBox(
      height: inputHeight,
      width: inputWidth ?? double.infinity,
      child: TextFormField(
        onChanged: onChanged,
        textAlign: textAlign ?? TextAlign.start,
        focusNode: focusNode,
        controller: textEditingController,
        cursorColor: AppColors.color303E9F,
        keyboardType: textInputType,
        obscureText: isPassword ?? false,
        textInputAction: textInputAction,
        onFieldSubmitted: (String text) {
          onSubmitted?.call(text);
          nextFocusNode?.requestFocus();
        },
        style: labelStyle,
        inputFormatters: inputFormatters,
        enabled: isEnable,
        maxLength: maxLength,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          counter: const Offstage(),
          hintText: hintText,
          isDense: true,
          labelStyle: labelStyle ??
              AppFonts.interTextStyle().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: hintColor ?? effectiveBorderColor,
              ),
          hintStyle: hintStyle ??
              AppFonts.interTextStyle().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: hintColor ?? effectiveBorderColor,
              ),
          contentPadding: padding ??
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: effectiveBorderColor, width: 1),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: effectiveBorderColor, width: 1),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: effectiveBorderColor, width: 1),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.color7A1FA2, width: 1),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}

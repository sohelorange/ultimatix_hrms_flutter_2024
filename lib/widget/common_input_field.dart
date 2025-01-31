import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app/app_colors.dart';
import '../app/app_font_style.dart';

/// Common app input used in whole app
class CommonInputField extends StatelessWidget {
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

  const CommonInputField({
    super.key,
    required this.textEditingController,
    this.textInputType = TextInputType.text,
    this.textAlign,
    this.isPassword = false,
    this.borderRadius = 10,
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
    this.borderColor = AppColors.purpleSwatch,
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
    return SizedBox(
      height: inputHeight,
      width: inputWidth ?? double.infinity,
      child: TextFormField(
        onChanged: onChanged,
        textAlign: textAlign ?? TextAlign.start,
        focusNode: focusNode,
        controller: textEditingController,
        cursorColor: AppColors.colorUnderline,
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
          suffixIconConstraints:
              const BoxConstraints(minWidth: 16, minHeight: 39),
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkResponse(
                    radius: 12,
                    onTap: onSuffixClick,
                    child: Icon(
                      suffixIcon,
                      size: 20,
                      color: suffixColor,
                    ),
                  ),
                )
              : suFixImage != null
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkResponse(
                        radius: 12,
                        onTap: onSuffixClick,
                        child: Image.asset(
                          suFixImage!,
                          height: 20,
                          width: 20,
                          color: suffixColor,
                        ),
                      ),
                    )
                  : null,
          prefixIcon: prifixIcon != null
              ? Padding(
                  padding: prifixPadding ?? const EdgeInsets.only(left: 10),
                  child: InkResponse(
                    radius: 15,
                    onTap: onPrifixClick,
                    child: Icon(
                      prifixIcon,
                      size: 18,
                      color: AppColors.purpleSwatch,
                    ),
                  ),
                )
              : prifixImage != null
                  ? Padding(
                      padding: prifixPadding ?? const EdgeInsets.only(left: 10),
                      child: InkResponse(
                        radius: 15,
                        onTap: onPrifixClick,
                        child: Image.asset(
                          prifixImage!,
                          height: 20,
                          width: 20,
                          color: prifixColor,
                        ),
                      ),
                    )
                  : null,
          labelText: hintText,
          // Label text moves above when focused or text entered
          labelStyle: labelStyle ??
              AppFonts.dMSansTextStyle()
                  .copyWith(fontSize: 16, color: hintColor ?? borderColor),
          //hintText: hintText,
          // Acts as a label when no text is entered
          hintStyle: hintStyle ??
              AppFonts.dMSansTextStyle()
                  .copyWith(fontSize: 16, color: hintColor ?? borderColor),
          isDense: true,
          contentPadding: padding ??
              const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 10,
              ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.colorDarkBlue.withValues(alpha: 0.1),
              // Your desired color
              width: 1.0, // Your desired width
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.colorUnderline, // Your desired color
              width: 1.0, // A wider border for focused state
            ),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withValues(alpha: 0.5),
              // Dull gray for disabled state
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}

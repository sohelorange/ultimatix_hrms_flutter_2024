import 'package:flutter/material.dart';

import '../app/app_colors.dart';
import '../app/app_font_style.dart';
import '../app/app_font_weight.dart';

// ignore: must_be_immutable
class CommonText extends StatelessWidget {
  String text;
  FontWeight? fontWeight;
  double? fontSize;
  Color? color;
  Color? underlineColor;
  int? maxLine;
  TextDecoration? decorationUnderline;
  EdgeInsetsGeometry? padding;
  TextAlign? textAlign;
  bool? softWrap;
  TextOverflow? overflow;

  CommonText({
    super.key,
    required this.text,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.maxLine,
    this.decorationUnderline,
    this.padding,
    this.textAlign,
    this.underlineColor,
    this.softWrap,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        text,
        maxLines: maxLine,
        textAlign: textAlign,
        softWrap: softWrap ?? true,
        overflow: overflow ?? TextOverflow.visible,
        //style: AppFonts.dMSansTextStyle().copyWith(
        style: AppFonts.interTextStyle().copyWith(
          fontSize: fontSize ?? 14,
          fontWeight: fontWeight ?? AppFontWeight.medium,
          overflow: TextOverflow.ellipsis,
          color: color ?? AppColors.purpleSwatch,
          decoration: decorationUnderline,
          decorationColor: underlineColor ?? AppColors.purpleSwatch,
        ),
      ),
    );
  }
}

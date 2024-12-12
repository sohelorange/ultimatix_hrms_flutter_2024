import 'package:flutter/material.dart';

/// All app colors are defined here
class AppColors {
  AppColors._();

// Purple color shades for your theme
  static const MaterialColor purpleSwatch = MaterialColor(
    0xFF9C27B0, // Primary color for MaterialColor (Purple 500)
    <int, Color>{
      50: Color(0xFFF3E5F5), // Purple 50
      100: Color(0xFFE1BEE7), // Purple 100
      // Purple 100
      200: Color(0xFFCE93D8), // Purple 200
      300: Color(0xFFBA68C8), // Purple 300
      400: Color(0xFFAB47BC), // Purple 400
      500: Color(0xFF9C27B0), // Purple 500
      600: Color(0xFF8E24AA), // Purple 600
      700: Color(0xFF7B1FA2),
      800: Color(0xFF6A1B9A), // Purple 800
      900: Color(0xFF4A148C),
    },
  );


  // Primary Purple Color (Purple color for UI)
  static const Color colorPurple = Color(0xFF7B1FA2);

  // Dark Blue Color
  static const Color colorDarkBlue = Color(0xFF1C1F37);

  // Dark Gray Color
  static const Color colorDarkGray = Color(0xFF6B6D7A);

  // Gradient Colors
  static const Color colorGradientStart = Color(0xFF161F59); // Start of gradient
  static const Color colorGradientEnd = Color(0xFF631983); // End of gradient

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF7F8FC); // Light background
  static const Color lightPrimary = colorPurple;  // Primary Purple for light theme
  static const Color lightAccent = colorDarkBlue;  // Accent color (dark blue) for light theme

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);  // Dark background
  static const Color darkPrimary = colorPurple;  // Primary Purple for dark theme
  static const Color darkAccent = colorDarkGray;  // Accent color (dark gray) for dark theme

  // Optional: You can also define the gradient directly, but this isn't a color
  static LinearGradient gradientBackground = const LinearGradient(
    colors: [colorGradientStart, colorGradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Other colors
  static const Color colorStatusBar = Color(0XFFF9F6FC);
  static const Color colorAppBar = Color(0XFFF9F6FC);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorBlack = Color(0xFF000000);
  static const Color color1C1F37 = Color(0xFF1C1F37);
  static const Color colorAF84DD = Color(0xFFAF84DD);
  static const Color colorF4F2FF = Color(0xFFF4F2FF);
  static const Color colorGreen = Colors.green;
  static const Color colorRed = Colors.red;
  static const Color colorUnderline =Color(0XFF4F1B78);

  static const Color color1F1100 = Color(0xFF1F1100);
  static const Color colorCBCBCB = Color(0xFFCBCBCB);
  static const Color color9C9BA2 = Color(0xFF9C9BA2);
  static const Color colorF2F2F2 = Color(0xFFF2F2F2);
  static const Color colorE9E8E7 = Color(0xFFE9E8E7);
  static const Color colorEC9C25 = Color(0xFFEC9C25);
  static const Color color4285F4 = Color(0xFF4285F4);
  static const Color color9675CE = Color(0xFF9675CE);
  static const Color colorFDF1E0 = Color(0xFFFDF1E0);
  static const Color colorFDF5EBFF = Color(0xFFFDF5EB);
  static const Color colorF18700 = Color(0xFFF18700);
  static const Color colorDEA500 = Color(0xFFDEA500);
  static const Color colorF68C1F = Color(0xFFF68C1F);
  static const Color colorAAAE01 = Color(0xFFAAAE01);
  static const Color color79C12D = Color(0xFF79C12D);
  static const Color color34A853 = Color(0xFF34A853);
  static const Color color53A100 = Color(0xFF53A100);
  static const Color colorF45A42 = Color(0xFFF45A42);
  static const Color colorEA4335 = Color(0xFFEA4335);
  static const Color colorD33017 = Color(0xFFD33017);
  static const Color colorF6807E = Color(0xFFF6807E);
  static const Color colorCDA4FB = Color(0xFFd6b4fc);
  static const Color colorab5a68 = Color(0xFFab5a68);
  static const Color colorbe7f89 = Color(0xFFd1a4ab);
  static const Color colorac6cc = Color(0xFFFEF4E9);
  static const Color color68C1F = Color(0xFFF68C1F);
  static const Color colorFAA53 = Color(0xFFFFAA53);
  static const Color color6B6D7A = Color(0xFF6B6D7A);
  static const Color colorE1E1E1 = Color(0xFFE1E1E1);
  static const Color color7B1FA2 = Color(0xFF7B1FA2);
  static const Color colorF7F8FC = Color(0xFFF7F8FC);
  static const Color colorAppBars = Color(0xFFF9F6FC);
  static const Color colorAppPurple = Color(0xFF7920A2);
  static const Color color631983 = Color(0xFF631983);
  static const Color colorLightPurple1 = Color(0xFFEDE8F1);
  static const Color colorLightPurple2 = Color(0xFFC3AAD0);
  static const Color colorF8F4FA = Color(0xFFF8F4FA);
  static const Color colorBlueDark = Color(0xFF1C1F37);
}

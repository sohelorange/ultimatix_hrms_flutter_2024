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
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorBlack = Color(0xFF000000);
  static const Color color1C1F37 = Color(0xFF1C1F37);
  static const Color colorAF84DD = Color(0xFFAF84DD);
  static const Color colorF4F2FF = Color(0xFFF4F2FF);
  static const Color colorGreen = Colors.green;
  static const Color colorRed = Colors.red;
}

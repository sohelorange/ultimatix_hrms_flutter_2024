import 'package:flutter/material.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.purpleSwatch,
      colorScheme: const ColorScheme.light(primary: AppColors.purpleSwatch),
      scaffoldBackgroundColor: AppColors.colorWhite,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.purpleSwatch,
        selectedItemColor: AppColors.colorWhite,
        unselectedItemColor: AppColors.colorBlack,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.purpleSwatch,
        iconTheme: IconThemeData(color: AppColors.colorWhite),
        titleTextStyle: TextStyle(
          color: AppColors.colorWhite,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: AppColors.colorBlack),
        // Customize label color for light theme
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors
                  .black), // Customize border color for disabled state in light theme
        ),
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
            bodySmall: const TextStyle(
              color: AppColors.colorBlack,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),

            //bodyMedium: const TextStyle(
            //  color: AppColors.colorBlack,
            //  fontWeight: FontWeight.bold,
            //  fontSize: 20,
            //),

            //bodyLarge: const TextStyle(
            //  color: AppColors.colorBlack,
            //  fontWeight: FontWeight.bold,
            //  fontSize: 24,
            //),
          ),

      //cardTheme: const CardTheme(color: AppColors.colorWhite)

      cardColor: AppColors.colorWhite,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: AppColors.colorWhite));

  static ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.purpleSwatch,
      colorScheme: const ColorScheme.dark(primary: AppColors.purpleSwatch),
      scaffoldBackgroundColor: Colors.grey,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.purpleSwatch,
        selectedItemColor: AppColors.colorBlack,
        unselectedItemColor: AppColors.colorWhite,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.purpleSwatch,
        iconTheme: IconThemeData(color: AppColors.colorWhite),
        titleTextStyle: TextStyle(
          color: AppColors.colorWhite,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: AppColors.colorWhite),
        // Customize label color for dark theme
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors
                  .white), // Customize border color for disabled state in dark theme
        ),
      ),
      textTheme: ThemeData.dark().textTheme.copyWith(
            bodySmall: const TextStyle(
              color:
                  AppColors.colorWhite, // Set text color to white in dark mode
              fontWeight: FontWeight.normal, // Set normal font weight
              fontSize: 16, // Set default font size
            ),

            //bodyMedium: const TextStyle(
            //  color: AppColors.colorWhite, // Set text color to white in dark mode
            //  fontWeight: FontWeight.bold, // Set bold font weight
            //  fontSize: 20, // Set larger font size for titles
            //),

            //bodyLarge: const TextStyle(
            //  color: AppColors.colorWhite,
            //  fontWeight: FontWeight.bold,
            //  fontSize: 24,
            //),
          ),
      cardColor: AppColors.colorBlack,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: AppColors.colorWhite));
}

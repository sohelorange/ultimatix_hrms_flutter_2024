import 'package:flutter/material.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';

class CommonContainer extends StatelessWidget {
  final Widget child;

  const CommonContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.colorAppBar,
            AppColors.colorAppBar,
            AppColors.colorAppBar,
          ],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white, // Background color
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), // Top-left radius
            topRight: Radius.circular(20), // Top-right radius
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4, // Add a blur to make the shadow visible
              offset: const Offset(0, 4), // Slight vertical shadow offset
            ),
          ],
        ),
        child: child, // Pass the child to display content
      ),
    );
  }
}

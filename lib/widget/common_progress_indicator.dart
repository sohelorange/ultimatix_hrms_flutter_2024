import 'package:flutter/material.dart';

import '../app/app_colors.dart';
import '../component/common_painter.dart';
import '../utility/preference_utils.dart';

class CommonWithCircularProgressBar extends StatelessWidget {
  final String name;
  final int percentage;

  const CommonWithCircularProgressBar({
    super.key,
    required this.name,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 82,
                width: 82,
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: percentage / 100),
                  duration: const Duration(milliseconds: 500),
                  // Adjust the duration as needed
                  builder: (context, value, child) {
                    return CustomPaint(
                      painter: CommonCircularProgressPainter(
                        percentage: (value * 100).toInt(),
                        backgroundColor: const Color(0xFF4E5772),
                        gradientColors: [
                          const Color(0xFFFBB040),
                          const Color(0xFFF69F1D),
                          const Color(0xFFED5000),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Text(
                '$percentage%',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: PreferenceUtils.getIsTheme()
                        ? AppColors.colorBlack
                        : AppColors.colorBlack),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              textAlign: TextAlign.center,
              name,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: PreferenceUtils.getIsTheme()
                      ? AppColors.colorBlack
                      : AppColors.colorBlack),
            ),
          ),
        ],
      ),
    );
  }
}

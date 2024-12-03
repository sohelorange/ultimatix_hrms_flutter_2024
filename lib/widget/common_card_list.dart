import 'package:flutter/material.dart';

import '../app/app_colors.dart';
import '../component/common_painter.dart';
import '../utility/preference_utils.dart';

class CommonMultipleCardList extends StatelessWidget {
  final String count;
  final String text;
  final int percentage;

  const CommonMultipleCardList({
    super.key,
    required this.count,
    required this.text,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      width: MediaQuery.of(context).size.width,
      //margin: const EdgeInsets.only(right: 10),
      //padding: const EdgeInsets.symmetric(horizontal: 10),

      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 70,
              width: 70,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.purpleSwatch,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              //child: SvgPicture.asset(
              //  imagePath,
              //  color: AppColors.colorWhite,
              //  fit: BoxFit.contain,
              //),
              child: Center(
                child: Text(
                  count,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: PreferenceUtils.getIsTheme()
                          ? AppColors.colorWhite
                          : AppColors.colorWhite),
                ),
              )),
          Expanded(
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: PreferenceUtils.getIsTheme()
                      ? AppColors.colorBlack
                      : AppColors.colorBlack,
                ),
              ),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 50,
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
                    fontSize: 11,
                    color: PreferenceUtils.getIsTheme()
                        ? AppColors.colorBlack
                        : AppColors.colorBlack),
              ),
            ],
          ),
          //const SizedBox(
          //  width: 20,
          //)
        ],
      ),
    );
  }
}

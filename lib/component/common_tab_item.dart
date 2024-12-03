import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/app_colors.dart';

class CommonTabItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final bool check;

  const CommonTabItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.check,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imagePath,
            width: 15,
            height: 15,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(
              check ? AppColors.colorWhite : AppColors.colorBlack,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 5), // Add some space between image and text
          Flexible(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: check
                    ? AppColors.colorWhite
                    : AppColors
                        .colorBlack, // Use text color of the current theme
              ),
            ),
          ),
        ],
      ),
    );
  }
}

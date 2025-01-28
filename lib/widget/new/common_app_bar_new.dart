import 'package:flutter/material.dart';
import '../../app/app_colors.dart';

class CommonNewAppBar extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final List<Widget> trailingWidgets;
  final VoidCallback? onLeadingIconTap;

  const CommonNewAppBar({
    super.key,
    required this.title,
    required this.leadingIcon,
    this.onLeadingIconTap,
    required this.trailingWidgets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: 350,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.color303E9F, AppColors.color7A1FA2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(leadingIcon, color: Colors.white),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Row(
            children: trailingWidgets,
          ),
        ],
      ),
    );
  }
}

/*
Container(
                height: 58,
                width: 350,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.color303E9F, AppColors.color7A1FA2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.menu, color: Colors.white),
                        SizedBox(width: 20),
                        Text(
                          'Title Text',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                            color: AppColors.colorWhite,
                            AppImages.dashRefreshIcon),
                        SizedBox(width: 10),
                        Icon(Icons.notifications, color: Colors.white),
                        SizedBox(width: 10),
                        CommonAppImage(
                            height: 25,
                            width: 25,
                            imagePath: AppImages.icAppLogo),
                      ],
                    ),
                  ],
                ),
              ),
*/
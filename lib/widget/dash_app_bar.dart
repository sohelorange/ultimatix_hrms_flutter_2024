import 'package:flutter/material.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';

import '../app/app_colors.dart';
import '../app/app_status_bar.dart';
import 'common_text.dart';

class DashAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String profileImageUrl;
  final String name;
  final String designation;
  final List<Widget>? actions;

  const DashAppBar({
    super.key,
    required this.profileImageUrl,
    required this.name,
    required this.designation,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    AppStatusBar.setStatusBarStyle(
      statusBarColor: AppColors.colorAppBar,
    );

    return Container(
      height: preferredSize.height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.colorAppBar,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // This ensures content on both sides
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Info
          Expanded(
            child: Row(
              children: [
                // Profile Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  // Rounded corners with radius 10
                  child: profileImageUrl.isEmpty
                      ? const CommonAppImageSvg(
                          imagePath: AppImages.svgAvatar, // Default SVG image
                          height: 56,
                          width: 56,
                          fit:
                              BoxFit.cover, // Ensures the image fills the space
                        )
                      : CommonAppImageSvg(
                          imagePath: profileImageUrl, // Use profile image URL
                          height: 56,
                          width: 56,
                          fit:
                              BoxFit.cover, // Ensures the image fills the space
                        ),
                ),
                const SizedBox(width: 12),
                // Name and Designation
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText(
                      text: name,
                      fontWeight: FontWeight.w400,
                      color: AppColors.colorDarkBlue,
                      fontSize: 16,
                    ),
                    CommonText(
                      text: designation,
                      fontWeight: FontWeight.w700,
                      color: AppColors.colorDarkBlue,
                      fontSize: 18,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Actions (placed on the right side)
          if (actions != null) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: actions!,
            ),
          ],
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(74);
}

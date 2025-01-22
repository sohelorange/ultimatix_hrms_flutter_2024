import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';

import '../app/app_colors.dart';
import '../app/app_status_bar.dart';
import 'common_text.dart';

class DashAppBar extends StatelessWidget implements PreferredSizeWidget {
  //final String profileImageUrl;
  final ValueNotifier<String> profileImageUrlNotifier;
  final String name;
  final String designation;
  final List<Widget>? actions;
  final bool showEditIcon;
  final bool showBackIcon; // Add this flag to control the back icon visibility
  final VoidCallback? onProfileImageClick;
  final VoidCallback? onEditIconClick;
  final VoidCallback? onBackIconClick; // Add callback for back icon click

  const DashAppBar({
    super.key,
    required this.profileImageUrlNotifier,
    required this.name,
    required this.designation,
    this.actions,
    this.showEditIcon = false,
    this.showBackIcon = false, // Default to false (hidden on dashboard)
    this.onProfileImageClick,
    this.onEditIconClick,
    this.onBackIconClick,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Info
          Expanded(
            child: Row(
              children: [
                // Back Icon - Show only if showBackIcon is true
                if (showBackIcon)
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: onBackIconClick ??
                        () {
                          Get.back();
                        },
                  ),

                // Profile Image with Gesture Detector and Conditional Pencil Icon
                Stack(
                  children: [
                    GestureDetector(
                      onTap: onProfileImageClick,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // Adjust radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.5),
                              spreadRadius: 0,
                              blurRadius: 0,
                              offset: const Offset(0, 0), // Shadow position
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ValueListenableBuilder<String>(
                            valueListenable: profileImageUrlNotifier,
                            // A ValueNotifier wrapping profileImageUrl
                            builder: (context, profileImageUrl, child) {
                              if (profileImageUrl.isNotEmpty) {
                                // Show the camera-uploaded image
                                if (profileImageUrl.startsWith('/')) {
                                  // Local file path
                                  return Image.file(
                                    File(profileImageUrl),
                                    height: 56,
                                    width: 56,
                                    fit: BoxFit.cover,
                                  );
                                } else {
                                  // Network image
                                  return Image.network(
                                    profileImageUrl,
                                    height: 56,
                                    width: 56,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      // Fallback to placeholder if the network image fails
                                      return const CommonAppImageSvg(
                                        imagePath: AppImages.svgAvatar,
                                        // Default placeholder SVG image
                                        height: 56,
                                        width: 56,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  );
                                }
                              } else {
                                // Show the placeholder if no image is set
                                return const CommonAppImageSvg(
                                  imagePath: AppImages.svgAvatar,
                                  height: 56,
                                  width: 56,
                                  fit: BoxFit.cover,
                                );
                              }
                            },
                          ),
                        ),
                        // child: ClipRRect(
                        //   borderRadius: BorderRadius.circular(10),
                        //   child: profileImageUrl.isNotEmpty
                        //       ? Image.network(
                        //           profileImageUrl,
                        //           height: 56,
                        //           width: 56,
                        //           fit: BoxFit.cover,
                        //           errorBuilder: (context, error, stackTrace) {
                        //             return const CommonAppImageSvg(
                        //               imagePath: AppImages.svgAvatar,
                        //               height: 56,
                        //               width: 56,
                        //               fit: BoxFit.cover,
                        //             );
                        //           },
                        //         )
                        //       : const CommonAppImageSvg(
                        //           imagePath: AppImages.svgAvatar,
                        //           height: 56,
                        //           width: 56,
                        //           fit: BoxFit.cover,
                        //         ),
                        // ),

                        // child: ClipRRect(
                        //   borderRadius: BorderRadius.circular(10),
                        //   child: profileImageUrl.isEmpty
                        //       ? const CommonAppImageSvg(
                        //           imagePath:
                        //               AppImages.svgAvatar, // Default SVG image
                        //           height: 56,
                        //           width: 56,
                        //           fit: BoxFit
                        //               .cover, // Ensures the image fills the space
                        //         )
                        //       : CommonAppImageSvg(
                        //           imagePath:
                        //               profileImageUrl, // Use profile image URL
                        //           height: 56,
                        //           width: 56,
                        //           fit: BoxFit
                        //               .cover, // Ensures the image fills the space
                        //         ),
                        // ),
                      ),
                    ),
                    if (showEditIcon)
                      Positioned(
                        bottom: -8, // Align the icon exactly at the bottom
                        right: -6, // Align the icon exactly at the right edge
                        child: GestureDetector(
                          onTap: onEditIconClick,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: AppColors.colorPurple,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 16,
                              color: Colors.white, // Icon color set to white
                            ),
                          ),
                        ),
                      ),
                  ],
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
                      maxLine: 1,
                      overflow: TextOverflow.ellipsis,
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

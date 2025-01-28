import 'package:flutter/material.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

class CommonExploreGridViewNew extends StatelessWidget {
  final List<dynamic> gridItems;
  final int selectedIndex;
  final void Function(int) onItemTap;

  const CommonExploreGridViewNew({
    super.key,
    required this.gridItems,
    required this.selectedIndex,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        mainAxisExtent: 66, // Custom grid height
      ),
      itemCount: gridItems.length,
      itemBuilder: (context, index) {
        String name;
        String iconPath;
        bool visible = true; // Default visibility
        Color boxColor = AppColors.colorWhite; // Default box color

        if (gridItems[index] is Map<String, dynamic>) {
          name = gridItems[index]['name'] ?? '';
          iconPath = gridItems[index]['icon'] ?? '';
          visible = gridItems[index]['visible'] ?? true;
          boxColor = gridItems[index]['boxColor'] ?? AppColors.colorWhite;
        } else if (gridItems[index] is String) {
          name = gridItems[index];
          iconPath = '';
          visible = true;
          boxColor = AppColors.colorWhite;
        } else {
          name = '';
          iconPath = '';
          visible = true;
          boxColor = AppColors.colorWhite;
        }

        // Hide the widget if visible is false
        if (!visible) {
          return const SizedBox.shrink();
        }

        return GestureDetector(
          onTap: () => onItemTap(index),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon
                iconPath.isEmpty
                    ? const CommonAppImageSvg(
                        imagePath: AppImages.svgAvatar,
                        height: 20,
                        width: 20,
                        fit: BoxFit.cover,
                      )
                    : CommonAppImageSvg(
                        imagePath: iconPath,
                        height: 20,
                        width: 20,
                        fit: BoxFit.cover,
                      ),
                const SizedBox(width: 8),

                // Text with wrap enabled
                Expanded(
                  child: CommonText(
                    textAlign: TextAlign.start,
                    text: name,
                    color: AppColors.color2F2F31,
                    fontSize: 14,
                    fontWeight: AppFontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

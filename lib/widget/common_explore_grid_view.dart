import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';

import '../app/app_font_weight.dart';
import '../app/app_images.dart';
import 'common_app_image_svg.dart';
import 'common_text.dart';

class CommonExploreGridView extends StatelessWidget {
  final List<Map<String, dynamic>> gridItems;
  final RxInt selectedIndex;
  final void Function(int) onItemTap;

  const CommonExploreGridView({
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
        return Obx(() {
          bool isSelected = selectedIndex.value == index;

          return GestureDetector(
            onTap: () => onItemTap(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.purpleSwatch : AppColors.colorWhite,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon
                  gridItems[index]['icon'].toString().isEmpty
                      ? CommonAppImageSvg(
                    imagePath: AppImages.svgAvatar,
                    height: 20,
                    width: 20,
                    color: isSelected ? Colors.white : Colors.black,
                    fit: BoxFit.cover,
                  )
                      : CommonAppImageSvg(
                    imagePath: gridItems[index]['icon'],
                    height: 20,
                    width: 20,
                    color: isSelected
                        ? AppColors.colorWhite
                        : AppColors.colorDarkGray,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),

                  // Text with wrap enabled
                  Expanded(
                    child: CommonText(
                      textAlign: TextAlign.start,
                      text: gridItems[index]['name'],
                      color: isSelected
                          ? AppColors.colorWhite
                          : AppColors.colorDarkGray,
                      fontSize: 14,
                      fontWeight: AppFontWeight.w400,
                      //maxLine: 2,
                      // softWrap: true, // Allows the text to wrap onto multiple lines
                      // overflow: TextOverflow.visible, // Prevents clipping
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}

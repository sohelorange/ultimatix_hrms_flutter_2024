import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';

import '../app/app_font_weight.dart';
import 'common_text.dart';

class CommonYearMonthGridView extends StatelessWidget {
  final List<dynamic> gridItems; // Updated to dynamic
  final RxInt selectedIndex;
  final void Function(int) onItemTap;

  const CommonYearMonthGridView({
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

          String name;

          if (gridItems[index] is Map<String, dynamic>) {
            name = gridItems[index]['name'] ?? '';
          } else if (gridItems[index] is String) {
            name = gridItems[index];
          } else {
            name = '';
          }

          return GestureDetector(
            onTap: () => onItemTap(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color:
                    isSelected ? AppColors.purpleSwatch : AppColors.colorWhite,
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0X1C1F370D),
                    blurRadius: 0.0,
                    spreadRadius: 1.0,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Center(
                child: CommonText(
                  textAlign: TextAlign.center,
                  text: name,
                  color: isSelected
                      ? AppColors.colorWhite
                      : AppColors.colorDarkGray,
                  fontSize: 14,
                  fontWeight: AppFontWeight.w400,
                  // maxLine: 2, // You can re-enable text wrapping if needed
                  // softWrap: true, // Allows the text to wrap onto multiple lines
                  // overflow: TextOverflow.visible, // Prevents clipping
                ),
              ),
            ),
          );
        });
      },
    );
  }
}

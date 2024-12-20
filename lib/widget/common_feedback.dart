import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';

import '../app/app_font_weight.dart';
import 'common_text.dart';

class CommonFeedbackTab extends StatelessWidget {
  final List<Map<String, dynamic>> gridItems;
  final RxInt selectedIndex;
  final void Function(int) onItemTap;

  const CommonFeedbackTab({
    super.key,
    required this.gridItems,
    required this.selectedIndex,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      //padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 0.0,
        mainAxisExtent: 46, // Custom grid height
      ),
      itemCount: gridItems.length,
      itemBuilder: (context, index) {
        return Obx(() {
          bool isSelected = selectedIndex.value == index;

          return GestureDetector(
            onTap: () {
              onItemTap(index);
            },
            child: Container(
              //padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.purpleSwatch : Colors.grey[200],
                // Gray color for unselected
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0X1C1F370D),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Center(
                child: CommonText(
                  textAlign: TextAlign.center,
                  text: gridItems[index]['name'],
                  color: isSelected
                      ? AppColors.colorWhite // White color for selected item
                      : AppColors.colorDarkGray,
                  fontSize: 12,
                  fontWeight: AppFontWeight.w400,
                ),
              ),
            ),
          );
        });
      },
    );
  }
}

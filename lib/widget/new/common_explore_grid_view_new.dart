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
    // Filter visible items
    final visibleItems = gridItems.where((item) {
      if (item is Map<String, dynamic>) {
        return item['visible'] ?? true;
      }
      return true;
    }).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        // Use ListView if fewer items are visible
        bool useListView = visibleItems.length <= 2;

        return useListView
            ? ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          itemCount: visibleItems.length,
          itemBuilder: (context, index) => _buildItem(visibleItems, index),
        )
            : GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            mainAxisExtent: 66,
          ),
          itemCount: visibleItems.length,
          itemBuilder: (context, index) => _buildItem(visibleItems, index),
        );
      },
    );
  }

  Widget _buildItem(List<dynamic> items, int index) {
    final item = items[index];
    String name = '';
    String iconPath = '';
    Color boxColor = AppColors.colorWhite;

    if (item is Map<String, dynamic>) {
      name = item['name'] ?? '';
      iconPath = item['icon'] ?? '';
      boxColor = item['boxColor'] ?? AppColors.colorWhite;
    } else if (item is String) {
      name = item;
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
  }
}

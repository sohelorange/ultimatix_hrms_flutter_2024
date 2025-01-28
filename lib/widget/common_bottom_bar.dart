import 'package:flutter/material.dart';

import '../app/app_colors.dart';
import 'common_app_image_svg.dart';
import 'common_text.dart';

class CommonBottomNavBar extends StatefulWidget {
  final List<BottomNavItem> items;
  final int initialIndex;
  final Function(int) onTabSelected;

  const CommonBottomNavBar({
    super.key,
    required this.items,
    this.initialIndex = 0,
    required this.onTabSelected,
  });

  @override
  State<CommonBottomNavBar> createState() => _CommonBottomNavBarState();
}

class _CommonBottomNavBarState extends State<CommonBottomNavBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onTabSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      //color: AppColors.colorAppBar,
      color: AppColors.color010A46,
      elevation: 10,
      shadowColor: Colors.grey.shade400,
      child: SizedBox(
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widget.items.map((item) {
            final int index = widget.items.indexOf(item);
            final bool isSelected = _selectedIndex == index;

            return Expanded(
              child: InkWell(
                splashColor: Colors.transparent, // Splash effect color
                highlightColor: Colors.transparent, // Highlight effect color
                onTap: () => _onItemTapped(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min, // Prevent overflow
                  children: [
                    // if (isSelected)
                    //   Container(
                    //     //margin: const EdgeInsets.only(bottom: 10),
                    //     height: 1,
                    //     width: double.infinity,
                    //     color: AppColors.colorDarkGray,
                    //   ),

                    CommonAppImageSvg(
                      imagePath: isSelected
                          ? item.selectedIconPath
                          : item.unselectedIconPath,
                      height: 20,
                      width: 20,
                      // color: isSelected
                      //     ? AppColors.colorDarkBlue
                      //     : AppColors.colorDarkGray,
                      fit: BoxFit.cover, // Ensures the image fills the space
                    ),
                    const SizedBox(height: 4),
                    CommonText(
                        text: item.label,
                        fontWeight: FontWeight.w400,
                        // color: isSelected
                        //     ? AppColors.colorPurple
                        //     : AppColors.colorDarkGray,
                        color: AppColors.colorWhite,
                        fontSize: 10),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class BottomNavItem {
  final String selectedIconPath; // Path to the selected asset (SVG/PNG)
  final String unselectedIconPath; // Path to the unselected asset
  final String label;

  BottomNavItem({
    required this.selectedIconPath,
    required this.unselectedIconPath,
    required this.label,
  });
}

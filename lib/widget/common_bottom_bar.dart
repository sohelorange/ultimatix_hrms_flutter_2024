import 'package:flutter/material.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';

import '../app/app_colors.dart';
import 'common_app_image.dart';
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
      color: AppColors.colorAppBar,
      elevation: 10,
      shadowColor: Colors.grey.shade400,
      child: SizedBox(
        height: Utils.getScreenHeight(context: context) / 5.5, // Set a fixed height for the BottomAppBar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widget.items.map((item) {
            final int index = widget.items.indexOf(item);
            final bool isSelected = _selectedIndex == index;
            return Expanded(
              child: InkWell(
                onTap: () => _onItemTapped(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min, // Prevent overflow
                  children: [
                    if (isSelected)
                      Container(
                        //margin: const EdgeInsets.only(bottom: 10),
                        height: 1,
                        width: double.infinity,
                        color: AppColors.colorDarkGray,
                      ),
                    CommonAppImage(
                      imagePath: isSelected
                          ? item.selectedIconPath
                          : item.unselectedIconPath,
                      color: isSelected
                          ? AppColors.colorDarkBlue
                          : AppColors.colorDarkGray,
                      height: 20,
                      width: 20,
                    ),
                    //Icon(
                    //  isSelected ? item.selectedIconPath : item.unselectedIconPath,
                    //  color: isSelected
                    //      ? AppColors.colorDarkBlue
                    //      : AppColors.colorDarkGray,
                    //  size: 20,
                    //),
                    const SizedBox(height: 4),
                    CommonText(
                        text: item.label,
                        fontWeight: FontWeight.w400,
                        color: isSelected
                            ? AppColors.colorDarkBlue
                            : AppColors.colorDarkGray,
                        fontSize: 10),
                    //Text(
                    //  item.label,
                    //  style: TextStyle(
                    //    color: isSelected ? Colors.blue : Colors.grey,
                    //    fontSize: 12, // Set a smaller font size
                    //  ),
                    //),
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

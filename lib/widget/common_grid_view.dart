import 'package:flutter/material.dart';

import '../app/app_colors.dart';
import '../app/app_font_weight.dart';
import '../app/app_images.dart';
import 'common_app_image_svg.dart';
import 'common_text.dart';

class CommonGridView extends StatelessWidget {
  final List<Map<String, dynamic>> statusData;

  // final List<Map<String, dynamic>> statusData = [
  //   {
  //     'color': const Color(0XFF34A853),
  //     'icon': AppImages.dashPresentIcon,
  //     'name': 'Present',
  //     'count': 4,
  //   },
  //   {
  //     'color': const Color(0XFFEA4335),
  //     'icon': AppImages.dashLeaveIcon,
  //     'name': 'Leave',
  //     'count': 4,
  //   },
  //   {
  //     'color': const Color(0XFFF68C1F),
  //     'icon': AppImages.dashAbsentIcon,
  //     'name': 'Absent',
  //     'count': 2,
  //   },
  //   {
  //     'color': const Color(0XFF4285F4),
  //     'icon': AppImages.dashOnDutyIcon,
  //     'name': 'On Duty',
  //     'count': 3,
  //   },
  //   {
  //     'color': const Color(0XFFAF84DD),
  //     'icon': AppImages.dashHolidayIcon,
  //     'name': 'Holiday',
  //     'count': 1,
  //   },
  //   {
  //     'color': const Color(0XFFAAAE01),
  //     'icon': AppImages.dashWeekOffIcon,
  //     'name': 'Week Off',
  //     'count': 5,
  //   },
  // ];

  const CommonGridView({super.key, required this.statusData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // This enables scrolling with the main layout
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true, // This ensures that the GridView only takes up as much space as it needs
            physics: const NeverScrollableScrollPhysics(), // Prevents the grid from scrolling independently
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              mainAxisExtent: 66
            ),
            itemCount: statusData.length, // The number of items in the grid
            itemBuilder: (context, index) {
              return Container(
                //height: 75, // Fixed height for each item
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: statusData[index]['color'].withOpacity(0.1), // Set the background color
                ),
                child: Row(
                  children: [
                    statusData[index]['icon'].toString().isEmpty
                        ? const CommonAppImageSvg(
                      imagePath: AppImages.svgAvatar, // Default SVG image
                      height: 20,
                      width: 20,
                      fit:
                      BoxFit.cover, // Ensures the image fills the space
                    )
                        : CommonAppImageSvg(
                      imagePath: statusData[index]['icon'], // Use profile image URL
                      height: 20,
                      width: 20,
                      fit:
                      BoxFit.cover, // Ensures the image fills the space
                    ),
                    const SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display the name of the status
                        CommonText(
                          textAlign: TextAlign.start,
                          text: statusData[index]['name'],
                          color: AppColors.color6B6D7A,
                          fontSize: 16,
                          fontWeight: AppFontWeight.w400,
                        ),
                        // Display the count of the status
                        CommonText(
                          textAlign: TextAlign.start,
                          text: statusData[index]['count'].toString(),
                          color: AppColors.colorDarkBlue,
                          fontSize: 12,
                          fontWeight: AppFontWeight.w400,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

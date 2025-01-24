import 'package:flutter/material.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';



class CommonGridViewNew extends StatelessWidget {
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

  const CommonGridViewNew({super.key, required this.statusData});

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                        CommonText(
                          textAlign: TextAlign.start,
                          text: statusData[index]['count'].toString(),
                          color: AppColors.color7B758E,
                          fontSize: 14,
                          fontWeight: AppFontWeight.w400,
                        ),

                      ],
                    ),
                    CommonText(
                      textAlign: TextAlign.start,
                      text: statusData[index]['name'],
                      color: AppColors.color2F2F31,
                      fontSize: 16,
                      fontWeight: AppFontWeight.w400,
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

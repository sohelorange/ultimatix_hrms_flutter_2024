import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

class CommonAppDrawer extends StatefulWidget {
  final List<CommonDrawerItem> items;
  final Function(int) onTabSelected;
  final ValueNotifier<String> profileValueNotifier;
  final ValueNotifier<String> nameValueNotifier;
  final ValueNotifier<String> designationValueNotifier;

  const CommonAppDrawer({
    super.key,
    required this.items,
    required this.onTabSelected,
    required this.profileValueNotifier,
    required this.nameValueNotifier,
    required this.designationValueNotifier,
  });

  @override
  State<CommonAppDrawer> createState() => _CommonAppDrawerState();
}

class _CommonAppDrawerState extends State<CommonAppDrawer> {
  void _onItemTapped(int index) {
    widget.onTabSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
              Get.toNamed(AppRoutes.profileRoute);
            },
            child: ClipOval(
              child: ValueListenableBuilder<String>(
                valueListenable: widget.profileValueNotifier,
                builder: (context, profileImageUrl, child) {
                  if (profileImageUrl.isNotEmpty) {
                    return Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          profileImageUrl,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const CommonAppImageSvg(
                              imagePath: AppImages.svgAvatar,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const CommonAppImageSvg(
                        imagePath: AppImages.svgAvatar,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                },
              ),
            ).paddingOnly(top: 20),
          ),
          const SizedBox(height: 10),
          ValueListenableBuilder<String>(
            valueListenable: widget.nameValueNotifier,
            builder: (context, name, child) {
              return CommonText(
                text: name,
                color: AppColors.color2F2F31,
                fontSize: 18,
                fontWeight: AppFontWeight.w500,
              );
            },
          ),
          ValueListenableBuilder<String>(
            valueListenable: widget.designationValueNotifier,
            builder: (context, designation, child) {
              return CommonText(
                text: designation,
                color: AppColors.color7B758E,
                fontSize: 14,
                fontWeight: AppFontWeight.w400,
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return Column(
                  children: [
                    CommonDrawerItem(
                      icon: item.icon,
                      text: item.text,
                      onTap: () => _onItemTapped(index),
                    ),
                    const Divider(
                      height: 0.5,
                      color: AppColors.colorDCDCDC,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class CommonDrawerItem extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback? onTap;

  const CommonDrawerItem({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CommonAppImageSvg(
        imagePath: icon,
        height: 20,
        width: 20,
        fit: BoxFit.cover,
      ),
      title: CommonText(
        text: text,
        color: AppColors.color2F2F31,
        fontSize: 14,
        fontWeight: AppFontWeight.w400,
      ),
      onTap: onTap,
    );
  }
}

// Define ValueNotifiers for dynamic updates
final ValueNotifier<String> profileValueNotifier = ValueNotifier<String>('');
final ValueNotifier<String> nameValueNotifier =
    ValueNotifier<String>('Vivek Singh');
final ValueNotifier<String> designationValueNotifier =
    ValueNotifier<String>('UI/UX Designer');

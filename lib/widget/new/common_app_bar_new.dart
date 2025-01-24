import 'package:flutter/material.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';
import '../../app/app_colors.dart';

class CommonNewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData leadingIcon;
  final VoidCallback? onLeadingIconTap;
  final List<Widget>? trailingWidgets;

  const CommonNewAppBar({
    super.key,
    required this.title,
    required this.leadingIcon,
    this.onLeadingIconTap,
    this.trailingWidgets,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      // Spacing above and below
      child: Container(
        height: preferredSize.height,
        width: Utils.getScreenWidth(context: context) * 0.9,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.color303E9F, AppColors.color7A1FA2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        Scaffold.of(context).openDrawer();
                      }
                    },
                    //child: Icon(leadingIcon, color: AppColors.colorWhite),
                    child: Icon(leadingIcon, color: AppColors.colorWhite,size: 30,),
                  ),
                ),
                const SizedBox(width: 20),
                CommonText(
                  text: title,
                  color: AppColors.colorWhite,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ],
            ),
            if (trailingWidgets != null)
              Row(
                children: trailingWidgets!,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(96);
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../app/app_colors.dart';
import '../../app/app_font_weight.dart';
import '../../app/app_images.dart';
import '../../app/app_status_bar.dart';
import '../common_text.dart';

class CommonAppBarTwo extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CommonAppBarTwo({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    AppStatusBar.setStatusBarStyle(
      statusBarColor: AppColors.colorAppBar,
      //statusBarIconBrightness: Brightness.dark,
      //statusBarBrightness: Brightness.light, // For iOS
    );

    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: IconButton(onPressed: () {
        Navigator.pop(context);
      }, icon: SvgPicture.asset(AppImages.backBtnSvg,height: 12,width: 15,)),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.color2F2F31,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: actions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0), // Height of the bottom line
        child: Container(
          color: AppColors.colorDCDCDC, // Color of the bottom line
          height: 1.0, // Thickness of the bottom line
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

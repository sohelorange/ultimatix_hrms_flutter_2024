import 'package:flutter/material.dart';

import '../app/app_colors.dart';
import '../app/app_font_weight.dart';
import '../app/app_status_bar.dart';
import 'common_text.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CommonAppBar({
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
      backgroundColor: AppColors.colorAppBar,
      centerTitle: true,
      //title: Text(title),
      title: CommonText(
        text: title,
        color: AppColors.colorDarkBlue,
        fontSize: 20,
        fontWeight: AppFontWeight.w500,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

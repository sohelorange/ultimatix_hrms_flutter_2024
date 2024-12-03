import 'package:flutter/material.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';

import '../utility/preference_utils.dart';

class CommonButtonWithoutLoading extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CommonButtonWithoutLoading({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  //@override
  //_CustomButtonWithoutLoadingState createState() =>
  //    _CustomButtonWithoutLoadingState();

  @override
  State<CommonButtonWithoutLoading> createState() =>
      _CommonButtonWithoutLoadingState();
}

class _CommonButtonWithoutLoadingState
    extends State<CommonButtonWithoutLoading> {
  bool _isButtonEnabled = true;

  @override
  Widget build(BuildContext context) {
    //ThemeData theme = Theme.of(context);
    Color buttonColor =
        _isButtonEnabled ? AppColors.purpleSwatch : AppColors.purpleSwatch;
    //Color textColor =
    //    theme.brightness == Brightness.light ? AppColors.colorWhite : AppColors.colorBlack;

    return SizedBox(
      height: 30,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isButtonEnabled ? () => _handleOnPressed() : null,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(buttonColor),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        child: Text(
          widget.buttonText,
          style: TextStyle(
              color: PreferenceUtils.getIsTheme()
                  ? AppColors.colorWhite
                  : AppColors.colorWhite,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _handleOnPressed() {
    if (!mounted) return; // Check if the widget is still mounted

    setState(() {
      _isButtonEnabled = false;
    });

    // Call the provided onPressed callback
    widget.onPressed.call();

    // After 3 seconds, enable the button again
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Check if the widget is still mounted before calling setState
        setState(() {
          _isButtonEnabled = true;
        });
      }
    });
  }
}

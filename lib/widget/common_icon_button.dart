import 'package:flutter/material.dart';

class CommonIconButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const CommonIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  //@override
  //_CustomIconButtonState createState() => _CustomIconButtonState();

  @override
  State<CommonIconButton> createState() => _CommonIconButtonState();
}

class _CommonIconButtonState extends State<CommonIconButton> {
  bool _isButtonEnabled = true;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      //color: PreferenceUtils.getIsTheme() ? AppColors.colorBlack : Colors.grey,
      icon: Icon(widget.icon),
      onPressed: _isButtonEnabled ? () => _handleOnPressed() : null,
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

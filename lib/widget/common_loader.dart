import 'package:flutter/material.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/ic_app_logo.gif',
        width: 50.0, // Adjust the width as needed
        height: 50.0, // Adjust the height as needed
        fit: BoxFit.cover,
      ),
    );
  }
}

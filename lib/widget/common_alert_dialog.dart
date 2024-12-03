import 'package:flutter/cupertino.dart';

class CommonDialog extends StatelessWidget {
  final String title;
  final String message;
  final String cancelButtonText;
  final String logoutButtonText;
  final VoidCallback? onPressed;

  const CommonDialog({
    super.key,
    required this.title,
    required this.message,
    required this.cancelButtonText,
    required this.logoutButtonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            //Navigator.of(context).pop();
            Navigator.pop(context);
          },
          child: Text(
            cancelButtonText,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        CupertinoDialogAction(
          onPressed: onPressed ?? () {},
          // If onPressed is null, use empty function
          isDestructiveAction: true,
          child: Text(
            logoutButtonText,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

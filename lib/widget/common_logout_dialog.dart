import 'package:flutter/cupertino.dart';

/*class LogoutDialog extends StatelessWidget {
  final VoidCallback onLogoutPressed;

  const LogoutDialog({
    super.key,
    required this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Padding(
        padding: EdgeInsets.only(bottom: 8), // Add bottom padding
        child: Text(
          "Logout",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: const Padding(
        padding: EdgeInsets.only(top: 8), // Add top padding
        child: Text(
          "Are you sure you want to logout?",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "Cancel",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        CupertinoDialogAction(
          onPressed: onLogoutPressed,
          isDestructiveAction: true,
          child: const Text(
            "Logout",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}*/

class CommonLogoutDialog extends StatefulWidget {
  final VoidCallback onLogoutPressed;

  const CommonLogoutDialog({
    super.key,
    required this.onLogoutPressed,
  });

  @override
  State<CommonLogoutDialog> createState() => _CommonLogoutDialogState();
}

class _CommonLogoutDialogState extends State<CommonLogoutDialog> {
  bool _loggingOut = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Text(
          "Logout",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: _loggingOut
          ? const Center(child: CupertinoActivityIndicator())
          : const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                "Are you sure you want to logout?",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
      actions: [
        if (!_loggingOut) // Show the "Cancel" button only if not logging out
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        CupertinoDialogAction(
          onPressed: _loggingOut ? null : _handleLogout,
          isDestructiveAction: true,
          child: Text(
            _loggingOut ? "Logging out..." : "Logout",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  void _handleLogout() {
    setState(() {
      _loggingOut = true;
    });

    // Simulate a logout action with a 3-second delay
    Future.delayed(const Duration(seconds: 1), () {
      // Execute the actual logout action
      widget.onLogoutPressed();

      // Close the dialog after logout
      if(mounted) {
        Navigator.pop(context);
      }
    });
  }
}

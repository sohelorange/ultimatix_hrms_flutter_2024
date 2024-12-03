import 'package:flutter/cupertino.dart';

import '../app/app_colors.dart';
import '../utility/preference_utils.dart';

class CommonConfirmationDialog extends StatelessWidget {
  final String title;
  final String placeholder;
  final TextEditingController textEditingController;
  final VoidCallback onYesPressed;
  final VoidCallback onNoPressed;

  const CommonConfirmationDialog({
    super.key,
    required this.title,
    required this.placeholder,
    required this.textEditingController,
    required this.onYesPressed,
    required this.onNoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      content: CupertinoTextField(
        textInputAction: TextInputAction.done,
        controller: textEditingController,
        placeholder: placeholder,
        style: TextStyle(color: PreferenceUtils.getIsTheme() ? AppColors.colorWhite : AppColors.colorBlack),
        placeholderStyle: TextStyle(color: PreferenceUtils.getIsTheme() ? AppColors.colorWhite : AppColors.colorBlack),
        maxLines: null,
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: onNoPressed,
          child: const Text(
            'No',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: onYesPressed,
          child: const Text(
            'Yes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CommonSwitch extends StatelessWidget {
  final bool isEnabled;
  final ValueChanged<bool> onChanged;

  const CommonSwitch({
    super.key,
    required this.isEnabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!isEnabled); // Toggle the state
      },
      child: Container(
        width: 50,
        height: 28,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: isEnabled ? Colors.purple : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.purple,
            width: 2,
          ),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: isEnabled ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: isEnabled ? Colors.white : Colors.purple,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

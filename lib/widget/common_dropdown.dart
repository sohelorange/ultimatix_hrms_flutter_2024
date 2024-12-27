import 'package:flutter/material.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';

import '../app/app_font_weight.dart';
import 'common_text.dart';

class CommonDropdown extends StatefulWidget {
  final List<String> items;
  final String? initialValue;
  final String? hint;
  final Function(String)? onChanged;

  const CommonDropdown({
    super.key,
    required this.items,
    this.initialValue,
    this.hint,
    this.onChanged,
  });

  @override
  State<CommonDropdown> createState() => _CommonDropdownState();
}

class _CommonDropdownState extends State<CommonDropdown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    // Set initial value dynamically, defaulting to null to show the hint.
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        height: 45,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0, color: AppColors.colorDarkGray),
          ),
        ),
        child: DropdownButton<String>(
          value: selectedValue,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              color: AppColors.colorDarkGray),
          underline: const SizedBox(),
          hint: widget.hint != null
              ? CommonText(
                  text: widget.hint!,
                  fontWeight: AppFontWeight.w400,
                  fontSize: 16,
                  color: AppColors.colorDarkBlue,
                )
              : null,
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: CommonText(
                text: value,
                fontWeight: AppFontWeight.w400,
                fontSize: 16,
                color: AppColors.colorDarkBlue,
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue;
            });
            if (newValue != null && widget.onChanged != null) {
              widget.onChanged!(newValue);
            }
          },
        ),
      ),
    );
  }
}

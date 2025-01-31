import 'package:flutter/material.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

class CommonDropdownNew extends StatefulWidget {
  final List<String> items;
  final String? initialValue;
  final String? hint;
  final Function(String)? onChanged;

  const CommonDropdownNew({
    super.key,
    required this.items,
    this.initialValue,
    this.hint,
    this.onChanged,
  });

  @override
  State<CommonDropdownNew> createState() => _CommonDropdownState();
}

class _CommonDropdownState extends State<CommonDropdownNew> {
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
        //height: 45,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 3,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1.0,
            color: AppColors.colorDCDCDC,
          ),
          borderRadius: BorderRadius.circular(8.0),
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
                  color: AppColors.color7B758E,
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

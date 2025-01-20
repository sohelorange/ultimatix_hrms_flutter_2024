import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';

import '../app/app_font_weight.dart';
import 'common_text.dart';

class CommonDropdownWithModel<T> extends StatefulWidget {
  final List<T> items;
  final String? initialValue;
  final String? hint;
  final String Function(T) displayValue;
  final String Function(T) value;
  final Function(String)? onChanged;

  const CommonDropdownWithModel({
    super.key,
    required this.items,
    this.initialValue,
    this.hint,
    required this.displayValue,
    required this.value,
    this.onChanged,
  });

  @override
  State<CommonDropdownWithModel> createState() =>
      _CommonDropdownWithModelState<T>();
}

class _CommonDropdownWithModelState<T>
    extends State<CommonDropdownWithModel<T>> {
  // Reactive String for selected value
  RxString selectedValue = ''.obs;

  @override
  void initState() {
    super.initState();
    // Set the initial value, if provided
    if (widget.initialValue != null) {
      selectedValue.value = widget.initialValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Ensure there's exactly one item with the selected value
      T? selectedItem;
      if (widget.items.isNotEmpty) {
        selectedItem = widget.items.firstWhere(
          (item) => widget.value(item) == selectedValue.value,
          orElse: () =>
              widget.items.first, // Default to the first item if not found
        );
      }

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
            value: selectedValue.value.isNotEmpty ? selectedValue.value : null,
            // Ensure a value exists
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
            items: widget.items.map<DropdownMenuItem<String>>((T value) {
              final itemValue = widget.value(value);
              return DropdownMenuItem<String>(
                value: itemValue,
                child: CommonText(
                  text: widget.displayValue(value),
                  fontWeight: AppFontWeight.w400,
                  fontSize: 16,
                  color: AppColors.colorDarkBlue,
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                selectedValue.value = newValue; // Update the selected value
                if (widget.onChanged != null) {
                  widget.onChanged!(newValue);
                }
              }
            },
          ),
        ),
      );
    });
  }
}

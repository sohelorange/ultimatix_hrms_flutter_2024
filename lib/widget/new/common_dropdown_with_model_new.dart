import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

class CommonDropdownWithModelNew<T> extends StatefulWidget {
  final List<T> items;
  final String? initialValue;
  final String? hint;
  final String Function(T) displayValue;
  final String Function(T) value;
  final Function(String)? onChanged;

  const CommonDropdownWithModelNew({
    super.key,
    required this.items,
    this.initialValue,
    this.hint,
    required this.displayValue,
    required this.value,
    this.onChanged,
  });

  @override
  State<CommonDropdownWithModelNew> createState() =>
      _CommonDropdownWithModelState<T>();
}

class _CommonDropdownWithModelState<T>
    extends State<CommonDropdownWithModelNew<T>> {
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
      // ignore: unused_local_variable
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
          //height: 50,
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
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value:
                  selectedValue.value.isNotEmpty ? selectedValue.value : null,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.colorDarkGray,
              ),
              hint: widget.hint != null
                  ? CommonText(
                      text: widget.hint!,
                      fontWeight: AppFontWeight.w400,
                      fontSize: 16,
                      color: AppColors.color7B758E,
                    )
                  : null,
              items: widget.items.map<DropdownMenuItem<String>>((T value) {
                final itemValue = widget.value(value);
                return DropdownMenuItem<String>(
                  value: itemValue,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          8.0), // Rounded corners for items
                    ),
                    //padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    child: Align(
                      alignment: Alignment.centerLeft, // Align text to the left
                      child: CommonText(
                        text: widget.displayValue(value),
                        fontWeight: AppFontWeight.w400,
                        fontSize: 16,
                        color: AppColors.colorDarkBlue,
                      ),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  selectedValue.value = newValue;
                  if (widget.onChanged != null) {
                    widget.onChanged!(newValue);
                  }
                }
              },
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(
                6.0,
              ), // Rounded corners for dropdown menu
            ),
          ),
        ),
      );
    });
  }
}

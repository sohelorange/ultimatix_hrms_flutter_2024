import 'package:flutter/material.dart';

class CommonDropdown extends StatefulWidget {
  const CommonDropdown({super.key});

  @override
  State<CommonDropdown> createState() => _CommonDropdownState();
}

class _CommonDropdownState extends State<CommonDropdown> {
  String selectedValue = "Full Day";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 45,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.grey),
          ),
        ),
        child: DropdownButton<String>(
          value: selectedValue,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          underline: const SizedBox(),
          items: <String>['Full Day', 'Half Day', 'Quarter Day']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue!;
            });
          },
        ),
      ),
    );
  }
}

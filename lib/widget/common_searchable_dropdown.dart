import 'package:flutter/material.dart';

class CommonSearchableDropdown extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final String hintText;
  final String? labelText;
  final void Function(Map<String, dynamic>)? onChanged;

  const CommonSearchableDropdown({
    super.key,
    required this.items,
    required this.hintText,
    this.labelText,
    this.onChanged,
  });

  @override
  State<CommonSearchableDropdown> createState() =>
      _CommonSearchableDropdownState();
}

class _CommonSearchableDropdownState extends State<CommonSearchableDropdown> {
  //late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    //_controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    /*return TypeAheadField<Map<String, dynamic>>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: _controller,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          isDense: false,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.colorBlack),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.colorBlack),
          ),
        ),
        style: const TextStyle(color: AppColors.colorBlack),
      ),
      suggestionsCallback: (pattern) async {
        return widget.items.where((item) =>
            item['Text'].toLowerCase().contains(pattern.toLowerCase()));
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion['Text']),
        );
      },
      onSuggestionSelected: (suggestion) {
        setState(() {
          _controller.text = suggestion['Text'];
          widget.onChanged?.call(suggestion);
        });
      },
    );*/
  }
}

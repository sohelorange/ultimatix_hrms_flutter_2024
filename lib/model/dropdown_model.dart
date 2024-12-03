class DropdownModel {
  final String text;
  final String value;

  DropdownModel({required this.text, required this.value});

  @override
  String toString() {
    //return '$statusName ($statusCode)';
    return text;
  }
}

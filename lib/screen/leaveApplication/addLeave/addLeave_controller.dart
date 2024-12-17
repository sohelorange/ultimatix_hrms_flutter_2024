import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

class AddleaveController extends GetxController  {
  Rx<TextEditingController> leaveController = TextEditingController().obs;
  Rx<TextEditingController> fromDateController = TextEditingController().obs;
  Rx<TextEditingController> periodController = TextEditingController().obs;
  Rx<TextEditingController> toDateController = TextEditingController().obs;
  Rx<TextEditingController> reasonController = TextEditingController().obs;


  RxString leavetypes = 'Boarding'.obs;
  RxList<String> leavetypeitems = <String>[
    'Boarding',
    'Lodging',
    'Conveyance',
    'Other Miscellaneous',
  ].obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<DateTime> toDate = DateTime.now().obs;

  Future<String> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      toDate.value = picked;
      debugPrint(formattedDate);
      return formattedDate;
    } else {
      return '';
    }
  }

}
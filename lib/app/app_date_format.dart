import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';

class AppDatePicker {
  static String currentUTCFormatDate() {
    DateFormat dateFormat = DateFormat(Utils.commonUTCDateFormat);
    String currentDate = dateFormat.format(DateTime.now());
    return currentDate;
  }

  static String currentDate() {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    String currentDate = dateFormat.format(DateTime.now());
    return currentDate;
  }

  static String currentYYYYMMDDDate() {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String currentDate = dateFormat.format(DateTime.now());
    return currentDate;
  }

  static String currentYear() {
    DateFormat yearFormat = DateFormat('yyyy');
    String strYear = yearFormat.format(DateTime.now());
    return strYear;
  }

  static String currentMonth() {
    DateFormat monthFormat = DateFormat('MM');
    String strMonth = monthFormat.format(DateTime.now());
    return strMonth;
  }

  static String currentDay() {
    DateFormat dayFormat = DateFormat('dd');
    String strDay = dayFormat.format(DateTime.now());
    return strDay;
  }

  static String formatDateWithDay(DateTime dateTime) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy, EEEE');
    //DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    String selected = dateFormat.format(dateTime);
    return selected;
  }

  static String formatDateWithDDMMYYYY(DateTime dateTime) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    String selected = dateFormat.format(dateTime);
    return selected;
  }

  static String yearMMMDDForm(String dateString) {
    final DateTime date = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  static String dateMMMForm(String dateString) {
    final DateTime date = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('dd-MMM-yyyy');
    return formatter.format(date);
  }

  static void allDateEnable(
      BuildContext context, TextEditingController controller) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(int.parse(currentYear()), 12, 31),
      //firstDate: DateTime.now(),//Previous Date Disable
      //lastDate: DateTime.now(),//Future Date Disable
      initialEntryMode: DatePickerEntryMode.calendarOnly,

      /*helpText: "SELECT BOOKING DATE",
      cancelText: "NOT NOW",
      confirmText: "BOOK NOW",
      fieldHintText: "DATE/MONTH/YEAR",
      fieldLabelText: "BOOKING DATE",
      errorFormatText: "Enter a Valid Date",
      errorInvalidText: "Date Out of Range",
      initialDatePickerMode: DatePickerMode.day,*/
    );

    if (selected != null) {
      controller.text = formatDateWithDay(selected);
    }
  }

  static void allDateChangeEnable(
    BuildContext context,
    TextEditingController controller, {
    required Function(DateTime) onDateChanged,
  }) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(int.parse(currentYear()), 12, 31),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (selected != null) {
      controller.text = formatDateWithDay(selected);
      onDateChanged(selected); // Notify that the date has changed.
    }
  }

  static void previousDateDisable(
      BuildContext context, TextEditingController controller) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      //lastDate: DateTime(int.parse(currentYear()), 12, 31),
      lastDate: DateTime(2100, 12, 31),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (selected != null) {
      controller.text = formatDateWithDay(selected);
    }
  }

  static void futureDateDisable(
      BuildContext context, TextEditingController controller) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (selected != null) {
      controller.text = formatDateWithDay(selected);
    }
  }

  static String convertDateTimeFormat(
      String inputDate, String inputDateFormat, String outputDateFormat) {
    DateFormat inputParser = DateFormat(inputDateFormat);
    DateFormat outputParser = DateFormat(outputDateFormat);
    var date = inputParser.parse(inputDate);
    String outPutData = outputParser.format(date);
    return outPutData;
  }

  static String convertDateFormatInputOutputDate(String inputDate) {
    DateFormat inputParser = DateFormat(Utils.commonUTCDateFormat);
    DateFormat outputParser = DateFormat('dd/MM/yyyy');
    var date = inputParser.parse(inputDate);
    String outPutData = outputParser.format(date);
    return outPutData;
  }

  static String convertDateFormatInputOutputTime(String inputDate) {
    DateFormat inputParser = DateFormat('dd/MM/yyyy HH:mm');
    DateFormat outputParser = DateFormat('HH:mm');
    var date = inputParser.parse(inputDate);
    String outPutData = outputParser.format(date);
    return outPutData;
  }

  static String firstDayOfYear() {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateTime firstDay = DateTime(DateTime.now().year, 1, 1);
    return dateFormat.format(firstDay);
  }

  static String lastDayOfYear() {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateTime lastDay = DateTime(DateTime.now().year, 12, 31);
    return dateFormat.format(lastDay);
  }
}

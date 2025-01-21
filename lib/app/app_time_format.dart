import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppTimePicker {
  static String currentTime12() {
    DateFormat timeFormat = DateFormat('hh:mm a');
    String currentTime = timeFormat.format(DateTime.now());
    return currentTime;

    //String currentTime1 = DateFormat.jm().format(DateTime.now());
  }

  static String currentTime24() {
    DateFormat timeFormat = DateFormat('HH:mm');
    String currentTime = timeFormat.format(DateTime.now());
    return currentTime;

    //String currentTime1 = DateFormat.jm().format(DateTime.now());
  }

  static String formatTime12(DateTime dateTime) {
    DateFormat timeFormat = DateFormat('hh:mm a');
    String selected = timeFormat.format(dateTime);
    return selected;
  }

  static String formatTime2(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    DateFormat timeFormat = DateFormat('hh:mm');
    String selected = timeFormat.format(dateTime);
    return selected;
  }

  static String formatTime24(TimeOfDay time) {
    final int hour = time.hour;
    final int minute = time.minute;

    // Format with leading zeros if needed
    final String hourStr = hour.toString().padLeft(2, '0');
    final String minuteStr = minute.toString().padLeft(2, '0');

    return '$hourStr:$minuteStr';
  }

  static void allTimeEnable24(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (timeOfDay != null) {
      controller.text = formatTime24(timeOfDay);
    }
  }

  static void allTimeEnable12(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      //initialTime: const TimeOfDay(hour: 12, minute: 00),
      initialEntryMode: TimePickerEntryMode.dial,
      //confirmText: "CONFIRM",
      //cancelText: "NOT NOW",
      //helpText:
      // "BOOKING TIME"
    );

    /*if (timeOfDay != null) {
    // ignore: use_build_context_synchronously
    controller.text = timeOfDay.format(context);
  }*/

    if (timeOfDay != null) {
      controller.text = formatTime2(timeOfDay);
    }
  }
}

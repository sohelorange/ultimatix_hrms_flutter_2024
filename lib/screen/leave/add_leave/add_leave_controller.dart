import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/app/app_permission.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/add_leave/add_leave_type_dropdown_model.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_status/leave_status_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';

import '../../../utility/constants.dart';
import '../../../utility/network.dart';
import '../../../utility/preference_utils.dart';

class AddLeaveController extends GetxController {
  var isLoading = false.obs;
  var isSubmitLoading = false.obs;
  var isDisable = false.obs;
  Timer? debounce;

  Rx<TextEditingController> fromDateController = TextEditingController().obs;
  Rx<TextEditingController> periodController = TextEditingController().obs;
  Rx<TextEditingController> toDateController = TextEditingController().obs;
  Rx<TextEditingController> reasonController = TextEditingController().obs;

  Rx<TextEditingController> fromTimeController = TextEditingController().obs;
  Rx<TextEditingController> hourController = TextEditingController().obs;
  Rx<TextEditingController> toTimeController = TextEditingController().obs;

  FocusNode fromDtFocus = FocusNode();
  FocusNode periodFocus = FocusNode();
  FocusNode toDtFocus = FocusNode();
  FocusNode reasonFocus = FocusNode();

  FocusNode fromTimeFocus = FocusNode();
  FocusNode hourFocus = FocusNode();
  FocusNode toTimeFocus = FocusNode();

  Rx<AddLeaveTypeDropdownModel> leaveDropdownList =
      AddLeaveTypeDropdownModel().obs;
  final Rx<LeaveData?> selectedDropdownLeave = Rx<LeaveData?>(null);
  RxString selectedDropdownLeaveID = ''.obs;
  RxInt leaveTypesAttachment = 0.obs;

  late RxList<String> leaveTypesDay = <String>[].obs; // Initialize
  RxString? selectedLeaveTypesDay =
      ''.obs; // Initialize as an empty observable string

  RxString attachment = ''.obs;
  RxString docName = ''.obs;
  RxString extension = ''.obs;

  late RxList<String> leaveHalfDay = <String>[].obs; // Initialize
  RxString? selectedLeaveHalfDay = ''.obs;
  RxString? selectedAPILeaveHalfDay = ''.obs;

  bool isFractional(String text) {
    final double? value = double.tryParse(text);
    if (value == null) return false;
    return value % 1 != 0;
  }

  void parseLeaveDates(String leaveDates) {
    leaveHalfDay.clear(); // Clear previous values

    if (leaveDates.isNotEmpty) {
      // Split the dates and format them
      leaveDates.split(';').forEach((date) {
        date = date.trim();
        if (date.isNotEmpty) {
          try {
            // Normalize date string to remove extra spaces
            date = date.replaceAll(RegExp(r'\s+'), ' ');

            // Parse and format the date
            final parsedDate = DateFormat("MMM dd yyyy").parse(date);
            leaveHalfDay.add(DateFormat("dd/MM/yyyy").format(parsedDate));
          } catch (e) {
            // Handle any parsing errors
            if (kDebugMode) {
              print("Error parsing date: $date");
            }
          }
        }
      });
    }

    // Set the default selected value to the last item or '0' if the list is empty
    selectedLeaveHalfDay?.value =
        leaveHalfDay.isNotEmpty ? leaveHalfDay.last : '0';

    // Convert the selected value to ISO 8601 format (yyyy-MM-ddTHH:mm:ss)
    if (selectedLeaveHalfDay?.value != '0') {
      final selectedDate = DateFormat("dd/MM/yyyy")
          .parse(selectedLeaveHalfDay?.value ?? ''); // Parse to DateTime
      final isoDate = DateFormat("yyyy-MM-ddTHH:mm:ss").format(selectedDate);
      selectedAPILeaveHalfDay?.value = isoDate;
    } else {
      selectedAPILeaveHalfDay?.value = '';
    }
  }

  List<String> _getDropdownItems(double period) {
    if (period % 1 == 0) {
      return ['Full Day'];
    } else if (period % 1 != 0) {
      return ['First Half', 'Second Half'];
    } else {
      return ['Full Day'];
    }
  }

  String convertToISOFormat(String date) {
    DateFormat inputFormat = DateFormat("dd/MM/yyyy, EEEE");
    DateFormat outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    DateTime parsedDate = inputFormat.parse(date);
    return outputFormat.format(parsedDate);
  }

  String convertToHourFormat(String date) {
    DateFormat inputFormat = DateFormat("dd/MM/yyyy, EEEE");
    DateFormat outputFormat = DateFormat("yyyy-MM-dd");
    DateTime parsedDate = inputFormat.parse(date);
    return outputFormat.format(parsedDate);
  }

  Future<String?> filePickerFun() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String filePath = result.files.single.path!;
      docName.value = result.files.single.name;
      extension.value = ".${result.files.single.extension}";
      attachment.value = await Utils.convertFileToBase64(filePath);
    }
    return null;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    AppPermission.checkAndRequestPermissions(Get.context!);
    fetchLeaveTypeDropdown();
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  Future<void> fetchLeaveTypeDropdown() async {
    if (await Network.isConnected()) {
      try {
        //Map<String, dynamic> param = {
        //  'Key': 'value',
        //};

        var response =
            await DioClient().getQueryParam(AppURL.getLeaveRecordsURL);

        leaveDropdownList.value = AddLeaveTypeDropdownModel.fromJson(response);
        if (leaveDropdownList.value.code == 200 &&
            leaveDropdownList.value.status == true) {
          debugPrint("leave balance --$leaveDropdownList");
        } else {
          AppSnackBar.showGetXCustomSnackBar(
              message: "${leaveDropdownList.value.message}");
        }

        // if (response['code'] == 200 && response['status'] == true) {
        //   final data = response['data'];
        //   final List<dynamic> jsonData = json.decode(response.body)['data'];
        //   leaveData.value =
        //       jsonData.map((e) => AddLeaveDropdownModel.fromJson(e)).toList();
        // } else {
        //   AppSnackBar.showGetXCustomSnackBar(message: response['message']);
        // }
      } catch (e) {
        AppSnackBar.showGetXCustomSnackBar(message: e.toString());
      }
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }

  Future<void> getEmployeeLeavePeriod(
      String leaveId,
      String fromDate,
      String period,
      String toDate,
      String assignAs,
      String reason,
      String attachment,
      String docName) async {
    try {
      isLoading(true);

      // Check if network is available
      if (await Network.isConnected()) {
        Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
        String loginID = loginData['login_ID'].toString();

        Map<String, dynamic> param = {
          "leavAppID": 0,
          "leaveID": leaveId,
          "fromDate": convertToISOFormat(fromDate),
          "period": period,
          "todate": convertToISOFormat(fromDate),
          "assignAs": assignAs,
          "comment": reason,
          "hLeaveDate": convertToISOFormat(fromDate),
          "intime": convertToISOFormat(fromDate),
          "outTime": convertToISOFormat(fromDate),
          "loginID": loginID,
          "attachement": attachment,
          "docName": docName,
          "compoffLeaveDates": "",
          "strType": "V"
        };

        var response =
            await DioClient().post(AppURL.leaveApplicationURL, param);

        print(response);

        if (response['code'] == 200 && response['status'] == true) {
          final data = response['data'];
          // if (data != null && data is List && data.isNotEmpty) {
          //   final record = data[0];
          //   String toDate = record['to_date']?.toString() ?? '';
          //   String convertToDate = AppDatePicker.convertDateTimeFormat(
          //       toDate, Utils.commonUTCDateFormat, 'dd/MM/yyyy, EEEE');
          //   toDateController.value.text = convertToDate;
          //
          //   String inputText =
          //       periodController.value.text; // Get the text input
          //   leaveTypesDay.value =
          //       _getDropdownItems(double.tryParse(inputText)!);
          //   if (leaveTypesDay.length == 1) {
          //     selectedLeaveTypesDay?.value = leaveTypesDay.first;
          //   } else {
          //     selectedLeaveTypesDay?.value = leaveTypesDay.first;
          //   }
          // }

          if (data != null && data is List && data.isNotEmpty) {
            Utils.closeKeyboard(Get.context!);
            if (data[0].containsKey('From_date')) {
              // Handle first response type
              final record = data[0];
              String toDate = record['to_date']?.toString() ?? '';
              String convertToDate = AppDatePicker.convertDateTimeFormat(
                  toDate, Utils.commonUTCDateFormat, 'dd/MM/yyyy, EEEE');
              toDateController.value.text = convertToDate;

              String inputText =
                  periodController.value.text; // Get the text input
              leaveTypesDay.value =
                  _getDropdownItems(double.tryParse(inputText)!);
              if (leaveTypesDay.length == 1) {
                selectedLeaveTypesDay?.value = leaveTypesDay.first;
              }
              // else if (leaveTypesDay.length > 1) {
              //   selectedLeaveTypesDay?.value = '';
              // }
              else {
                selectedLeaveTypesDay?.value = leaveTypesDay.first;
              }

              double period =
                  double.tryParse(periodController.value.text) ?? 0.0;

              if (period % 1 == 0) {
                leaveHalfDay.clear(); // Clear previous values
                selectedLeaveHalfDay?.value = '';
                selectedAPILeaveHalfDay!.value = '';
              } else {
                String leaveDates = record['leave_dates']?.toString() ?? '';
                parseLeaveDates(leaveDates);
              }
            } else if (data[0].containsKey('Result')) {
              // Handle second response type
              final result = data[0]['Result']?.toString() ?? '';
              periodController.value.clear();
              toDateController.value.clear();
              leaveTypesDay.clear();
              selectedLeaveTypesDay!.value = '';
              leaveHalfDay.clear();
              selectedLeaveHalfDay?.value = '';
              selectedAPILeaveHalfDay!.value = '';
              if (result.contains('False')) {
                AppSnackBar.showGetXCustomSnackBar(
                    message: result.split('#')[0]);
              } else {
                AppSnackBar.showGetXCustomSnackBar(message: result);
              }
            }
          }
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: response['message']);
        }
      } else {
        AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
      }
    } catch (e) {
      AppSnackBar.showGetXCustomSnackBar(message: e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> insertLeave(
      String leaveId,
      String fromDate,
      String period,
      String toDate,
      String assignAs,
      String reason,
      String attachment,
      String docName) async {
    try {
      isSubmitLoading(true);
      isDisable(true);

      // Check if network is available
      if (await Network.isConnected()) {
        Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
        String loginID = loginData['login_ID'].toString();

        Map<String, dynamic> param = {
          "leavAppID": 0,
          "leaveID": leaveId,
          "fromDate": convertToISOFormat(fromDate),
          "period": period,
          "todate": convertToISOFormat(toDate),
          "assignAs": assignAs,
          "comment": reason,
          "hLeaveDate": convertToISOFormat(toDate),
          "intime": convertToISOFormat(fromDate),
          "outTime": convertToISOFormat(fromDate),
          "loginID": loginID,
          "attachement": attachment,
          "docName": docName,
          "compoffLeaveDates": "",
          "strType": "I"
        };

        print("Binary : $attachment");
        print("Doc name :$docName");

        var response =
            await DioClient().post(AppURL.leaveApplicationURL, param);

        if (response['code'] == 200 && response['status'] == true) {
          final data = response['data'];
          if (data != null && data is List && data.isNotEmpty) {
            Utils.closeKeyboard(Get.context!);

            if (data[0].containsKey('From_date')) {
            } else if (data[0].containsKey('Result')) {
              final result = data[0]['Result']?.toString() ?? '';
              if (result.contains('False')) {
                AppSnackBar.showGetXCustomSnackBar(
                    message: result.split('#')[0]);
              } else {
                Get.back();

                final LeaveStatusController controller =
                    Get.put(LeaveStatusController());

                controller.onLeaveBalanceAPI(
                    controller.fromAPIDt.value, controller.toAPIDt.value);

                AppSnackBar.showGetXCustomSnackBar(
                    message: result.split('#')[0],
                    backgroundColor: Colors.green);
              }
            }
          }
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: response['message']);
        }
      } else {
        AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
      }
    } catch (e) {
      AppSnackBar.showGetXCustomSnackBar(message: e.toString());
    } finally {
      isSubmitLoading(false);
      isDisable(false);
    }
  }

  void validationWithAPI() {
    if (selectedDropdownLeaveID.value.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select leave type.');
    } else if (fromDateController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select from date.');
    } else if (selectedDropdownLeaveID.value == '1481' &&
        fromTimeController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select from time.');
    } else if (selectedDropdownLeaveID.value != '1481' &&
        periodController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please enter period.');
    } else if (selectedDropdownLeaveID.value == '1481' &&
        hourController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please enter no of hours.');
    } else if (selectedDropdownLeaveID.value == '1481' &&
        toTimeController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select to time.');
    } else if (toDateController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select to date.');
    } else if (selectedDropdownLeaveID.value != '1481' &&
        selectedLeaveTypesDay!.value.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select leave type.');
    } else if (isFractional(periodController.value.text)) {
      AppSnackBar.showGetXCustomSnackBar(
          message: 'Please select half day date.');
    } else if (reasonController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please enter reason.');
    } else if (leaveTypesAttachment.value == 1 && attachment.value.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select attachment.');
    } else {
      String strValue = '';
      if (selectedDropdownLeaveID.value == '1481') {
        strValue = hourController.value.text;
      } else {
        strValue = periodController.value.text;
      }

      insertLeave(
          selectedDropdownLeaveID.value,
          fromDateController.value.text,
          //periodController.value.text,
          strValue,
          toDateController.value.text,
          selectedLeaveTypesDay!.value,
          reasonController.value.text,
          attachment.value,
          docName.value);
    }
  }
}

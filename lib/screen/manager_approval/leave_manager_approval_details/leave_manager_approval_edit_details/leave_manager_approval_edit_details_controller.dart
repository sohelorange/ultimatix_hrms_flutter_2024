import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/utility/constants.dart';
import 'package:ultimatix_hrms_flutter/utility/network.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_comment_dialog.dart';

import '../../leave_manager_approval/leave_manager_approval_controller.dart';
import '../../leave_manager_approval/leave_manager_approval_model.dart';

class LeaveManagerApprovalEditDetailsController extends GetxController {
  RxString leaveRowId = ''.obs;
  RxString leaveApplicationID = ''.obs;
  RxString leaveId = ''.obs;
  RxString leaveEmpCode = ''.obs;
  RxString leaveEmpName = ''.obs;
  RxString leaveStatus = ''.obs;
  RxString leaveAppStatus = ''.obs;
  RxString leaveName = ''.obs;
  RxString leaveType = ''.obs;
  RxString leaveFromDt = ''.obs;
  RxString leaveToDt = ''.obs;
  RxString leavePeriod = ''.obs;
  RxString leaveReason = ''.obs;
  RxString userImageUrl = "".obs;
  RxString leaveRPTLevel = "".obs;
  RxString leaveFinalApproval = "".obs;
  RxString leaveFrdRej = "".obs;
  RxString leaveEmpID = "".obs;

  var isDialogLoading = false.obs;
  var isDisable = false.obs;

  var isLoading = false.obs;
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
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final leaveData = Get.arguments['leaveEditApprovalData'] as Data;
    // Safely assign values with null checks
    leaveRowId.value = leaveData.rowID?.toString() ?? '';
    leaveApplicationID.value = leaveData.leaveApplicationID?.toString() ?? '';
    leaveId.value = leaveData.leaveID?.toString() ?? '';

    leaveEmpCode.value = leaveData.empCode ?? '';
    leaveEmpName.value = leaveData.empFullName ?? '';
    leaveName.value = leaveData.leaveName ?? '';
    leaveType.value = leaveData.leaveType ?? '';

    leaveFromDt.value = leaveData.fromDate ?? '';
    fromDateController.value.text = AppDatePicker.convertDateTimeFormat(
        leaveFromDt.value, Utils.commonUTCDateFormat, 'dd/MM/yyyy, EEEE');

    leavePeriod.value = leaveData.leavePeriod?.toString() ?? '0';
    periodController.value.text = leavePeriod.value;

    leaveToDt.value = leaveData.toDate ?? '';

    leaveReason.value = leaveData.leaveReason ?? '';
    reasonController.value.text = leaveReason.value;

    leaveStatus.value = leaveData.applicationStatus ?? '';
    leaveAppStatus.value = leaveData.leaveApplicationStatus ?? '';
    userImageUrl.value = leaveData.imagePath ?? '';
    leaveRPTLevel.value = leaveData.rptLevel?.toString() ?? '0';
    leaveFrdRej.value = leaveData.isFwdLeaveRej?.toString() ?? '0';
    leaveFinalApproval.value = leaveData.finalApprover?.toString() ?? '0';
    leaveEmpID.value = leaveData.empID?.toString() ?? '0';

    if (periodController.value.text.isNotEmpty && leaveId.value != '1481') {
      getEmployeeLeavePeriod(
          fromDateController.value.text,
          periodController.value.text,
          toDateController.value.text,
          selectedLeaveTypesDay!.value,
          reasonController.value.text,
          attachment.value,
          docName.value);
    }
  }

  void showApprovalDialog() {
    final TextEditingController commentController = TextEditingController();
    final FocusNode commentFocusNode = FocusNode();

    Get.dialog(CommonCommentDialog(
      title: 'Approval Request',
      hintText: 'Comment',
      textController: commentController,
      focusNode: commentFocusNode,
      isLoading: isDialogLoading,
      onConfirm: () async {
        final comment = commentController.text.trim();
        if (comment.isNotEmpty) {
          insertManagerApprovalLeave(comment, 'A', '');
          //Get.back();
          //Get.offAndToNamed(AppRoutes.leaveManagerApprovalRoute);
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: 'Please enter a comment');
        }
      },
      onCancel: () {
        Get.back();
      },
    ));
  }

  void showCancelDialog() {
    final TextEditingController commentController = TextEditingController();
    final FocusNode commentFocusNode = FocusNode();

    Get.dialog(CommonCommentDialog(
      title: 'Reject Request',
      hintText: 'Comment',
      textController: commentController,
      // Pass the controller to the dialog
      focusNode: commentFocusNode,
      // Pass the focus node to the dialog
      isLoading: isDialogLoading,
      onConfirm: () async {
        final comment =
            commentController.text.trim(); // Get the entered comment
        if (comment.isNotEmpty) {
          insertManagerApprovalLeave(comment, 'R', '');
          //Get.back();
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: 'Please enter a comment');
        }
      },
      onCancel: () {
        Get.back(); // Close the dialog on cancel
      },
    ));
  }

  Future<void> getEmployeeLeavePeriod(
      String fromDate,
      String period,
      String toDate,
      String assignAs,
      String reason,
      String attachment,
      String docName) async {
    try {
      isLoading(true);
      isDisable(true);

      // Check if network is available
      if (await Network.isConnected()) {
        Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
        String loginID = loginData['login_ID'].toString();

        Map<String, dynamic> param = {
          "leavAppID": leaveApplicationID.value,
          "leaveID": leaveId.value,
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
      isDisable(false);
    }
  }

  Future<void> insertManagerApprovalLeave(
      String reason, String status, String period) async {
    try {
      isDialogLoading.value = true;
      isDisable.value = true;

      // Check if network is available
      if (await Network.isConnected()) {
        Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
        String loginID = loginData['login_ID'].toString();
        String empID = loginData['emp_ID'].toString();
        String cmpID = loginData['cmp_ID'].toString();

        Map<String, dynamic> param = {
          "empID": leaveEmpID.value,
          "cmpID": cmpID,
          "leaveID": leaveId.value,
          "leaveAppID": leaveApplicationID.value,
          "fromDate": leaveFromDt.value,
          "period": period,
          "toDate": leaveToDt.value,
          "assignAs": leaveType.value,
          "comment": reason,
          "hLeaveDate": leaveFromDt.value,
          "appStatus": status,
          "appComment": "",
          "finalApproval": leaveFinalApproval.value,
          "isFWDRej": leaveFrdRej.value,
          "rptLevel": leaveRPTLevel.value,
          "sEmpID": empID,
          "intime": AppDatePicker.currentUTCFormatDate(),
          "outTime": AppDatePicker.currentUTCFormatDate(),
          "loginID": loginID,
          "attachment": "",
          "compoffLeaveDates": ""
        };

        var response =
            await DioClient().post(AppURL.managerApprovalInsertURL, param);

        if (response['code'] == 200 && response['status'] == true) {
          final data = response['data'];
          Utils.closeKeyboard(Get.context!);
          // if (data[0].containsKey('From_date')) {
          // } else
          if (data.containsKey('Result')) {
            final result = data['Result']?.toString() ?? '';
            if (result.contains('False')) {
              AppSnackBar.showGetXCustomSnackBar(message: result.split('#')[0]);
            } else {
              Get.back(); // Close the dialog
              // final LeaveManagerApprovalController controller =
              //     Get.put(LeaveManagerApprovalController());
              // controller.managerApprovalLeaveAPI().then((val){
              //   Get.until((route) =>
              //   route.settings.name ==
              //       AppRoutes
              //           .leaveManagerApprovalRoute); // Navigate back to the target route
              // });

              Get.until((route) =>
                  route.settings.name == AppRoutes.leaveManagerApprovalRoute);
              final LeaveManagerApprovalController controller =
                  Get.find<LeaveManagerApprovalController>();
              controller.managerApprovalLeaveAPI();

              AppSnackBar.showGetXCustomSnackBar(
                  message: result.split('#')[0], backgroundColor: Colors.green);
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
      isDialogLoading.value = false; // Hide loader
      isDisable.value = false;
    }
  }

  void validationWithAPI() {
    if (leaveId.value.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select leave type.');
    } else if (fromDateController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select from date.');
    } else if (leaveId.value == '1481' &&
        fromTimeController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select from time.');
    } else if (leaveId.value != '1481' && periodController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please enter period.');
    } else if (leaveId.value == '1481' && hourController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please enter no of hours.');
    } else if (leaveId.value == '1481' && toTimeController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select to time.');
    } else if (toDateController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select to date.');
    } else if (leaveId.value != '1481' &&
        selectedLeaveTypesDay!.value.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select leave type.');
    } else if (isFractional(periodController.value.text) &&
        selectedLeaveHalfDay!.value.toString().isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(
          message: 'Please select half day date.');
    } else if (reasonController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please enter reason.');
    } else if (leaveTypesAttachment.value == 1 && attachment.value.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select attachment.');
    } else {
      String strValue = '';
      if (leaveId.value == '1481') {
        strValue = hourController.value.text;
      } else {
        strValue = periodController.value.text;
      }

      insertManagerApprovalLeave(
        reasonController.value.text,
        'A',
        strValue,
      );
    }
  }
}

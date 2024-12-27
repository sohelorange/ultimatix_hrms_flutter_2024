import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/app/app_strings.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_application_details/leave_application_details_model.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_status/leave_status_controller.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_status/leave_status_model.dart';
import 'package:ultimatix_hrms_flutter/utility/constants.dart';
import 'package:ultimatix_hrms_flutter/utility/network.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_input.dart';
import 'package:ultimatix_hrms_flutter/widget/common_dropdown.dart';
import 'package:ultimatix_hrms_flutter/widget/common_input_field.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

import '../../../app/app_dimensions.dart';
import '../../../widget/common_button.dart';

class LeaveApplicationDetailsController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode userNameFocus = FocusNode();
  FocusNode passWordFocus = FocusNode();

  RxBool rememberCheck = false.obs;

  void leaveCancelDialog1(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Utils.closeKeyboard(context);
          },
          child: AlertDialog(
              surfaceTintColor: Colors.white,
              titlePadding: EdgeInsets.zero,
              actionsPadding: const EdgeInsets.only(bottom: 10),
              title: Container(
                  height: MediaQuery.of(context).size.height / 10,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    // gradient: commonGradiant(),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        padding: const EdgeInsets.only(top: 10),
                        text: 'Cancel Application',
                        fontSize: 18,
                        color: AppColors.colorBlack,
                        fontWeight: AppFontWeight.w500,
                      ).paddingOnly(left: 20, top: 20),
                      const Divider(
                        color: AppColors.colorBlack,
                      ),

                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Obx(() => SizedBox(
                      //       height: 22,
                      //       width: 22,
                      //       child: Checkbox(
                      //         checkColor: Colors.white,
                      //         activeColor: AppColors.colorPurple,
                      //         value: rememberCheck.value,
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(2),
                      //         ),
                      //         onChanged: (bool? value) {
                      //           rememberCheck.value = value!;
                      //         },
                      //       ),
                      //     ),
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {
                      //         rememberCheck.toggle();
                      //       },
                      //       child: CommonText(
                      //         padding: const EdgeInsets.only(left: 15),
                      //         text: '03/12/2024',
                      //         color: AppColors.colorBlack,
                      //         fontSize: 14,
                      //         fontWeight: AppFontWeight.w500,
                      //       ),
                      //     ),
                      //   ],
                      // ).paddingOnly(top: 10, left: 15, right: 15,),
                      // Row(
                      //   children: [
                      //     CommonText(
                      //       padding:
                      //       const EdgeInsets.only(top: 3, bottom: 12, left: 12),
                      //       text: 'Leave Type',
                      //       color: AppColors.colorBlack,
                      //       fontSize: 14,
                      //       fontWeight: AppFontWeight.medium,
                      //     ),
                      //   ],
                      // ).paddingOnly(left: 15, top: 17),
                      // CommonAppInput(
                      //   textEditingController: userNameController,
                      //   focusNode: userNameFocus,
                      //   hintText: 'Second Type',
                      //   // prifixPadding: const EdgeInsets.all(12),
                      //   hintColor: AppColors.colorBlack.withOpacity(0.3),
                      // ).paddingOnly(left: 20, right: 20),
                      // Row(
                      //   children: [
                      //     CommonText(
                      //       padding:
                      //       const EdgeInsets.only(top: 3, bottom: 12, left: 12),
                      //       text: 'Comment',
                      //       color: AppColors.colorBlack,
                      //       fontSize: 14,
                      //       fontWeight: AppFontWeight.medium,
                      //     ),
                      //   ],
                      // ).paddingOnly(left: 15, top: 10),
                      // CommonAppInput(
                      //   textEditingController: passwordController,
                      //   focusNode: passWordFocus,
                      //   hintText: 'Type Here....',
                      //   prifixPadding: const EdgeInsets.all(12),
                      //   hintColor: AppColors.colorBlack.withOpacity(0.3),
                      //   isPassword: true,
                      // ).paddingOnly(left: 20, right: 20),
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width,
                      //   height: MediaQuery.of(context).size.width / 8,
                      //   child: ElevatedButton(
                      //     style: ButtonStyle(
                      //         backgroundColor: WidgetStateColor.resolveWith(
                      //               (states) => AppColors.colorPurple,
                      //         ),
                      //         shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      //             RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(10.0),
                      //             ))),
                      //     onPressed: () {
                      //       Get.back();
                      //     },
                      //     child: CommonText(
                      //       text: AppString.submit,
                      //       color: AppColors.colorWhite,
                      //       fontSize: 16,
                      //       fontWeight: AppFontWeight.w400,
                      //     ),
                      //   ),
                      // ).paddingOnly(left: 30, right: 30, top: 20),
                    ],
                  )),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () => SizedBox(
                          height: 22,
                          width: 22,
                          child: Checkbox(
                            checkColor: Colors.white,
                            activeColor: AppColors.colorPurple,
                            value: rememberCheck.value,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            onChanged: (bool? value) {
                              rememberCheck.value = value!;
                            },
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          rememberCheck.toggle();
                        },
                        child: CommonText(
                          padding: const EdgeInsets.only(left: 15),
                          text: '03/12/2024',
                          color: AppColors.colorBlack,
                          fontSize: 14,
                          fontWeight: AppFontWeight.w500,
                        ),
                      ),
                    ],
                  ).paddingOnly(top: 10, left: 15, right: 15),
                  Row(
                    children: [
                      CommonText(
                        padding:
                            const EdgeInsets.only(top: 3, bottom: 12, left: 12),
                        text: 'Leave Type',
                        color: AppColors.colorBlack,
                        fontSize: 16,
                        fontWeight: AppFontWeight.w400,
                      ),
                    ],
                  ).paddingOnly(left: 15, top: 17),
                  CommonAppInput(
                    textEditingController: userNameController,
                    focusNode: userNameFocus,
                    hintText: 'Second Type',
                    // prifixPadding: const EdgeInsets.all(12),
                    hintColor: AppColors.colorBlack.withOpacity(0.3),
                  ).paddingOnly(left: 20, right: 20),
                  Row(
                    children: [
                      CommonText(
                        padding:
                            const EdgeInsets.only(top: 3, bottom: 12, left: 12),
                        text: 'Comment',
                        color: AppColors.colorBlack,
                        fontSize: 16,
                        fontWeight: AppFontWeight.w400,
                      ),
                    ],
                  ).paddingOnly(left: 15, top: 10),
                  CommonAppInput(
                    textEditingController: passwordController,
                    focusNode: passWordFocus,
                    hintText: 'Type Here....',
                    prifixPadding: const EdgeInsets.all(12),
                    hintColor: AppColors.colorBlack.withOpacity(0.3),
                    isPassword: true,
                  ).paddingOnly(left: 20, right: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 8,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateColor.resolveWith(
                            (states) => AppColors.colorPurple,
                          ),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                      onPressed: () {
                        Get.back();
                      },
                      child: CommonText(
                        text: AppString.submit,
                        color: AppColors.colorWhite,
                        fontSize: 16,
                        fontWeight: AppFontWeight.w400,
                      ),
                    ),
                  ).paddingOnly(left: 30, right: 30, top: 20),
                ],
              )),
        );
      },
    );
  }

  void leaveCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Utils.closeKeyboard(context);
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Rounded corners
            ),
            //titlePadding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
            //contentPadding: const EdgeInsets.fromLTRB(30, 0, 30, 16),

            // Title with Divider
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  textAlign: TextAlign.start,
                  text: 'Cancel Application',
                  color: AppColors.colorDarkBlue,
                  fontSize: AppDimensions.fontSizeLarge,
                  fontWeight: AppFontWeight.w500,
                ),
                const SizedBox(height: 8),
                Divider(
                    color: AppColors.colorDarkGray.withOpacity(0.2),
                    thickness: 1),
              ],
            ),

            // Message + Actions in a Column
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => CheckboxListTile(
                    value: rememberCheck.value,
                    // Bind to reactive variable
                    onChanged: (bool? newValue) {
                      if (newValue != null) {
                        rememberCheck.value = newValue;
                      }
                    },
                    title: CommonText(
                      text: '03/12/2024',
                      color: AppColors.colorDarkBlue,
                      fontSize: 14,
                      fontWeight: AppFontWeight.w400,
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: AppColors.purpleSwatch,
                    contentPadding: EdgeInsets.zero,
                    visualDensity:
                        const VisualDensity(horizontal: -4.0, vertical: -4.0),
                    tileColor: Colors.transparent,
                    // Set background to transparent
                    selectedTileColor:
                        Colors.transparent, // Remove tint when tapped
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonDropdown(
                  items: const ['Full Day', 'Half Day', 'Quarter Day'],
                  //initialValue: 'Half Day',
                  hint: 'Leave Type',
                  onChanged: (String value) {
                    if (kDebugMode) {
                      print("Selected: $value");
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CommonInputField(
                  textInputAction: TextInputAction.done,
                  textEditingController: userNameController,
                  hintText: "Comment",
                  focusNode: userNameFocus,
                  labelStyle: const TextStyle(
                    color: AppColors.colorDarkBlue,
                  ),
                  hintStyle: const TextStyle(
                    color: AppColors.colorDarkBlue,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CommonButton(
                    buttonText: 'Submit',
                    onPressed: () {
                      Get.back();
                    },
                    isLoading: false),
              ],
            ),
          ),
        );
      },
    );
  }

  RxString leaveApprovalId = ''.obs;
  RxString leaveAppId = ''.obs;
  RxString leaveId = ''.obs;
  RxString leaveStatus = ''.obs;
  RxString leaveAppStatus = ''.obs;
  RxString leaveType = ''.obs;
  RxString leaveFromDt = ''.obs;
  RxString leaveToDt = ''.obs;
  RxString leavePeriod = ''.obs;
  RxString leaveReason = ''.obs;

  var isDeleteLoading = false.obs;
  var isDisable = false.obs;

  late RxList<String> leaveTypesDay = <String>[].obs; // Initialize
  RxString? selectedLeaveTypesDay =
      ''.obs; // Initialize as an empty observable string
  Rx<TextEditingController> reasonController = TextEditingController().obs;
  FocusNode reasonFocus = FocusNode();

  Rx<LeaveApplicationDetailsResponse> leaveDetailsListResponse =
      LeaveApplicationDetailsResponse().obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final leaveData = Get.arguments['leaveData'] as Data;
    leaveApprovalId.value = leaveData.leaveApprovalId.toString();
    leaveAppId.value = leaveData.leaveApplicationId.toString();
    leaveId.value = leaveData.leaveId.toString();
    leaveStatus.value = leaveData.appStatus!;
    leaveAppStatus.value = leaveData.applicationStatus!;
    leaveType.value = leaveData.leaveCode!;
    leaveFromDt.value = leaveData.fromDate!;
    leaveToDt.value = leaveData.toDate!;
    leavePeriod.value = leaveData.leaveAppDays.toString();
    leaveReason.value = leaveData.leaveReason!;

    if (int.parse(leaveApprovalId.value) != 0) {
      getCancelLeaveDetailsAPI(int.parse(leaveId.value),
          int.parse(leaveAppId.value), int.parse(leaveApprovalId.value));
    }
  }

  String convertToISOFormat(String date) {
    DateFormat inputFormat = DateFormat("dd/MM/yyyy, EEEE");
    DateFormat outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    DateTime parsedDate = inputFormat.parse(date);
    return outputFormat.format(parsedDate);
  }

  Future<void> insertDeleteLeave(
      String leaveAppId,
      String leaveId,
      String fromDate,
      String period,
      String toDate,
      String assignAs,
      String reason,
      String attachment,
      String docName) async {
    try {
      isDeleteLoading(true);
      isDisable(true);

      // Check if network is available
      if (await Network.isConnected()) {
        Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
        String loginID = loginData['login_ID'].toString();

        Map<String, dynamic> param = {
          "leavAppID": leaveAppId,
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
          "strType": "D"
        };

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
      isDeleteLoading(false);
      isDisable(false);
    }
  }

  void deleteWithAPI() {
    String formattedDate =
        DateFormat('dd/MM/yyyy, EEEE').format(DateTime.now());

    insertDeleteLeave(leaveAppId.value, leaveId.value, formattedDate,
        leavePeriod.value, formattedDate, '', '', '', '');
  }

  Future<void> getCancelLeaveDetailsAPI(
      int leaveID, int leaveAppID, int leaveApprID) async {
    if (await Network.isConnected()) {
      try {
        isLoading.value = true;

        Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
        String empID = loginData['emp_ID'].toString();
        String cmpID = loginData['cmp_ID'].toString();
        String loginID = loginData['login_ID'].toString();

        Map<String, dynamic> requestParam = {
          "cmpId": cmpID,
          "leaveId": leaveID,
          "loginId": loginID,
          "leaveAppId": leaveAppID,
          "leaveApprId": leaveApprID,
          "empId": empID
        };

        var response =
            await DioClient().post(AppURL.getCancelLeaveURL, requestParam);

        leaveDetailsListResponse.value =
            LeaveApplicationDetailsResponse.fromJson(response);
        if (leaveDetailsListResponse.value.code == 200 &&
            leaveDetailsListResponse.value.status == true) {
          debugPrint("leave details response --$leaveDetailsListResponse");
        } else {
          AppSnackBar.showGetXCustomSnackBar(
              message: "${leaveDetailsListResponse.value.message}");
        }
      } catch (e) {
        AppSnackBar.showGetXCustomSnackBar(message: e.toString());
      } finally {
        isLoading.value = false;
      }
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }
}

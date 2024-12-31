import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_balance/leave_balance_model.dart';
import 'package:ultimatix_hrms_flutter/utility/constants.dart';
import 'package:ultimatix_hrms_flutter/utility/network.dart';
import 'package:ultimatix_hrms_flutter/widget/common_button.dart';
import 'package:ultimatix_hrms_flutter/widget/common_year_month_grid_view.dart';

import '../../../utility/preference_utils.dart';

class LeaveBalanceController extends GetxController {
  final RxInt selectedYearIndex = RxInt(-1); // Default to -1 (no selection yet)
  final RxInt selectedMonthIndex =
      RxInt(-1); // Default to -1 (no selection yet)

  RxBool isLoading = true.obs;

  final List<Color> colors = [
    AppColors.colorF9FCFA,
    AppColors.colorFEF9F9,
    AppColors.colorFEFCF7,
    AppColors.colorF8FCFE,
    AppColors.colorFCFBFE
  ];

  Rx<LeaveBalanceModel> leaveBalListResponse = LeaveBalanceModel().obs;

  @override
  void onInit() {
    super.onInit();
    DateTime now = DateTime.now();
    RxInt currentYear = now.year.obs;
    RxInt currentMonth = now.month.obs;
    onLeaveBalanceAPI(currentYear.value, currentMonth.value);
  }

  Future<void> onLeaveBalanceAPI(int year, int month) async {
    if (await Network.isConnected()) {
      try {
        isLoading.value = true;

        Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
        String empID = loginData['emp_ID'].toString();
        String cmpID = loginData['cmp_ID'].toString();

        Map<String, dynamic> requestParam = {
          "month": month,
          "year": year,
          "empId": empID,
          "cmpId": cmpID
        };

        var response =
            await DioClient().post(AppURL.getLeaveBalanceURL, requestParam);

        leaveBalListResponse.value = LeaveBalanceModel.fromJson(response);
        if (leaveBalListResponse.value.code == 200 &&
            leaveBalListResponse.value.status == true) {
          debugPrint("leave balance --$leaveBalListResponse");
        } else {
          AppSnackBar.showGetXCustomSnackBar(
              message: "${leaveBalListResponse.value.message}");
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

  void showYearDialog(BuildContext context) {
    final int currentYear = DateTime.now().year;

    // Generate a list of years dynamically
    final List<Map<String, dynamic>> yearItems = List.generate(
      20,
      (index) => {'name': (currentYear + index).toString()},
    );

    // Set default to current year if no selection has been made yet
    if (selectedYearIndex.value == -1) {
      selectedYearIndex.value = 0; // Default to the current year
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Year'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height *
                0.3, // 30% of screen height
            width: MediaQuery.of(context).size.width * 0.8,
            child: LayoutBuilder(
              builder: (context, constraints) {
                // int crossAxisCount;
                // if (constraints.maxWidth < 400) {
                //   crossAxisCount = 2; // For smaller screens
                // } else if (constraints.maxWidth < 800) {
                //   crossAxisCount = 3; // For medium screens
                // } else {
                //   crossAxisCount = 4; // For larger screens
                // }

                return CommonYearMonthGridView(
                  gridItems: yearItems,
                  selectedIndex: selectedYearIndex,
                  onItemTap: (index) {
                    selectedYearIndex.value = index;

                    Get.back(); // Close the year dialog
                    final selectedYear = currentYear + selectedYearIndex.value;
                    showMonthDialog(context, selectedYear);
                  },
                );
              },
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    buttonText: 'Next',
                    onPressed: () {
                      if (selectedYearIndex.value >= 0) {
                        Get.back();
                        final selectedYear =
                            currentYear + selectedYearIndex.value;
                        showMonthDialog(context, selectedYear);
                      }
                    },
                    isLoading: false,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CommonButton(
                    buttonText: 'Close',
                    onPressed: () {
                      Get.back();
                    },
                    isLoading: false,
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  void showMonthDialog(BuildContext context, int selectedYear) {
    // Define months
    final List<Map<String, dynamic>> monthItems = [
      {'name': 'January'},
      {'name': 'February'},
      {'name': 'March'},
      {'name': 'April'},
      {'name': 'May'},
      {'name': 'June'},
      {'name': 'July'},
      {'name': 'August'},
      {'name': 'September'},
      {'name': 'October'},
      {'name': 'November'},
      {'name': 'December'},
    ];

    // Set default to current month if no selection has been made yet
    if (selectedMonthIndex.value == -1) {
      selectedMonthIndex.value =
          DateTime.now().month - 1; // Default to current month
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Month for $selectedYear'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height *
                0.3, // 30% of screen height
            width: MediaQuery.of(context).size.width * 0.8,
            child: LayoutBuilder(
              builder: (context, constraints) {
                // int crossAxisCount;
                // if (constraints.maxWidth < 400) {
                //   crossAxisCount = 2; // For smaller screens
                // } else if (constraints.maxWidth < 800) {
                //   crossAxisCount = 3; // For medium screens
                // } else {
                //   crossAxisCount = 4; // For larger screens
                // }

                return CommonYearMonthGridView(
                  gridItems: monthItems,
                  selectedIndex: selectedMonthIndex,
                  onItemTap: (index) {
                    selectedMonthIndex.value = index;

                    Get.back(); // Close the month dialog
                    onLeaveBalanceAPI(
                      selectedYear,
                      selectedMonthIndex.value +
                          1, // Convert index to 1-based month
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    buttonText: 'Submit',
                    onPressed: () {
                      if (selectedMonthIndex.value >= 0) {
                        Get.back(); // Close the month dialog
                        onLeaveBalanceAPI(
                          selectedYear,
                          selectedMonthIndex.value +
                              1, // Convert index to 1-based month
                        );
                      }
                    },
                    isLoading: false,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CommonButton(
                    buttonText: 'Close',
                    onPressed: () {
                      Get.back();
                    },
                    isLoading: false,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

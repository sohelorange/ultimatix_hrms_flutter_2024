import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';

import '../../../api/dio_client.dart';
import '../../../app/app_snack_bar.dart';
import '../../../app/app_url.dart';
import '../../../utility/constants.dart';
import '../../../utility/network.dart';

class FeedbackController extends GetxController {
  var isLoading = false.obs;
  var isDisable = false.obs;

  final Color unselectedColor = AppColors.colorDarkGray;
  RxInt selectedFeedbackOpinionIndex = (-1).obs;
  RxString selectedFeedbackOpinion = ''.obs;
  final List<Map<String, dynamic>> feedbackOptions = [
    {
      "label": "Terrible",
      "icon": AppImages.dashHolidayIcon,
      //"icon": AppImages.feedbackTerribleIcon,
      "color": Colors.orange,
    },
    {
      "label": "Bad",
      "icon": AppImages.dashHolidayIcon,
      //"icon": AppImages.feedbackBadIcon,
      "color": Colors.yellow,
    },
    {
      "label": "Okay",
      "icon": AppImages.dashHolidayIcon,
      //"icon": AppImages.feedbackOkayIcon,
      "color": Colors.green,
    },
    {
      "label": "Good",
      "icon": AppImages.dashHolidayIcon,
      //"icon": AppImages.feedbackGoodIcon,
      "color": Colors.blue,
    },
    {
      "label": "Great",
      "icon": AppImages.dashHolidayIcon,
      //"icon": AppImages.feedbackGreatIcon,
      "color": Colors.purple,
    },
  ];

  RxInt selectedCategoryIndex = (-1).obs;
  RxString selectedCategory = ''.obs;
  List<Map<String, dynamic>> categoryItems = [
    {
      'name': 'Suggestion',
    },
    {
      'name': 'Something is not quite right',
    },
    {
      'name': 'Compliment',
    },
  ];

  Rx<TextEditingController> feedbackController = TextEditingController().obs;
  FocusNode feedbackFocus = FocusNode();

  void feedbackWithAPI() {
    if (selectedFeedbackOpinion.value.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select opinion.');
    } else if (selectedCategory.value.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select category.');
    } else if (feedbackController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(
          message: 'Please enter valuable feedback.');
    } else {
      feedbackAPICall(feedbackController.value.text, '', '');
    }
  }

  Future<void> feedbackAPICall(
      String currentPass, String changePass, String confirmPass) async {
    try {
      isLoading(true);
      isDisable(true);

      // Check if network is available
      if (await Network.isConnected()) {
        Map<String, dynamic> param = {
          "ticketAppID": 0,
          "cmpID": 0,
          "empID": 0,
          "loginID": 0,
          "rating": 0,
          "suggestion": "string"
        };

        var response = await DioClient().post(AppURL.feedbackURL, param);
        if (response['code'] == 200 && response['status'] == true) {
          Utils.closeKeyboard(Get.context!);
          Get.back();
          AppSnackBar.showGetXCustomSnackBar(
              message: response['message'], backgroundColor: Colors.green);
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
}

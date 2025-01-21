import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/screen/profile/profile_family_model.dart';
import 'package:ultimatix_hrms_flutter/screen/profile/profile_favorite_model.dart';
import 'package:ultimatix_hrms_flutter/screen/profile/profile_personal_model.dart';
import 'package:ultimatix_hrms_flutter/utility/constants.dart';
import 'package:ultimatix_hrms_flutter/utility/network.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';

class ProfileController extends GetxController {
  RxBool isLoading = true.obs;
  RxString userImageUrl = "".obs;
  RxString profileImage = "".obs;

  // var profileImage = Rx<File?>(null);
  var base64String = ''.obs;

  final ImagePicker _picker = ImagePicker();

  Rx<ProfilePersonalModel> profilePersonalModelResponse =
      ProfilePersonalModel().obs;
  Rx<ProfileFavoriteModel> profileFavoriteModelResponse =
      ProfileFavoriteModel().obs;
  Rx<ProfileFamilyModel> profileFamilyModelResponse = ProfileFamilyModel().obs;

  RxString favSport = ''.obs;

  String maskNumber(String number) {
    // Check if the account number has enough digits
    if (number.length > 4) {
      // Mask all but the last 4 digits
      return 'X' * (number.length - 4) + number.substring(number.length - 4);
    } else {
      // If the account number is less than or equal to 4 digits, return it as is
      return number;
    }
  }

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
    userImageUrl.value = loginData['image_Name'] ?? '';

    fetchDataInParallel();
  }

  Future<void> fetchDataInParallel() async {
    if (await Network.isConnected()) {
      try {
        isLoading(true);

        await Future.wait([
          onEmployeePersonalDetailsAPI(),
          onEmployeeFavouriteDetailsAPI(),
          onEmployeeFamilyDetailsAPI(),
        ]).then((_) {
          isLoading(false);
        });
      } catch (e) {
        AppSnackBar.showGetXCustomSnackBar(message: e.toString());
      } finally {
        isLoading(false);
      }
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }

  Future<void> onEmployeePersonalDetailsAPI() async {
    try {
      var response =
          await DioClient().getQueryParam(AppURL.getEmployeeDetailsURL);
      profilePersonalModelResponse.value =
          ProfilePersonalModel.fromJson(response);

      if (profilePersonalModelResponse.value.code == 200 &&
          profilePersonalModelResponse.value.status == true) {
      } else {
        AppSnackBar.showGetXCustomSnackBar(
            message: "${profilePersonalModelResponse.value.message}");
      }
    } catch (e) {
      AppSnackBar.showGetXCustomSnackBar(message: e.toString());
    }
  }

  Future<void> onEmployeeFavouriteDetailsAPI() async {
    try {
      var response =
          await DioClient().getQueryParam(AppURL.getEmployeeFavDetailsURL);
      profileFavoriteModelResponse.value =
          ProfileFavoriteModel.fromJson(response);

      if (profileFavoriteModelResponse.value.code == 200 &&
          profileFavoriteModelResponse.value.status == true) {
      } else {
        AppSnackBar.showGetXCustomSnackBar(
            message: "${profileFavoriteModelResponse.value.message}");
      }
    } catch (e) {
      AppSnackBar.showGetXCustomSnackBar(message: e.toString());
    }
  }

  Future<void> onEmployeeFamilyDetailsAPI() async {
    try {
      var response =
          await DioClient().getQueryParam(AppURL.getEmployeeFamilyDetailsURL);
      profileFamilyModelResponse.value = ProfileFamilyModel.fromJson(response);

      if (profileFamilyModelResponse.value.code == 200 &&
          profileFamilyModelResponse.value.status == true) {
      } else {
        AppSnackBar.showGetXCustomSnackBar(
            message: "${profileFamilyModelResponse.value.message}");
      }
    } catch (e) {
      AppSnackBar.showGetXCustomSnackBar(message: e.toString());
    }
  }

  getOpenGalleryView(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                iconColor: AppColors.color7B1FA2,
                onTap: () {
                  Get.back();
                  pickImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Gallery'),
                iconColor: AppColors.color7B1FA2,
                onTap: () {
                  Get.back();
                  // pickgalleryImage();
                },
              )
            ],
          );
        });
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      profileImage.value = pickedFile.path;
      convertToBase64(profileImage.value as File);
    }

    await onUpdateEmployeeDetailsAPI();
  }

  /* if (pickedFile != null) {
      userImageUrl.value = pickedFile.path;
      // userImageUrl.value = profileImagePath.value;
      print("imagefinal---${userImageUrl.value}");
      // await saveImageLocally(File(pickedFile.path));
      await onUpdateEmployeeDetailsAPI();
    } else {
      Get.snackbar('Error', 'No image selected',
          snackPosition: SnackPosition.BOTTOM);
    }*/

  // Convert the image to Base64 string
  void convertToBase64(File imageFile) {
    final bytes = imageFile.readAsBytesSync();
    base64String.value = base64Encode(bytes);
    debugPrint("Base64 String: ${base64String.value}");
    onUpdateEmployeeDetailsAPI();
  }

  /* Future<void> pickgalleryImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImagePath.value = pickedFile.path;
      userImageUrl.value = profileImagePath.value;
      print("image---${profileImagePath.value}");
      print("imagefinal---${userImageUrl.value}");

      onUpdateEmployeeDetailsAPI();

    } else {
      Get.snackbar('Error', 'No image selected',
          snackPosition: SnackPosition.BOTTOM);
    }
  }*/

  Future<void> onUpdateEmployeeDetailsAPI() async {
    if (await Network.isConnected()) {
      try {
        isLoading.value = true;

        Map<String, dynamic> requestParam = {
          "empID": 0,
          "cmpID": 0,
          "address": "",
          "city": "",
          "state": "",
          "pincode": "",
          "phoneNo": "",
          "mobileNo": "",
          "email": "",
          "strType": base64String.value,
          "type": "U"
        };

        var response = await DioClient()
            .post(AppURL.updateEmployeeDetailsURL, requestParam);
        debugPrint("res --$response");
      } catch (e) {
        debugPrint("Login catch --$e");
      } finally {
        isLoading.value = false;
      }
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }

  Future<void> deleteFamilyInformation(
    String rowId,
  ) async {
    try {
      if (await Network.isConnected()) {
        Map<String, dynamic> param = {
          "RowId": rowId,
        };

        var response = await DioClient().getQueryParam(
            AppURL.deleteFamilyInformationDetailsURL,
            queryParams: param);

        if (response['code'] == 200 && response['status'] == true) {
          final data = response['data'];
          if (data != null) {
            Utils.closeKeyboard(Get.context!);

            onEmployeeFamilyDetailsAPI();

            AppSnackBar.showGetXCustomSnackBar(
                message: response['data'].split('#')[0],
                backgroundColor: AppColors.colorGreen);
          }
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: response['message']);
        }
      } else {
        AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
      }
    } catch (e) {
      AppSnackBar.showGetXCustomSnackBar(message: e.toString());
    }
  }
}

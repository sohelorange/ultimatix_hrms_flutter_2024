import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/screen/profile/profile_family_model.dart';
import 'package:ultimatix_hrms_flutter/screen/profile/profile_favorite_model.dart';
import 'package:ultimatix_hrms_flutter/screen/profile/profile_personal_model.dart';
import 'package:ultimatix_hrms_flutter/utility/constants.dart';
import 'package:ultimatix_hrms_flutter/utility/network.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

class ProfileController extends GetxController {
  RxBool isLoading = true.obs;

  RxString userImageUrl = "".obs;
  RxString base64String = ''.obs;
  final ImagePicker _picker = ImagePicker();

  Rx<ProfilePersonalModel> profilePersonalModelResponse =
      ProfilePersonalModel().obs;
  Rx<ProfileFavoriteModel> profileFavoriteModelResponse =
      ProfileFavoriteModel().obs;
  Rx<ProfileFamilyModel> profileFamilyModelResponse = ProfileFamilyModel().obs;

  String maskNumber(String number) {
    if (number.length > 4) {
      return 'X' * (number.length - 4) + number.substring(number.length - 4);
    } else {
      return number;
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
    // userImageUrl.value = loginData['image_Name'] ?? '';

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
        userImageUrl.value = profilePersonalModelResponse
            .value.data!.employeeDetails!.imagePath!;
        PreferenceUtils.setProfileImage(userImageUrl.value);
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(Icons.camera),
              title: CommonText(
                textAlign: TextAlign.start,
                text: 'Camera',
                color: AppColors.colorDarkBlue,
                fontSize: 14,
                fontWeight: AppFontWeight.w700,
              ),
              visualDensity:
                  const VisualDensity(horizontal: -4.0, vertical: -4.0),
              iconColor: AppColors.colorDarkBlue,
              onTap: () {
                Get.back();
                pickImage(ImageSource.camera);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: CommonText(
                textAlign: TextAlign.start,
                text: 'Gallery',
                color: AppColors.colorDarkBlue,
                fontSize: 14,
                fontWeight: AppFontWeight.w700,
              ),
              visualDensity:
                  const VisualDensity(horizontal: -4.0, vertical: -4.0),
              iconColor: AppColors.colorDarkBlue,
              onTap: () {
                Get.back();
                pickImage(ImageSource.gallery);
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      File selectedImage = File(pickedFile.path);

      // Update reactive variables with the selected image path
      userImageUrl.value = pickedFile.path;

      // Convert the image to Base64 and call the API
      base64String.value = await Utils.convertFileToBase64(selectedImage.path)
          .then((base64StringValue) {
        imageUpdateAPI();
        return base64StringValue;
      });
    } else {
      // Handle the case where no image is selected
      if (kDebugMode) {
        print(
            "No image selected from ${source == ImageSource.camera ? 'camera' : 'gallery'}.");
      }
    }
  }

  Future<void> pickCameraImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File selectedImage = File(pickedFile.path);
      userImageUrl.value = pickedFile.path;
      base64String.value = await Utils.convertFileToBase64(selectedImage.path)
          .then((base64StringValue) {
        imageUpdateAPI();
        return base64StringValue;
      });
    }

    // if (pickedFile != null) {
    //   File selectedImage = File(pickedFile.path);
    //   Utils.convertFileToBase64(selectedImage.path).then((base64StringValue) {
    //     base64String.value = base64StringValue;
    //     onUpdateEmployeeDetailsAPI();
    //   });
    // }
  }

  Future<void> pickGalleryImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File selectedImage = File(pickedFile.path);
      userImageUrl.value = pickedFile.path;
      base64String.value = await Utils.convertFileToBase64(selectedImage.path)
          .then((base64StringValue) {
        imageUpdateAPI();
        return base64StringValue;
      });

      // if (pickedFile != null) {
      //   profileImage.value = pickedFile.path;
      //   userImageUrl.value = profileImage.value;
      //   print("image---${profileImage.value}");
      //   print("imagefinal---${userImageUrl.value}");
      //
      //   onUpdateEmployeeDetailsAPI();
      // }
    }
  }

  Future<void> imageUpdateAPI() async {
    if (await Network.isConnected()) {
      try {
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
          "strImage": base64String.value,
          "type": "U"
        };

        var response = await DioClient()
            .post(AppURL.updateEmployeeDetailsURL, requestParam);
        if (response['code'] == 200 && response['status'] == true) {
          onEmployeePersonalDetailsAPI();
          debugPrint("res --$response");
        } else {
          AppSnackBar.showGetXCustomSnackBar(message: response['message']);
        }
      } catch (e) {
        AppSnackBar.showGetXCustomSnackBar(message: e.toString());
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

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/screen/profile/profile_model.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';

class ProfileController extends GetxController {
  RxBool isLoading = true.obs;
  var profileImagePath = ''.obs;
  RxString userImageUrl = "".obs;

  Rx<ProfileModel> profilemodelResponse = ProfileModel().obs;

  @override
  void onInit() {
    super.onInit();

    onEmployeeDetailsAPI();
    Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
    userImageUrl.value = loginData['image_Name'] ?? '';

  }

  Future<void> onEmployeeDetailsAPI() async {
    try {
      isLoading.value = true;

      var response = await DioClient().getQueryParam(AppURL.employeedetails);
      debugPrint("res --$response");

      profilemodelResponse.value = ProfileModel.fromJson(response);

      debugPrint(" profile --$profilemodelResponse");

      if(profilemodelResponse.value.code == 200 && profilemodelResponse.value.status == true) {

        debugPrint("leave balance --$profilemodelResponse");

      } else{
        AppSnackBar.showGetXCustomSnackBar(message: "${profilemodelResponse.value.message}" );
      }
    } catch (e) {
      debugPrint("Login catch --$e");
    } finally {
      isLoading.value = false;
    }
  }

  getGallaryview(BuildContext context) {
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
                title: const Text('Gallary'),
                iconColor: AppColors.color7B1FA2,
                onTap: () {
                  Get.back();
                  pickgalleryImage();
                },
              )
            ],
          );
        });
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      profileImagePath.value = pickedFile.path;
      userImageUrl.value = profileImagePath.value;
      print("image---${profileImagePath.value}");
      print("imagefinal---${userImageUrl.value}");
      // await saveImageLocally(File(pickedFile.path));
    } else {
      Get.snackbar('Error', 'No image selected',
          snackPosition: SnackPosition.BOTTOM);
    }

  }

  Future<void> pickgalleryImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImagePath.value = pickedFile.path;
      userImageUrl.value = profileImagePath.value;
      print("image---${profileImagePath.value}");
      print("imagefinal---${userImageUrl.value}");

    } else {
      Get.snackbar('Error', 'No image selected',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> onUpdateEmployeeDetailsAPI() async {
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
        "strType": userImageUrl.value
      };

      var response = await DioClient().post(AppURL.updateemployeedetails,requestParam);
      debugPrint("res --$response");

      profilemodelResponse.value = ProfileModel.fromJson(response);

      debugPrint(" profile --$profilemodelResponse");

      if(profilemodelResponse.value.code == 200 && profilemodelResponse.value.status == true) {

        debugPrint("profileeee --$profilemodelResponse");

      } else{
        AppSnackBar.showGetXCustomSnackBar(message: "${profilemodelResponse.value.message}" );
      }
    } catch (e) {
      debugPrint("Login catch --$e");
    } finally {
      isLoading.value = false;
    }
  }

/*  Future<void> saveImageLocally(File image) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final localImagePath = '${appDir.path}/profile_picture.png';
      await image.copy(localImagePath);
      profileImagePath.value = localImagePath;
      Get.snackbar('Success', 'Image saved locally');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save image locally');
    }
  }

  // Load saved image from local storage
  Future<void> loadSavedImage() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final localImagePath = '${appDir.path}/profile_picture.png';
      if (await File(localImagePath).exists()) {
        profileImagePath.value = localImagePath;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load saved image');
    }
  }*/

}
import 'dart:convert';
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
import 'package:ultimatix_hrms_flutter/utility/utils.dart';

class ProfileController extends GetxController {
  RxBool isLoading = true.obs;
  RxString userImageUrl = "".obs;
  RxString profileImage = "".obs;

  // var profileImage = Rx<File?>(null);
  var base64String = ''.obs;


  final ImagePicker _picker = ImagePicker();

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
      if (pickedFile != null) {
        profileImage.value = pickedFile.path;
        convertToBase64(profileImage.value as File);
      } else {
        Get.snackbar("Error", "No image selected");
      }
    }

    print("imagefinal---${profileImage.value}");

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

      var response = await DioClient().post(AppURL.updateemployeedetails,requestParam);
      debugPrint("res --$response");

    } catch (e) {
      debugPrint("Login catch --$e");
    } finally {
      isLoading.value = false;
    }
  }



}

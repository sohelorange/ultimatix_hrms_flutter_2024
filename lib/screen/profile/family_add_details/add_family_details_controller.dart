import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/model/hobby_model.dart';
import 'package:ultimatix_hrms_flutter/model/occupation_model.dart';
import 'package:ultimatix_hrms_flutter/model/relationship_model.dart';
import 'package:ultimatix_hrms_flutter/model/standard_model.dart';
import 'package:ultimatix_hrms_flutter/screen/profile/profile_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/constants.dart';
import 'package:ultimatix_hrms_flutter/utility/network.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';

class AddFamilyDetailsController extends GetxController {
  Rx<TextEditingController> familyMembersNameController =
      TextEditingController().obs;
  Rx<TextEditingController> dobController = TextEditingController().obs;
  Rx<TextEditingController> companyNameController = TextEditingController().obs;
  Rx<TextEditingController> companyCityController = TextEditingController().obs;
  Rx<TextEditingController> clgNameController = TextEditingController().obs;
  Rx<TextEditingController> clgCityController = TextEditingController().obs;
  Rx<TextEditingController> extraActivityController =
      TextEditingController().obs;
  Rx<TextEditingController> otherHobbyController = TextEditingController().obs;
  Rx<TextEditingController> panCardController = TextEditingController().obs;
  Rx<TextEditingController> aadharCardController = TextEditingController().obs;
  Rx<TextEditingController> heightController = TextEditingController().obs;
  Rx<TextEditingController> weightController = TextEditingController().obs;

  RxBool isHobbyCheck = false.obs;
  RxBool isResidingCheck = false.obs;
  RxInt isResidingValue = 0.obs;
  RxBool isDependentCheck = false.obs;
  RxInt isDependentValue = 0.obs;
  RxBool isSubmitLoading = false.obs;
  RxBool isDisable = false.obs;

  String maskNumber(String number) {
    if (number.length > 4) {
      return 'X' * (number.length - 4) + number.substring(number.length - 4);
    } else {
      return number;
    }
  }

  var isLoading = false.obs;

  Rx<RelationshipResponse> relationShipResponse = RelationshipResponse().obs;
  RxList<RelationshipModel> relationshipList = <RelationshipModel>[].obs;
  Rx<OccupationResponse> occupationResponse = OccupationResponse().obs;
  RxList<OccupationModel> occupationList = <OccupationModel>[].obs;
  Rx<StandardResponse> standardResponse = StandardResponse().obs;
  RxList<StandardModel> standardList = <StandardModel>[].obs;
  Rx<HobbyResponse> hobbyResponse = HobbyResponse().obs;
  RxList<HobbyModel> hobbyList = <HobbyModel>[].obs;

  RxString relationShipId = ''.obs;
  RxString relationShipName = ''.obs;
  RxString occupationId = ''.obs;
  RxString occupationName = ''.obs;
  RxString standardId = ''.obs;
  RxString standardName = ''.obs;
  RxString hobbyId = ''.obs;
  RxString hobbyName = ''.obs;
  RxString selectedGender = ''.obs;

  RxString attachment = ''.obs;
  RxString docName = ''.obs;
  RxString extension = ''.obs;
  Rx<File?> selectedImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchDataInParallel();
  }

  Future<void> fetchDataInParallel() async {
    if (await Network.isConnected()) {
      try {
        isLoading(true);
        await Future.wait([
          relationshipAPICall(),
          occupationAPICall(),
          standardAPICall(),
          hobbyAPICall(),
        ]).then((_) {
          isLoading(false);
        });
      } catch (e) {
        isLoading(false);
        AppSnackBar.showGetXCustomSnackBar(message: e.toString());
      } finally {
        isLoading(false);
      }
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }

  Future<void> relationshipAPICall() async {
    try {
      Map<String, dynamic> param = {
        'Master': 'Relationship',
      };

      var response = await DioClient()
          .postQuery(AppURL.getEmployeeFamilyDropdownURL, queryParams: param);
      // if (response['code'] == 200 && response['status'] == true) {
      //   // Update the RxList when data is fetched
      //   relationshipList.value = List<RelationshipModel>.from(
      //       response['data'].map((item) => RelationshipModel.fromJson(item)));
      // } else {
      //   AppSnackBar.showGetXCustomSnackBar(message: "${response['message']}");
      // }

      relationShipResponse.value = RelationshipResponse.fromJson(response);
      if (relationShipResponse.value.code == 200 &&
          relationShipResponse.value.status == true) {
        relationshipList.value = relationShipResponse.value.data!;
      } else {
        AppSnackBar.showGetXCustomSnackBar(
            message: "${relationShipResponse.value.message}");
      }
    } catch (e) {
      AppSnackBar.showGetXCustomSnackBar(message: e.toString());
    }
  }

  Future<void> occupationAPICall() async {
    try {
      Map<String, dynamic> param = {
        'Master': 'Occupation',
      };

      var response = await DioClient()
          .postQuery(AppURL.getEmployeeFamilyDropdownURL, queryParams: param);
      // if (response['code'] == 200 && response['status'] == true) {
      // } else {
      //   AppSnackBar.showGetXCustomSnackBar(message: response['message']);
      // }

      occupationResponse.value = OccupationResponse.fromJson(response);
      if (occupationResponse.value.code == 200 &&
          occupationResponse.value.status == true) {
        occupationList.value = occupationResponse.value.data!;
      } else {
        AppSnackBar.showGetXCustomSnackBar(
            message: "${occupationResponse.value.message}");
      }
    } catch (e) {
      AppSnackBar.showGetXCustomSnackBar(message: e.toString());
    }
  }

  Future<void> standardAPICall() async {
    try {
      Map<String, dynamic> param = {
        'Master': 'Standard',
      };

      var response = await DioClient()
          .postQuery(AppURL.getEmployeeFamilyDropdownURL, queryParams: param);
      // if (response['code'] == 200 && response['status'] == true) {
      // } else {
      //   AppSnackBar.showGetXCustomSnackBar(message: response['message']);
      // }

      standardResponse.value = StandardResponse.fromJson(response);
      if (standardResponse.value.code == 200 &&
          standardResponse.value.status == true) {
        standardList.value = standardResponse.value.data!;
      } else {
        AppSnackBar.showGetXCustomSnackBar(
            message: "${standardResponse.value.message}");
      }
    } catch (e) {
      AppSnackBar.showGetXCustomSnackBar(message: e.toString());
    }
  }

  Future<void> hobbyAPICall() async {
    try {
      Map<String, dynamic> param = {
        'Master': 'Hobby',
      };

      var response = await DioClient()
          .postQuery(AppURL.getEmployeeFamilyDropdownURL, queryParams: param);
      // if (response['code'] == 200 && response['status'] == true) {
      // } else {
      //   AppSnackBar.showGetXCustomSnackBar(message: response['message']);
      // }

      hobbyResponse.value = HobbyResponse.fromJson(response);
      if (hobbyResponse.value.code == 200 &&
          hobbyResponse.value.status == true) {
        hobbyList.value = hobbyResponse.value.data!;
      } else {
        AppSnackBar.showGetXCustomSnackBar(
            message: "${hobbyResponse.value.message}");
      }
    } catch (e) {
      AppSnackBar.showGetXCustomSnackBar(message: e.toString());
    }
  }

  Future<void> insertFamilyDetails() async {
    try {
      isSubmitLoading(true);
      isDisable(true);

      // Check if network is available
      if (await Network.isConnected()) {
        Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
        String loginID = loginData['login_ID'].toString();
        String empID = loginData['emp_ID'].toString();
        String cmpID = loginData['cmp_ID'].toString();

        Map<String, dynamic> param = {
          "row_ID": 0,
          "empID": empID,
          "cmpID": cmpID,
          "name": familyMembersNameController.value.text,
          "gender": selectedGender.value,
          "dob": dobController.value.text.isNotEmpty
              ? AppDatePicker.convertDateTimeFormat(dobController.value.text,
                  'dd/MM/yyyy, EEEE', Utils.commonUTCDateFormat)
              : '',
          "relationship": relationShipName.value,
          "is_Resi": isResidingValue.value,
          "is_Dependant": isDependentValue.value,
          "loginId": loginID,
          "imagePath": attachment.value,
          "panCardNo": panCardController.value.text,
          "adharCardNo": aadharCardController.value.text,
          "height": heightController.value.text.toString(),
          "weight": weightController.value.text.toString(),
          "occpId": occupationId.value.isNotEmpty ? occupationId.value : 0,
          "hobbyID": hobbyId.value.toString(),
          "hobbyName": otherHobbyController.value.text,
          "depComp": companyNameController.value.text,
          "standID": standardId.value.isNotEmpty ? standardId.value : 0,
          "schoolCol": clgNameController.value.text,
          "extActivity": extraActivityController.value.text,
          "citySchCol": clgCityController.value.text,
          "cmpCityName": companyCityController.value.text
        };

        var response = await DioClient()
            .post(AppURL.insertEmployeeFamilyDetailsURL, param);

        if (response['code'] == 200 && response['status'] == true) {
          final data = response['data'];
          if (data != null) {
            Utils.closeKeyboard(Get.context!);
            Get.back();
            final ProfileController controller = Get.put(ProfileController());
            controller.fetchDataInParallel();

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
    } finally {
      isSubmitLoading(false);
      isDisable(false);
    }
  }

  void validationWithAPI() {
    if (familyMembersNameController.value.text.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(
          message: 'Please enter family member name.');
    } else if (relationShipId.value.isEmpty && relationShipName.value.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(
          message: 'Please select relationship.');
    } else if (selectedGender.value.isEmpty) {
      AppSnackBar.showGetXCustomSnackBar(message: 'Please select gender.');
    } else {
      insertFamilyDetails();
    }
  }

  Future<String?> filePickerFun() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Restrict to images only
      allowMultiple: false, // Optional: Restrict to a single file selection
    );

    if (result != null) {
      String filePath = result.files.single.path!;
      docName.value = result.files.single.name;
      extension.value = ".${result.files.single.extension}";
      attachment.value = await Utils.convertFileToBase64(filePath);
    }

    return null;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery); // or ImageSource.camera for capturing

    if (pickedFile != null) {
      docName.value = pickedFile.name;
      extension.value = ".${pickedFile.name.split('.').last}";
      selectedImage.value = File(pickedFile.path);
      attachment.value =
          await Utils.convertFileToBase64(selectedImage.value!.path);
    } else {
      if (kDebugMode) {
        print("No image selected.");
      }
    }
  }
}

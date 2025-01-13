import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/screen/profile/profile_family_model.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';

class FamilyDetailsViewController extends GetxController {
  RxString name = ''.obs;
  RxString relationship = ''.obs;
  RxString gender = ''.obs;
  RxString dob = ''.obs;
  RxString occupation = ''.obs;
  RxString hobby = ''.obs;
  RxString standard = ''.obs;
  RxString specialization = ''.obs;
  RxString clg = ''.obs;
  RxString city = ''.obs;
  RxString extraActivity = ''.obs;
  RxString isResiding = ''.obs;
  RxString isDependent = ''.obs;
  RxString panCard = ''.obs;
  RxString aadharCard = ''.obs;
  RxString height = ''.obs;
  RxString weight = ''.obs;

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
    final leaveData = Get.arguments['familyDetails'] as Data;
    name.value = leaveData.name ?? '';
    relationship.value = leaveData.relationship ?? '';
    gender.value = leaveData.gender ?? '';
    dob.value = AppDatePicker.convertDateTimeFormat(leaveData.dateOfBirth ?? '', Utils.commonUTCDateFormat, 'dd/MM/yyyy');
    occupation.value = leaveData.occupationID.toString();
    hobby.value = leaveData.hobbyName ?? '';
    standard.value = leaveData.standardID.toString();
    specialization.value = leaveData.stdSpecialization ?? '';
    clg.value = leaveData.shcoolCollege ?? '';
    city.value = leaveData.city ?? '';
    extraActivity.value = leaveData.extraActivity ?? '';
    isResiding.value = leaveData.isResi == 1 ? 'Yes' : 'No';
    isDependent.value = leaveData.isDependant == 1 ? 'Yes' : 'No';
    panCard.value = maskNumber(leaveData.panCardNo ?? '');
    aadharCard.value = maskNumber(leaveData.adharCardNo ?? '');
    height.value = leaveData.height ?? '';
    weight.value = leaveData.weight ?? '';
  }
}

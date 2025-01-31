import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:selfie_camera/selfie_camera.dart';

import '../app/app_colors.dart';
import '../app/app_font_weight.dart';
import '../app/app_strings.dart';
import '../widget/common_text.dart';

/// All app level utility methods are defined here
class Utils {
  Utils._();

  static String commonUTCDateFormat = 'yyyy-MM-ddThh:mm:ss';
  static String commonAppDateFormat = 'yyyy, MMM dd hh:mm a';

  static List<LatLng> polylineCoordinates = [];

  static double getScreenHeight({required BuildContext context}) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenWidth({required BuildContext context}) {
    return MediaQuery.of(context).size.width;
  }

  static void closeKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static Gradient commonGradiant() {
    return const LinearGradient(
      colors: [
        AppColors.colorGradientStart,
        AppColors.colorGradientEnd,
      ],
    );
  }

  static void messageBottom(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2.8,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CommonText(
                      padding: const EdgeInsets.only(top: 20),
                      text: AppString.successText,
                      fontSize: 19,
                      maxLine: 2,
                      color: AppColors.colorBlack,
                      fontWeight: AppFontWeight.regular,
                    ),
                  ],
                ).marginOnly(top: 50, left: 15, right: 10),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 8,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateColor.resolveWith(
                                  (states) => AppColors.purpleSwatch,
                                ),
                                shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ))),
                            onPressed: () {
                              Get.back();
                            },
                            child: CommonText(
                              text: AppString.ok,
                              color: AppColors.colorWhite,
                              fontSize: 16,
                              fontWeight: AppFontWeight.w600,
                            ),
                          ),
                        ).paddingOnly(left: 30, right: 30),
                      ]).marginOnly(top: 35, left: 15, right: 15),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget iconButton() {
    return SizedBox(
      height: 40,
      width: 40,
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          side: BorderSide(width: 1, color: AppColors.purpleSwatch),
        ),
        child: InkWell(
          onTap: () {},
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          splashColor: AppColors.purpleSwatch.withValues(alpha: 0.5),
          child: const RotatedBox(
            quarterTurns: 0,
            child: Icon(Icons.person, size: 16, color: AppColors.purpleSwatch),
          ),
        ),
      ),
    );
  }

  static Future<XFile?> pickImage(
      {required ImageSource source, required CameraDevice cameraDevice}) async {
    try {
      final pickedFile = await ImagePicker()
          .pickImage(source: source, preferredCameraDevice: cameraDevice);
      if (pickedFile != null) {
        // selectedImage.value = File(pickedFile.path);
        debugPrint("SELECTED ::: ${pickedFile.path}");
        return pickedFile;
      } else {
        debugPrint('No image selected.');
        return null;
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
    return null;
  }

  static Future<XFile?> captureSelfie({required BuildContext context}) async {
    try {
      final pickedFile = await SelfieCamera.selfieCameraFile(
        context,
        imageResolution: ImageResolution.max,
        defaultCameraType: CameraType.front,
        defaultFlashType: CameraFlashType.off,
        imageScale: ImageScale.big,
        showCameraTypeControl: false,
      );
      if (pickedFile != null) {
        // selectedImage.value = File(pickedFile.path);
        debugPrint("SELECTED ::: ${pickedFile.path}");
        return pickedFile;
      } else {
        debugPrint('No image selected.');
        return null;
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
    return null;
  }

  static Widget commonCircularProgress() {
    return const CircularProgressIndicator(
      color: AppColors.purpleSwatch,
      strokeWidth: 2,
    );
  }

  static Future<String> selectDateNew({required BuildContext context}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null) {
      return DateFormat('yyyy-MM-dd').format(picked);
    } else {
      return '';
    }
  }

  static Future<String> convertFileToBase64(String filePath) async {
    var file = File(filePath);
    List<int> bytes = await file.readAsBytes();

    String base64String = base64.encode(bytes);
    return base64String;
  }
}

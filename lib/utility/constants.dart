import 'dart:io';

import 'package:flutter/foundation.dart';

class Constants {
  Constants._();

  //TODO : App Constant
  static const int passwordLengthApp =
      8; // Define password length which is used in whole app
  static const String userIdApp = "userIdApp";
  static const String passwordApp = "passwordApp";
  static const String serverNameApp = "serverNameApp";

  static const String checkInTimeApp = "checkInTimeApp";
  static const String isCheckInApp = "isCheckInApp";
  static const String checkOutTimeApp = "checkOutTimeApp";
  static const String workingModeApp = "workingModeApp";
  static const String workingHoursApp = "workingHourApp";

  static get deviceTypePlatform => kIsWeb
      ? 'web'
      : Platform.isAndroid
          ? 'android'
          : 'ios'; // used in api calls
  static const int otpLength =
      4; // Define OTP length which is used in whole app
// Define your api's code for unauthorized

  //TODO : Pref Constants
  static const String appUrlPref = 'appUrlPref';
  static const String isClockingPref = 'isClockingPref';
  static const String isThemePref = 'isThemePref';
  static const String isLoginPref = 'isLoginPref';
  static const String fcmIdPref = 'fcmIdPref';
  static const String authTokenPref = 'authTokenPref';
  static const String loginDataPref = 'loginDataPref';
  static const String loginDetailsArrayPref = 'loginDetailsArrayPref';
  static const String deviceIDPref = 'deviceIDPref';
  static const String isRememberPref = 'isRememberPref';
  static const String loginUserIDPref = 'loginUserIDPref';
  static const String loginUserPasswordPref = 'loginUserPasswordPref';
  static const String serverConnectionPref = 'serverConnectionPref';
  static const String locationDetailsPref = 'locationDetailsPref';
  static const String profileImagePref = 'profileImagePref';

  //TODO : Msg Show Constants
  static const String contactMsg = 'Please contact to system admin...';
  static const String networkTitleMsg = 'No Internet connection';
  static const String networkMsg =
      'Please check your internet connection and try again';
  static const String networkRestoreMsg =
      'Internet connected click home button data is restore...';
  static const String noDataMsg = 'No record found...';
  static const String timeOutMsg =
      'Oops, Sorry time out, please try after some time...';
  static const String somethingWrongMsg =
      'Something went wrong, please try after some time...';
}

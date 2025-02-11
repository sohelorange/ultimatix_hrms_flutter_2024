import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
/*import 'package:url_launcher/url_launcher.dart';*/

import '../../utility/preference_utils.dart';

class SettingsController extends GetxController {
  RxBool isCameraEnabled = false.obs;
  RxBool isPatternEnabled = false.obs;
  RxBool isVoiceEnabled = false.obs;
  RxString appVersion = "0.0.0..".obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
    int isCamera = loginData['is_Camera_enable'] ?? 0;
    isCameraEnabled.value = isCamera == 1 ? true : false;

    _getAppVersion();
  }

  /*void makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      debugPrint('Could not launch $phoneUri');
    }
  }*/

  /*void sendEmail(String recipient) async {
    try {
      final Uri gmailUri = Uri(
        scheme: 'mailto',
        path: recipient,
        query: 'subject=Support&body=Hello,',
      );

      if (await canLaunchUrl(gmailUri)) {
        await launchUrl(
          gmailUri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        debugPrint('Could not find Gmail app or email client.');
      }
    } catch (e) {
      debugPrint('Error launching email client: $e');
    }
  }*/

  Future<void> _getAppVersion() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      //appVersion.value = "${packageInfo.version} (${packageInfo.buildNumber})";
      appVersion.value = packageInfo.version;
    } catch (e) {
      appVersion.value = "Failed to get version info";
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/app/app_strings.dart';
import 'package:ultimatix_hrms_flutter/screen/auth/login/login_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_input.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).size.width / 4),
                child: const CommonAppImage(
                  imagePath: AppImages.icAppLogo,
                  height: 60,
                  width: 60,
                  fit: BoxFit.fill,
                ),
              ),
              Row(
                children: [
                  CommonText(
                    padding:
                        const EdgeInsets.only(top: 3, bottom: 12, left: 12),
                    text: AppString.loginDetails,
                    color: AppColors.colorBlack,
                    fontSize: 18,
                    fontWeight: AppFontWeight.bold,
                  ),
                ],
              ).paddingOnly(left: 15, top: 20),
              Row(
                children: [
                  CommonText(
                    padding:
                        const EdgeInsets.only(top: 3, bottom: 12, left: 12),
                    text: AppString.pleaseEnterUserNamePassword,
                    color: AppColors.colorBlack,
                    fontSize: 13,
                    fontWeight: AppFontWeight.regular,
                  ),
                ],
              ).paddingOnly(left: 15),
              Row(
                children: [
                  CommonText(
                    padding:
                        const EdgeInsets.only(top: 3, bottom: 12, left: 12),
                    text: AppString.loginId,
                    color: AppColors.colorBlack,
                    fontSize: 14,
                    fontWeight: AppFontWeight.medium,
                  ),
                ],
              ).paddingOnly(left: 15, top: 17),
              CommonAppInput(
                key: const Key('Enter Login ID'),
                textEditingController: controller.userNameController,
                focusNode: controller.userNameFocus,
                hintText: AppString.enterUserName,
                // prifixPadding: const EdgeInsets.all(12),
                hintColor: AppColors.colorBlack.withOpacity(0.3),
              ).paddingOnly(left: 20, right: 20),
              Row(
                children: [
                  CommonText(
                    padding:
                        const EdgeInsets.only(top: 3, bottom: 12, left: 12),
                    text: AppString.password,
                    color: AppColors.colorBlack,
                    fontSize: 14,
                    fontWeight: AppFontWeight.medium,
                  ),
                ],
              ).paddingOnly(left: 15, top: 10),
              CommonAppInput(
                textEditingController: controller.passwordController,
                focusNode: controller.passWordFocus,
                hintText: AppString.enterpassword,
                prifixPadding: const EdgeInsets.all(12),
                hintColor: AppColors.colorBlack.withOpacity(0.3),
                isPassword: true,
              ).paddingOnly(left: 20, right: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => SizedBox(
                      height: 22,
                      width: 22,
                      child: Checkbox(
                        checkColor: Colors.white,
                        activeColor: AppColors.colorPurple,
                        value: controller.rememberCheck.value,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onChanged: (bool? value) {
                          controller.rememberCheck.value = value!;
                        },
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.rememberCheck.toggle();
                    },
                    child: CommonText(
                      padding: const EdgeInsets.only(left: 15),
                      text: AppString.rememberMe,
                      color: AppColors.colorBlack,
                      fontSize: 14,
                      fontWeight: AppFontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      // Get.toNamed(AppRoutes.forgotPasswordPage);
                    },
                    child: CommonText(
                      text: AppString.forgotPassWord,
                      color: AppColors.colorBlack,
                      fontSize: 14,
                      underlineColor: AppColors.colorBlack,
                      decorationUnderline: TextDecoration.underline,
                      fontWeight: AppFontWeight.w400,
                    ),
                  ),
                ],
              ).paddingOnly(top: 10, left: 15, right: 15,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 8,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateColor.resolveWith(
                        (states) => AppColors.colorPurple,
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                  onPressed: () {
                    // controller.onLogInAPI();
                    //Get.toNamed(AppRoutes.dashBoard);
                  },
                  child: CommonText(
                    text: AppString.login,
                    color: AppColors.colorWhite,
                    fontSize: 16,
                    fontWeight: AppFontWeight.w400,
                  ),
                ),
              ).paddingOnly(left: 30, right: 30, top: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 8,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateColor.resolveWith(
                        (states) => Colors.white,
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(color: Colors.black)))),
                  onPressed: () {
                    print('server redirect');
                    Get.offAllNamed(AppRoutes.serverRoute);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CommonAppImage(
                        imagePath: AppImages.icserver,
                        height: 25,
                        width: 25,
                        fit: BoxFit.fill,
                      ).marginOnly(right: 5),
                      CommonText(
                        padding: const EdgeInsets.only(left: 15),
                        text: AppString.serverConnection,
                        color: AppColors.colorBlack,
                        fontSize: 16,
                        fontWeight: AppFontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ).paddingOnly(left: 30, right: 30, top: 20),
            ],
          ),
        ),
      ),
    );
  }

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }
//
// class _LoginViewState extends State<LoginView> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
}

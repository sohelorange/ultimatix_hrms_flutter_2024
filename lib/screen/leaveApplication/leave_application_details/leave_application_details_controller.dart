import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_strings.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_input.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

class LeaveApplicationDetailsController extends GetxController  {

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode userNameFocus = FocusNode();
  FocusNode passWordFocus = FocusNode();

  RxBool rememberCheck = false.obs;

   void leaveCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Utils.closeKeyboard(context);
          },
          child: AlertDialog(
            surfaceTintColor: Colors.white,
            titlePadding: EdgeInsets.zero,
            actionsPadding: const EdgeInsets.only(bottom: 10),
            title: Container(
              height: MediaQuery.of(context).size.height/10,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // gradient: commonGradiant(),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    padding: const EdgeInsets.only(top: 10),
                    text: 'Cancel Application',
                    fontSize: 18,
                    color: AppColors.colorBlack,
                    fontWeight: AppFontWeight.w500,
                  ).paddingOnly(left: 20, top: 20),
                  const Divider(
                    color:AppColors.colorBlack,
                  ),

                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Obx(() => SizedBox(
                  //       height: 22,
                  //       width: 22,
                  //       child: Checkbox(
                  //         checkColor: Colors.white,
                  //         activeColor: AppColors.colorPurple,
                  //         value: rememberCheck.value,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(2),
                  //         ),
                  //         onChanged: (bool? value) {
                  //           rememberCheck.value = value!;
                  //         },
                  //       ),
                  //     ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         rememberCheck.toggle();
                  //       },
                  //       child: CommonText(
                  //         padding: const EdgeInsets.only(left: 15),
                  //         text: '03/12/2024',
                  //         color: AppColors.colorBlack,
                  //         fontSize: 14,
                  //         fontWeight: AppFontWeight.w500,
                  //       ),
                  //     ),
                  //   ],
                  // ).paddingOnly(top: 10, left: 15, right: 15,),
                  // Row(
                  //   children: [
                  //     CommonText(
                  //       padding:
                  //       const EdgeInsets.only(top: 3, bottom: 12, left: 12),
                  //       text: 'Leave Type',
                  //       color: AppColors.colorBlack,
                  //       fontSize: 14,
                  //       fontWeight: AppFontWeight.medium,
                  //     ),
                  //   ],
                  // ).paddingOnly(left: 15, top: 17),
                  // CommonAppInput(
                  //   textEditingController: userNameController,
                  //   focusNode: userNameFocus,
                  //   hintText: 'Second Type',
                  //   // prifixPadding: const EdgeInsets.all(12),
                  //   hintColor: AppColors.colorBlack.withOpacity(0.3),
                  // ).paddingOnly(left: 20, right: 20),
                  // Row(
                  //   children: [
                  //     CommonText(
                  //       padding:
                  //       const EdgeInsets.only(top: 3, bottom: 12, left: 12),
                  //       text: 'Comment',
                  //       color: AppColors.colorBlack,
                  //       fontSize: 14,
                  //       fontWeight: AppFontWeight.medium,
                  //     ),
                  //   ],
                  // ).paddingOnly(left: 15, top: 10),
                  // CommonAppInput(
                  //   textEditingController: passwordController,
                  //   focusNode: passWordFocus,
                  //   hintText: 'Type Here....',
                  //   prifixPadding: const EdgeInsets.all(12),
                  //   hintColor: AppColors.colorBlack.withOpacity(0.3),
                  //   isPassword: true,
                  // ).paddingOnly(left: 20, right: 20),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width,
                  //   height: MediaQuery.of(context).size.width / 8,
                  //   child: ElevatedButton(
                  //     style: ButtonStyle(
                  //         backgroundColor: WidgetStateColor.resolveWith(
                  //               (states) => AppColors.colorPurple,
                  //         ),
                  //         shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  //             RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(10.0),
                  //             ))),
                  //     onPressed: () {
                  //       Get.back();
                  //     },
                  //     child: CommonText(
                  //       text: AppString.submit,
                  //       color: AppColors.colorWhite,
                  //       fontSize: 16,
                  //       fontWeight: AppFontWeight.w400,
                  //     ),
                  //   ),
                  // ).paddingOnly(left: 30, right: 30, top: 20),
                ],
              )
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() => SizedBox(
                      height: 22,
                      width: 22,
                      child: Checkbox(
                        checkColor: Colors.white,
                        activeColor: AppColors.colorPurple,
                        value: rememberCheck.value,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        onChanged: (bool? value) {
                          rememberCheck.value = value!;
                        },
                      ),
                    ),
                    ),
                    GestureDetector(
                      onTap: () {
                        rememberCheck.toggle();
                      },
                      child: CommonText(
                        padding: const EdgeInsets.only(left: 15),
                        text: '03/12/2024',
                        color: AppColors.colorBlack,
                        fontSize: 14,
                        fontWeight: AppFontWeight.w500,
                      ),
                    ),
                  ],
                ).paddingOnly(top:10,left: 15, right: 15),
                Row(
                  children: [
                    CommonText(
                      padding:
                      const EdgeInsets.only(top: 3, bottom: 12, left: 12),
                      text: 'Leave Type',
                      color: AppColors.colorBlack,
                      fontSize: 16,
                      fontWeight: AppFontWeight.w400,
                    ),
                  ],
                ).paddingOnly(left: 15, top: 17),
                CommonAppInput(
                  textEditingController: userNameController,
                  focusNode: userNameFocus,
                  hintText: 'Second Type',
                  // prifixPadding: const EdgeInsets.all(12),
                  hintColor: AppColors.colorBlack.withOpacity(0.3),
                ).paddingOnly(left: 20, right: 20),
                Row(
                  children: [
                    CommonText(
                      padding:
                      const EdgeInsets.only(top: 3, bottom: 12, left: 12),
                      text: 'Comment',
                      color: AppColors.colorBlack,
                      fontSize: 16,
                      fontWeight: AppFontWeight.w400,
                    ),
                  ],
                ).paddingOnly(left: 15, top: 10),
                CommonAppInput(
                  textEditingController: passwordController,
                  focusNode: passWordFocus,
                  hintText: 'Type Here....',
                  prifixPadding: const EdgeInsets.all(12),
                  hintColor: AppColors.colorBlack.withOpacity(0.3),
                  isPassword: true,
                ).paddingOnly(left: 20, right: 20),
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
                      Get.back();
                    },
                    child: CommonText(
                      text: AppString.submit,
                      color: AppColors.colorWhite,
                      fontSize: 16,
                      fontWeight: AppFontWeight.w400,
                    ),
                  ),
                ).paddingOnly(left: 30, right: 30, top: 20),
              ],
            )
          ),
        );
      },
    );
  }

}
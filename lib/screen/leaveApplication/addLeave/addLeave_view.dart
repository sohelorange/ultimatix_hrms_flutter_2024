import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_strings.dart';
import 'package:ultimatix_hrms_flutter/screen/leaveApplication/addLeave/addLeave_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_elevatedbutton.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_images.dart';
import '../../../widget/common_app_image.dart';
import '../../../widget/common_text.dart';

class AddleaveView extends GetView<AddleaveController> {
  const AddleaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.colorAppBars, AppColors.colorAppBars],
          // Gradient colors
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [0.8, 0.9],
          // Stops for the gradient colors
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: GestureDetector(
            onTap: () {
              Utils.closeKeyboard(context);
            },
            child: SafeArea(
              child: Stack(
                children: [
                  Scaffold(
                    appBar: AppBar(
                      surfaceTintColor: Colors.transparent,
                      elevation: 0,
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.colorAppBars,
                              AppColors.colorAppBars
                            ],
                            // Gradient colors
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            stops: [0.3, 0.7],
                            // Stops for the gradient colors
                            tileMode: TileMode.clamp,
                          ),
                        ),
                      ),
                      centerTitle: true,
                      leading: InkWell(
                        splashColor: AppColors.colorWhite,
                        onTap: () {
                          Get.back();
                        },
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 15, top: 10, bottom: 10, right: 15),
                          child: CommonAppImage(
                            imagePath: AppImages.icarrowback,
                            height: 10,
                            width: 10,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      title: CommonText(
                        text: 'Add Leaves',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: AppColors.colorBlack,
                      ),
                      // bottom: tabBarView(),
                    ),
                    body: getAddLeaveView(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getAddLeaveView(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.colorAppBars, AppColors.colorAppBars],
              // Gradient colors
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.3, 0.7],
              // Stops for the gradient colors
              tileMode: TileMode.clamp,
            ),
          ),
          height: Utils.getScreenHeight(context: context) / 15,
        ),
        Container(
          height: Utils.getScreenHeight(context: context),
          width: Utils.getScreenWidth(context: context),
          decoration: const BoxDecoration(
              color: AppColors.colorWhite,
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  getLeavetypeDropdownWidget(context),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: controller.fromDateController.value,
                    onTap: () {
                      Utils.closeKeyboard(context);
                      controller.selectDate(context).then((value) {
                        if (value.isNotEmpty) {
                          controller.fromDateController.value.text = value;
                        }
                      });
                    },
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: Icon(Icons.calendar_month),
                      hintText: 'From Date',
                    ),
                  ).paddingOnly(left: 5, right: 5, top: 10),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                          color: AppColors.colorBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                      hintText: "Period",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: controller.toDateController.value,
                    onTap: () {
                      Utils.closeKeyboard(context);
                      controller.selectDate(context).then((value) {
                        if (value.isNotEmpty) {
                          controller.toDateController.value.text = value;
                        }
                      });
                    },
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: Icon(Icons.calendar_month),
                      hintText: 'To Date',
                    ),
                  ).paddingOnly(top: 10),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                          color: AppColors.colorBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                      hintText: "Reason*",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        text: 'Browse File*',
                        fontSize: 16,
                        color: AppColors.colorBlack,
                        fontWeight: AppFontWeight.w400,
                      ),
                      CommonAppImage(
                        imagePath: AppImages.icbrowse,
                        height: 30,
                        width: 30,
                      )
                    ],
                  ),
                  CommonAppElevatedButton(
                    text: AppString.submit,
                    buttonBackgroundColor: AppColors.color7B1FA2,
                    buttonFontSize: 16,
                    buttonFontWeight: FontWeight.w400,
                    onClick: () {},
                    isLoading: false,
                  ).paddingOnly(top: 30),
                ],
              ).paddingAll(25))
        ).marginOnly(top: 10),
      ],
    );
  }

  getLeavetypeDropdownWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          // labelText: 'Leave Type',
        ),
        value: controller.leavetypes.value,
        isExpanded: true,
        items: controller.leavetypeitems.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: CommonText(
              text: items,
              fontSize: 14,
              color: AppColors.colorBlack,
              fontWeight: AppFontWeight.w400,
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          controller.leavetypes.value = newValue!;
        },
      ),
    );
    // return Container(
    //   width: MediaQuery.of(context).size.width * 0.9,
    //   padding: const EdgeInsets.symmetric(horizontal: 20),
    //   decoration: const ShapeDecoration(
    //     color: Colors.white,
    //     shape: UnderlineInputBorder(
    //       // side: BorderSide(
    //       //     width: 1.0, style: BorderStyle.solid, color: Colors.grey),
    //       borderRadius: BorderRadius.all(Radius.circular(8.0)),
    //     ),
    //   ),
    //   child: DropdownButton<String>(
    //     value: controller.leavetypes.value,
    //     isExpanded: true,
    //     underline: const SizedBox(),
    //     items: controller.leavetypeitems.map((String items) {
    //       return DropdownMenuItem(
    //         value: items,
    //         child: CommonText(
    //           text: items,
    //           fontSize: 14,
    //           color: AppColors.colorBlack,
    //           fontWeight: AppFontWeight.w400,
    //           padding: const EdgeInsets.only(left: 10, right: 10),
    //         ),
    //       );
    //     }).toList(),
    //     onChanged: (String? newValue) {
    //       controller.leavetypes.value = newValue!;
    //     },
    //   ),
    // ).paddingOnly(left:5, right: 5, top: 10);
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/screen/manager_approval/regularization_list_approvals/regularization_list_approvals_controller.dart';
import '../../../app/app_colors.dart';
import '../../../app/app_font_weight.dart';
import '../../../app/app_images.dart';
import '../../../utility/utils.dart';
import '../../../widget/common_app_bar.dart';
import '../../../widget/common_container.dart';
import '../../../widget/common_text.dart';

class RegularizationListApprovalsUi extends GetView<RegularizationListApprovalsController>{
  const RegularizationListApprovalsUi({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CommonAppBar(
          title: 'Regularization Approvals',
        ),
        body: CommonContainer(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: getView(context),
          ),
        ),
      ));
  }

  getView(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: Utils.getScreenHeight(context: context),
          width: Utils.getScreenWidth(context: context),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          child: Obx(() =>
          controller.isLoading.isTrue ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ Utils.commonCircularProgress(),],
          ) : Column(children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.attendanceApprovalListData.value.data?.length ?? 1,
                itemBuilder: (context, index) {
                  return responsiveContainer(context,index);
                },
              ),
            )
          ],)
          ),
        )
      ],
    );
  }

  responsiveContainer(BuildContext context, int index) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            log("The Application Id:${controller.attendanceApprovalListData.value.data?.elementAt(index).iOTranId}");
            Get.toNamed(AppRoutes.regularizeApproval,arguments: [{
              "applicationId":controller.attendanceApprovalListData.value.data?.elementAt(index).iOTranId
            }]);
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width * 0.9, // Adjust container width as needed
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color(0X1C1F370D),
                  // Light gray color for shadow
                  blurRadius: 4.0,
                  // Increase the blur for a more spread-out shadow
                  spreadRadius: 1.0,
                  // Small spread to create a more pronounced shadow
                  offset: Offset(
                      0, 0), // Offset to simulate elevation effect (vertical shadow)
                ),
              ],
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {

                double fontSize = constraints.maxWidth * 0.04;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /*First Row*/
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Small Image
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 5.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white
                          ),
                          child: /*CommonAppImage(
                            imagePath: getImageUrl(index),
                            height: 50,
                            width: 50,
                          ),*/
                          SvgPicture.asset(
                              height: 50,
                              width: 50,
                              getImageUrl(index)
                          ),
                        ),
                        const SizedBox(width: 16.0), // Spacer between image and text
                        // Column for Texts
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CommonText(
                                text: controller.attendanceApprovalListData.value.data?.elementAt(index).empFullName?.trim().toString() ?? "",
                                fontWeight: AppFontWeight.w500,
                                fontSize: fontSize,
                                color: AppColors.color1C1F37,
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  const SizedBox(width: 2.0),
                                  CommonText(
                                    text: controller.setDate(controller.attendanceApprovalListData.value.data?.elementAt(index).forDate?.trim().toString() ?? ""),
                                    color: AppColors.color6B6D7A,
                                    fontSize: fontSize,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),

                   const SizedBox(height: 16.0),

                    /*Second Row*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Box 1
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.colorF8F4FA
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                    height: 20,
                                    width: 20,
                                    AppImages.svgClock
                                ),// Clock Icon
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Check in',
                                        style: TextStyle(fontSize: fontSize,color: AppColors.color6B6D7A, fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        controller.getTime(controller.attendanceApprovalListData.value.data?.elementAt(index).inTime?.trim()),
                                        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700,
                                            color:AppColors.color1C1F37
                                          /*controller.attendanceRegularizeDetails.value.data!.elementAt(index).lateMinute! >
                                                  controller.attendanceRegularizeDetails.value.data!.elementAt(index).lateTime! ? AppColors.colorD33017 : AppColors.color1C1F37*/
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0), // Spacer between the two boxes
                        // Box 2
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.colorF8F4FA
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                    height: 20,
                                    width: 20,
                                    AppImages.svgClock
                                ),// Location Icon
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Check out',
                                        style: TextStyle(fontSize: fontSize,color: AppColors.color6B6D7A, fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        controller.getTime(controller.attendanceApprovalListData.value.data?.elementAt(index).outTime?.trim()),
                                        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700,
                                            color:AppColors.color1C1F37
                                          /*controller.attendanceRegularizeDetails.value.data!.elementAt(index).lateMinute! >
                                                  controller.attendanceRegularizeDetails.value.data!.elementAt(index).lateTime! ? AppColors.colorD33017 : AppColors.color1C1F37*/
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),

                    Text(controller.attendanceApprovalListData.value.data?.elementAt(index).halfFullDay?.trim().toString() ?? "",style: const TextStyle(color: AppColors.color7B1FA2,fontWeight: FontWeight.w600),)
                  ],
                );
              },
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.03,),
      ],
    );
  }

  getImageUrl(int index) {
    return AppImages.svgAvatar;
  }
}
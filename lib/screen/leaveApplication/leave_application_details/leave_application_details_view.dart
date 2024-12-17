import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/screen/leaveApplication/leave_application_details/leave_application_details_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_images.dart';
import '../../../utility/utils.dart';
import '../../../widget/common_app_image.dart';

class LeaveApplicationDetailsView
    extends GetView<LeaveApplicationDetailsController> {
  const LeaveApplicationDetailsView({super.key});

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
                        text: 'Application Status',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: AppColors.colorBlack,
                      ),
                      actions: [
                        InkWell(
                          splashColor: AppColors.colorWhite,
                          onTap: () {
                            controller.leaveCancelDialog(Get.context!);
                          },
                          radius: 10,
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: CommonAppImage(
                              height: 20,
                              width: 20,
                              imagePath: AppImages.icedit,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                      // bottom: tabBarView(),
                    ),
                    body: getLeaveDetailsView(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getLeaveDetailsView(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  child: Card(
                      color: AppColors.colorac6cc,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: CommonText(
                          text: 'Pending',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColors.colorF68C1F,
                        ),
                      )),
                ).paddingOnly(top: 30, left: 20, right: 20),
                CommonText(
                  text: 'Request Details',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.colorBlack,
                ).paddingOnly(left: 20, top: 20),
                Container(
                    height: 310,
                    child: Card(
                        elevation: 4,
                        color: AppColors.colorWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: 'Leave Type ',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: AppColors.color6B6D7A,
                            ).paddingOnly(left: 20, top: 10),
                            CommonText(
                              text: 'Annual Leave ',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.colorBlack,
                            ).paddingOnly(left: 20,top: 5),
                            Divider(
                              color: AppColors.colorBlack.withOpacity(0.2),
                            ).paddingOnly(left: 10, right: 10),
                            CommonText(
                              text: 'Leave From',
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              color: AppColors.color9C9BA2,
                            ).paddingOnly(left: 20),
                            CommonText(
                              text: '06/09/2024',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: AppColors.colorBlack,
                            ).paddingOnly(top: 5, left: 20),
                            CommonText(
                              text: 'Leave To',
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              color: AppColors.color9C9BA2,
                            ).paddingOnly(left: 20, top: 5),
                            CommonText(
                              text: '07/12/2024',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: AppColors.colorBlack,
                            ).paddingOnly(top: 5, left: 20),
                            Divider(
                              color: AppColors.colorBlack.withOpacity(0.2),
                            ).paddingOnly(left: 10, right: 10),
                            CommonText(
                              text: 'Period',
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              color: AppColors.color9C9BA2,
                            ).paddingOnly(left: 20),
                            CommonText(
                              text: '1 Days',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: AppColors.colorBlack,
                            ).paddingOnly(top: 5, left: 20),
                            Divider(
                              color: AppColors.colorBlack.withOpacity(0.2),
                            ).paddingOnly(left: 10, right: 10),
                            CommonText(
                              text: 'Reason',
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              color: AppColors.color9C9BA2,
                            ).paddingOnly(top: 5, left: 20),
                            CommonText(
                              text: 'Testing',
                              fontWeight: FontWeight.w500,
                              maxLine: 3,
                              fontSize: 13,
                              color: AppColors.colorBlack,
                            ).paddingOnly(top: 5, left: 20),
                          ],
                        )).paddingOnly(left: 20, right: 20, top: 10)
                ),
              ],
            ),
          ),
        ).marginOnly(top: 10),

        // Card(
        //     elevation: 4,
        //     color: AppColors.colorWhite,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //     child: Column(
        //       children: [
        //         CommonText(
        //           text: 'Leave Type  ',
        //           fontWeight: FontWeight.w700,
        //           fontSize: 16,
        //           color: AppColors.colorBlack,
        //         ),
        //         CommonText(
        //           text: 'Annual Leave ',
        //           fontWeight: FontWeight.w500,
        //           fontSize: 12,
        //           color: AppColors.colorF68C1F,
        //         ),
        //         // Row(
        //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         //   children: [
        //         //
        //         //   ],
        //         // ).paddingOnly(left: 10, right: 10, top: 10),
        //         Divider(
        //           color:
        //           AppColors.colorBlack.withOpacity(0.2),
        //         ).paddingOnly(left: 10, right: 10),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Column(
        //               children: [
        //                 CommonText(
        //                   text: 'Leave From',
        //                   fontWeight: FontWeight.normal,
        //                   fontSize: 13,
        //                   color: AppColors.color9C9BA2,
        //                 ),
        //                 CommonText(
        //                   text: '06/09/2024',
        //                   fontWeight: FontWeight.w500,
        //                   fontSize: 13,
        //                   color: AppColors.colorBlack,
        //                 ).paddingOnly(top: 5)
        //               ],
        //             ),
        //             const SizedBox(
        //               width: 40,
        //             ),
        //             Column(
        //               children: [
        //                 CommonText(
        //                   text: 'Leave To',
        //                   fontWeight: FontWeight.normal,
        //                   fontSize: 13,
        //                   color: AppColors.color9C9BA2,
        //                 ),
        //                 CommonText(
        //                   text: '07/12/2024',
        //                   fontWeight: FontWeight.w500,
        //                   fontSize: 13,
        //                   color: AppColors.colorBlack,
        //                 ).paddingOnly(top: 5)
        //               ],
        //             ),
        //             const SizedBox(
        //               width: 40,
        //             ),
        //             Column(
        //               children: [
        //                 CommonText(
        //                   text: 'Period',
        //                   fontWeight: FontWeight.normal,
        //                   fontSize: 13,
        //                   color: AppColors.color9C9BA2,
        //                 ),
        //                 CommonText(
        //                   text: '1 Days',
        //                   fontWeight: FontWeight.w500,
        //                   fontSize: 13,
        //                   color: AppColors.colorBlack,
        //                 ).paddingOnly(top: 5)
        //               ],
        //             ),
        //           ],
        //         ).paddingOnly(left: 10, right: 50, top: 5),
        //         Divider(
        //           color:
        //           AppColors.colorBlack.withOpacity(0.2),
        //         ).paddingOnly(left: 10, right: 10),
        //         Row(
        //           mainAxisAlignment:
        //           MainAxisAlignment.spaceBetween,
        //           children: [
        //             Column(
        //               children: [
        //                 CommonText(
        //                   text: 'Reason',
        //                   fontWeight: FontWeight.normal,
        //                   fontSize: 13,
        //                   color: AppColors.color9C9BA2,
        //                 ),
        //                 CommonText(
        //                   text: 'Testing',
        //                   fontWeight: FontWeight.w500,
        //                   maxLine: 3,
        //                   fontSize: 13,
        //                   color: AppColors.colorBlack,
        //                 ).paddingOnly(top: 5)
        //               ],
        //             ),
        //           ],
        //         ).paddingOnly(left: 10, right: 10, top: 5),
        //         Divider(
        //           color:
        //           AppColors.colorBlack.withOpacity(0.2),
        //         ).paddingOnly(left: 10, right: 10),
        //         Row(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Column(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               children: [
        //                 CommonText(
        //                   text: 'Assigned As',
        //                   fontWeight: FontWeight.normal,
        //                   fontSize: 13,
        //                   color: AppColors.color6B6D7A,
        //                 ).paddingOnly(right:100),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                   children: [
        //                     CommonAppImage(
        //                       imagePath: AppImages.icavtar,
        //                       height: 40,
        //                       width: 40,
        //                     ),
        //                     CommonText(
        //                       text: '0058-Mr. Jai Singh',
        //                       fontWeight: FontWeight.w500,
        //                       maxLine: 3,
        //                       fontSize: 13,
        //                       color: AppColors.colorBlack,
        //                     ).paddingOnly(left: 20)
        //                   ],
        //                 ).paddingOnly(top: 5)
        //               ],
        //             ),
        //           ],
        //         ).paddingOnly(left: 10, right: 10, top: 5),
        //       ],
        //     )).paddingOnly(left: 20, right: 20, top: 10)
      ],
    );
  }
}

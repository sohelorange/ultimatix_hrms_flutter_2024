
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/attendanceReg/regularizeApprovals/regularization_approval_controller.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_font_weight.dart';
import '../../../app/app_images.dart';
import '../../../utility/utils.dart';
import '../../../widget/common_text.dart';

class RegularizationApprovalUi extends GetView<RegularizeApprovalController>{
  const RegularizationApprovalUi({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.colorAppBars, AppColors.colorAppBars], // Gradient colors
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.3, 0.7], // Stops for the gradient colors
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
              child: SvgPicture.asset(
                AppImages.icaarrowback,
                height: 10,
                width: 10,
                fit: BoxFit.contain,
              )
          ),
        ),
        title: CommonText(
          text: 'Regularization Approvals',
          fontWeight: FontWeight.w500,
          fontSize: screenWidth * 0.045,
          color: AppColors.colorBlueDark,
        ),
      ),
      body: getView(context),
    );
  }

  getView(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.colorAppBars, AppColors.colorAppBars], // Gradient colors
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.3, 0.7], // Stops for the gradient colors
              tileMode: TileMode.clamp,
            ),
          ),
          height: Utils.getScreenHeight(context: context) / 15,
        ),
        Container(
          height: Utils.getScreenHeight(context: context),
          width: Utils.getScreenWidth(context: context),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          child:SingleChildScrollView(
            child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    width: MediaQuery.of(context).size.width * 0.9, // Adjust container width as needed
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {

                        double fontSize = constraints.maxWidth * 0.04;
                        double width = MediaQuery.of(context).size.width;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /*First Row*/
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
                                        SvgPicture.asset(AppImages.svgClock),// Location Icon// Clock Icon
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Employee Name',
                                                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w400,color: AppColors.color6B6D7A),
                                              ),
                                              Obx(
                                                    ()=> Text(
                                                  controller.attendanceApprovalListData.value.data?.elementAt(0).empFullName?.trim().toString() ?? "",
                                                  style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700, color: AppColors.color1C1F37),
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
                                        SvgPicture.asset(AppImages.svgCalRegularize),// Location Icon// Clock Icon
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Applied For',
                                                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w400,color: AppColors.color6B6D7A),
                                              ),
                                              Obx(
                                                    ()=> Text(
                                                  controller.attendanceApprovalListData.value.data?.elementAt(0).forDate?.trim().toString() ?? "",
                                                  style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700, color: AppColors.color1C1F37),
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
                                        SvgPicture.asset(AppImages.svgInTime),// Clock Icon
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'In Time',
                                                style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.w400,color: AppColors.color6B6D7A),
                                              ),
                                              Text(
                                                controller.attendanceApprovalListData.value.data?.elementAt(0).shInTime.toString() ?? "--:--",
                                                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700, color: AppColors.color1C1F37),
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
                                        SvgPicture.asset(AppImages.svgOutTime),// Location Icon
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Out Time',
                                                style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.w400,color: AppColors.color6B6D7A),
                                              ),
                                              Text(
                                                controller.attendanceApprovalListData.value.data?.elementAt(0).shOutTime.toString() ?? "--:--",
                                                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700, color: AppColors.color1C1F37),
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
                            /*Third Row*/
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
                                        SvgPicture.asset(AppImages.svgReasonRegularize),// Clock Icon
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Reason',
                                                style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.w400,color: AppColors.color6B6D7A),
                                              ),
                                              Text(
                                                controller.attendanceApprovalListData.value.data?.elementAt(0).reason?.trim().toString() ?? "--",
                                                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700, color: AppColors.color1C1F37),
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

                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Obx(()=> Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Radio<int>(
                                          value: 0,
                                          groupValue: controller.selectedValue.value,
                                          onChanged: (int? value) {
                                            if(value!=null) {
                                              controller.selectedValue.value = value;
                                            }
                                          },
                                        ),
                                        const Text('Full Day',),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio<int>(
                                          value: 1,
                                          groupValue: controller.selectedValue.value,
                                          onChanged: (int? value) {
                                            if(value!=null) {
                                              controller.selectedValue.value = value;
                                            }
                                          },
                                        ),
                                        const Text('Half Day',),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio<int>(
                                          value: 2,
                                          groupValue: controller.selectedValue.value,
                                          onChanged: (int? value) {
                                            if(value!=null) {
                                              controller.selectedValue.value = value;
                                            }
                                          },
                                        ),
                                        const Text('Second Half',),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),

                            Column(children: [
                              Row(children: [
                                Obx(()=> Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: AppColors.purpleSwatch,
                                  value: controller.isCancelLateIn.value,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  onChanged: (bool? value) {
                                    controller.isCancelLateIn.value = value!;
                                  },
                                ),
                                ),
                                const Text("Cancel Late In"),
                              ],),

                              const SizedBox(height: 16.0),

                              Row(
                                children: [
                                  Obx(()=> Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: AppColors.purpleSwatch,
                                    value:  controller.isCancelEarlyOut.value,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    onChanged: (bool? value) {
                                      controller.isCancelEarlyOut.value = value!;
                                    },
                                  ),
                                  ),
                                  const Text("Cancel Early Out"),
                                ],
                              )
                            ],),

                            const SizedBox(height: 16.0),

                            Container(
                              width: width > 600 ? 500 : width - 32,
                              padding: const EdgeInsets.only(left: 15,right: 15),
                              child: TextField(
                                controller: controller.textCommentController,
                                decoration: InputDecoration(
                                  hintText: "Superior Comment",
                                  hintStyle: const TextStyle(color: AppColors.color6B6D7A),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.color6B6D7A.withValues(alpha: 0.12)), // Default grey underline
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.color6B6D7A.withValues(alpha: 0.12)), // Grey when enabled
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.color6B6D7A.withValues(alpha: 0.12)), // Blue when focused
                                  ),
                                ),
                              ),
                            ),


                          ],
                        );
                      },
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width > 600 ? 500 : MediaQuery.of(context).size.width - 32,
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateColor.resolveWith(
                                      (states) => AppColors.color7B1FA2,
                                ),
                                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    )
                                )
                            ),
                            onPressed: () {
                              controller.toCallApi();
                              /*showDialog(context: context, builder: (context) {
                                return _showDialog(context,"Approved Successfully","Attendance regularization approvedsuccessfully");
                              },);*/
                            },
                            child: CommonText(
                              text: "Approve",
                              color: AppColors.colorWhite,
                              fontSize: 16,
                              fontWeight: AppFontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        InkWell(
                          onTap: (){
                            Get.back();
                          },
                          child:CommonText(
                            text: 'Reject',
                            color: AppColors.color7B1FA2,
                            fontSize: 16,
                            fontWeight: AppFontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                ]
            ),
          ),
        )
      ],
    );
  }

  _showDialog(BuildContext context,String title, String content){
    return AlertDialog(
      title: Column(
        children: [
          Text(title,style: const TextStyle(color: AppColors.color1C1F37,fontWeight: FontWeight.w500),),
          Divider(
            color: AppColors.color1C1F37.withAlpha(10), // Line color
            thickness: 2
          )
        ],
      ),
      content: Text(content,style: const TextStyle(color: AppColors.color1C1F37,fontWeight: FontWeight.w400)),
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateColor.resolveWith(
                      (states) => AppColors.color7B1FA2,
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )
                )
            ),
            onPressed: () {
              Get.back();
            },
            child: CommonText(
              text: "Ok",
              color: AppColors.colorWhite,
              fontSize: 16,
              fontWeight: AppFontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
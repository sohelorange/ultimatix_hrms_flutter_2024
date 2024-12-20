import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:ultimatix_hrms_flutter/screen/attendanceReg/userAttendanceRegularize/attendance_user_controller.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_font_weight.dart';
import '../../../app/app_images.dart';
import '../../../app/app_routes.dart';
import '../../../utility/utils.dart';
import '../../../widget/common_app_image.dart';
import '../../../widget/common_text.dart';

class UserAttendanceUi extends GetView<UserAttendanceController>{

  const UserAttendanceUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.colorF18700, AppColors.colorF18700], // Gradient colors
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.3, 0.7], // Stops for the gradient colors
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            /*Get.find<UserAttendanceController>().getAttendanceRecordsByApi();*/
            Get.back();
          },
        ),
        title: CommonText(
          text: 'Attendance',
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: AppColors.colorWhite,
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
              colors: [AppColors.colorF18700, AppColors.colorF18700], // Gradient colors
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
          child: Obx(() =>
          controller.isLoading.isTrue ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ Utils.commonCircularProgress(),],
          ) : Column(children: [

            Container(
              padding: const EdgeInsets.all(12.0),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(()=> Text("${controller.currentMonth.value} Attendance",style: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500,color: AppColors.color1C1F37 ),)),
                  GestureDetector(
                      onTap: () {
                        _showYearDialog(context);
                      },
                      child: SvgPicture.asset(AppImages.svgCalender))
                ],
              ),
            ),

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
                color: AppColors.colorF68C1F,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {

                  double fontSize = constraints.maxWidth * 0.04;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                                border: Border.all(color: AppColors.color1C1F37.withOpacity(0.10)),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white
                            ),
                            child: CommonAppImage(
                              imagePath: controller.userProfile.value,
                              radius: 10,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 16.0), // Spacer between image and text
                          // Column for Texts
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Obx(
                                      ()=> CommonText(
                                    text: controller.userName.value,
                                    fontWeight: AppFontWeight.w500,
                                    fontSize: fontSize,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    const CommonAppImage(imagePath: AppImages.icDesignation),
                                    const SizedBox(width: 3.0),
                                    CommonText(
                                      text: controller.userDesignation.value.toString(),
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: fontSize,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),


                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.liveTrackingRoute, arguments: [
                                {
                                  "username":controller.userName.value,
                                  "empId":controller.userEmpId.value,
                                  "cmpId":controller.userCmpId.value,
                                  "userImage":controller.userProfile.value
                                }
                              ]);
                            },
                            child: Column(
                              children: [
                                const SizedBox(height: 10,),
                                SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: SvgPicture.asset(AppImages.svgUserLoc)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: 1/*controller.attendanceRegularizeDetails.value.data?.length ?? 1*/,
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
                        child: CommonAppImage(
                          imagePath: getImageUrl(index),
                          height: 50,
                          width: 50,
                        ),
                      ),
                      const SizedBox(width: 16.0), // Spacer between image and text
                      // Column for Texts
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(
                                  ()=> CommonText(
                                text: "Monday"/*controller.getWeekDay(controller.attendanceRegularizeDetails.value.data?.elementAt(index).forDate.toString() ?? "")*//*controller.attendanceRegularizeDetails.value.data?.elementAt(index).empFullName?.trim() ?? ""*/,
                                fontWeight: AppFontWeight.w500,
                                fontSize: fontSize,
                                color: AppColors.color1C1F37,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                Icon(Icons.calendar_month,size: fontSize,),
                                const SizedBox(width: 2.0),
                                Obx(
                                      ()=> CommonText(
                                    text: "12-12-2024"/*controller.setDate(controller.attendanceRegularizeDetails.value.data!.elementAt(index).forDate.toString())*/,/*controller.attendanceRegularizeDetails.value.data?.elementAt(index).desigName?.trim() ?? "",*/
                                    color: AppColors.color6B6D7A,
                                    fontSize: fontSize,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                      Visibility(
                        visible: true/*controller.attendanceRegularizeDetails.value.data!.elementAt(index).rowStatus!*/,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(height: 8.0),
                            const CommonAppImage(
                                height: 20,
                                width: 20,
                                imagePath: AppImages.icPendingReg
                            ),
                            /*controller.attendanceRegularizeDetails.value.data?.elementAt(index).chkBySuperior=="Pending" ?
                            const CommonAppImage(
                                height: 20,
                                width: 20,
                                imagePath: AppImages.icPendingReg
                            ) : controller.attendanceRegularizeDetails.value.data?.elementAt(index).chkBySuperior=="Approved" ?
                            const CommonAppImage(
                                height: 20,
                                width: 20,
                                imagePath: AppImages.icApproveReg
                            ) : controller.attendanceRegularizeDetails.value.data?.elementAt(index).chkBySuperior=="Rejected" ?
                            const CommonAppImage(
                                height: 20,
                                width: 20,
                                imagePath: AppImages.icCancelReg
                            ) :*/ GestureDetector(
                              onTap: () {
                                /*Get.toNamed(AppRoutes.regularizeRequest, arguments: [
                                  {
                                    "Shift1": controller.attendanceRegularizeDetails.value.data?.elementAt(index).shInTime ?? "--:--",
                                    "Shift2": controller.attendanceRegularizeDetails.value.data?.elementAt(index).shOutTime ?? "",
                                    "empId": controller.attendanceRegularizeDetails.value.data?.elementAt(index).empId,
                                    "cmpId": controller.attendanceRegularizeDetails.value.data?.elementAt(index).cmpID,
                                    "forDate": controller.attendanceRegularizeDetails.value.data?.elementAt(index).forDate,
                                    "halfFullDay": controller.attendanceRegularizeDetails.value.data?.elementAt(index).pDays ?? "--:--",
                                    "cancellationLateIn": controller.attendanceRegularizeDetails.value.data?.elementAt(index).isCancelLateIn ?? "--:--",
                                    "cancellationEarlyOut": controller.attendanceRegularizeDetails.value.data?.elementAt(index).isCancelEarlyOut ?? "--:--",
                                    "inTime1": controller.attendanceRegularizeDetails.value.data?.elementAt(index).leaveCode ?? "--:--",
                                    "outTime1": controller.attendanceRegularizeDetails.value.data?.elementAt(index).rowID ?? "--:--",
                                    "lateIn": controller.attendanceRegularizeDetails.value.data?.elementAt(index).earlyMinute ?? "--:--",
                                    "earlyOut": controller.attendanceRegularizeDetails.value.data?.elementAt(index).isLeaveApp ?? "--:--",
                                  }
                                ]);*/
                              },
                              child: const CommonAppImage(
                                  height: 20,
                                  width: 20,
                                  imagePath: AppImages.icEditPen
                              ),
                            ),
                          ],),
                      )
                    ],
                  ),

                  /*controller.attendanceRegularizeDetails.value.data?.elementAt(index).mainStatus=="W" || controller.attendanceRegularizeDetails.value.data?.elementAt(index).mainStatus=="A" ? const SizedBox(height: 0)
                      :*/ const SizedBox(height: 16.0),

                  /*Second Row*/
                  /*controller.attendanceRegularizeDetails.value.data?.elementAt(index).mainStatus=="W" || controller.attendanceRegularizeDetails.value.data?.elementAt(index).mainStatus=="A" ? Container()
                      :*/ Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Box 1
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.colorac6cc
                          ),
                          child: Row(
                            children: [
                              const CommonAppImage(
                                  height: 20,
                                  width: 20,
                                  imagePath: AppImages.icacheckinnew
                              ), // Clock Icon
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
                                    Obx(
                                          ()=> Text(
                                        "10:30AM"/*controller.attendanceRegularizeDetails.value.data?.elementAt(index).shInTime?.trim() ?? ""*/,
                                        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700,
                                            color:AppColors.color1C1F37
                                            /*controller.attendanceRegularizeDetails.value.data!.elementAt(index).lateMinute! >
                                                controller.attendanceRegularizeDetails.value.data!.elementAt(index).lateTime! ? AppColors.colorD33017 : AppColors.color1C1F37*/
                                        ),
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
                              color: AppColors.colorac6cc
                          ),
                          child: Row(
                            children: [
                              const CommonAppImage(
                                  height: 20,
                                  width: 20,
                                  imagePath: AppImages.icacheckinnew
                              ), // Location Icon
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
                                    Obx(
                                          ()=> Text(
                                        "6:00Pm"/*controller.attendanceRegularizeDetails.value.data?.elementAt(index).shOutTime?.trim() ?? ""*/,
                                        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700,
                                            color:AppColors.color1C1F37
                                            /*controller.attendanceRegularizeDetails.value.data!.elementAt(index).lateMinute! >
                                                controller.attendanceRegularizeDetails.value.data!.elementAt(index).lateTime! ? AppColors.colorD33017 : AppColors.color1C1F37*/
                                        ),
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

                ],
              );
            },
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.03,),
      ],
    );
  }

  getImageUrl(int index) {
    /*if(controller.attendanceRegularizeDetails.value.data!.elementAt(index).mainStatus=="A"){
      return AppImages.icAbsentImg;
    }else if(controller.attendanceRegularizeDetails.value.data!.elementAt(index).mainStatus=="P"){
      return AppImages.icPresentImg;
    }else if(controller.attendanceRegularizeDetails.value.data!.elementAt(index).mainStatus=="W"){
      return AppImages.icWeekOffImg;
    }else if(controller.attendanceRegularizeDetails.value.data!.elementAt(index).mainStatus=="HO"){
      return AppImages.icHolidayImg;
    }else{
      return AppImages.icAbsentImg;
    }*/
    return AppImages.imgUserProf;
  }

  void _showYearDialog(BuildContext context) {
    controller.selectedYear.value = 0;
    controller.selectedMonth.value = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Year'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3, // 40% of screen height
            width: MediaQuery.of(context).size.width * 0.8,
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount;
                if (constraints.maxWidth < 400) {
                  crossAxisCount = 2; // For smaller screens
                } else if (constraints.maxWidth < 800) {
                  crossAxisCount = 3; // For medium screens
                } else {
                  crossAxisCount = 4; // For larger screens
                }

                return Obx(
                      ()=> GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 2
                    ),
                    itemCount: controller.selectedYear.value==0 ? 6 : controller.items.length, // Total years
                    itemBuilder: (context, index) {
                      final year = DateTime.now().year + index;
                      return GestureDetector(
                        onTap: () {
                          if(controller.selectedYear.value==0) {
                            controller.selectedYear.value = year;
                          }else{
                            if(controller.selectedYear.value!=0){
                              controller.selectedMonth.value = index+1;
                              /*Fluttertoast.showToast(msg: "Selected: ${controller.selectedYear.toString()}-${controller.selectedMonth.value}");*/
                              /*controller.callUserAttendanceRegularizationDetails();*/
                              controller.selectedYear.value = 0;
                              controller.selectedMonth.value = 0;
                              Navigator.of(context).pop();
                            }
                          }
                        },
                        child: Card(
                          child: Center(
                            child: Obx(
                                  ()=> Text(
                                controller.selectedYear.value==0 ? year.toString() : controller.items.value.elementAt(index).toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.selectedYear.value = 0;
                controller.selectedMonth.value = 0;
              },
              child: const Center(child: Text('Close',style: TextStyle(color: AppColors.color68C1F,fontWeight: FontWeight.w500,fontSize: 18),)),
            ),
          ],);
      },);
  }
}
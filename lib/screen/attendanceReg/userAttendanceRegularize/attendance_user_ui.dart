import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/attendanceReg/userAttendanceRegularize/attendance_user_controller.dart';
import '../../../app/app_colors.dart';
import '../../../app/app_font_weight.dart';
import '../../../app/app_images.dart';
import '../../../app/app_routes.dart';
import '../../../app/app_snack_bar.dart';
import '../../../utility/utils.dart';
import '../../../widget/common_app_image.dart';
import '../../../widget/common_text.dart';

class UserAttendanceUi extends GetView<UserAttendanceController>{

  const UserAttendanceUi({super.key});

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
            /*Get.find<UserAttendanceController>().getAttendanceRecordsByApi();*/
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
          text: 'Attendance',
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
          child: Obx(() =>
          controller.isLoading.isTrue ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ Utils.commonCircularProgress(),],
          ) : Column(children: [

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
                gradient: const LinearGradient(
                  colors: [AppColors.color161F59, AppColors.color631983], // Gradient colors
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [0.4, 0.7], // Stops for the gradient colors
                  tileMode: TileMode.clamp,
                ),
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
                                Obx(()=> CommonText(
                                    text: controller.userName.value,
                                    fontWeight: AppFontWeight.w500,
                                    fontSize: fontSize,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    SvgPicture.asset(AppImages.icDesignation),
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
                                    child: SvgPicture.asset(AppImages.svgUserLocation)),
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
            GestureDetector(
              onTap: () {
                _showYearDialog(context);
              },
              child: Container(
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
                  gradient: const LinearGradient(
                    colors: [AppColors.color161F59, AppColors.color631983], // Gradient colors
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [0.4, 0.7], // Stops for the gradient colors
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {

                    double fontSize = constraints.maxWidth * 0.04;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppImages.svgCalender),
                            const SizedBox(width: 12,),
                            Text("${controller.currentMonth.value} Attendance",style: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500,color: AppColors.colorWhite),),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: controller.attendanceRegularizeDetails.value.data?.length ?? 1,
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
                        child: SvgPicture.asset(
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
                                text: controller.getWeekDay(controller.attendanceRegularizeDetails.value.data?.elementAt(index).forDate.toString() ?? ""),
                                fontWeight: AppFontWeight.w500,
                                fontSize: fontSize,
                                color: AppColors.color1C1F37,
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                const SizedBox(width: 2.0),
                                CommonText(
                                    text: controller.setDate(controller.attendanceRegularizeDetails.value.data!.elementAt(index).forDate.toString()),
                                    color: AppColors.color6B6D7A,
                                    fontSize: fontSize,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                      Visibility(
                        visible: controller.attendanceRegularizeDetails.value.data!.elementAt(index).rowStatus!,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(height: 8.0),
                            controller.attendanceRegularizeDetails.value.data?.elementAt(index).chkBySuperior=="Pending" ?
                            SvgPicture.asset(
                                AppImages.icPendingReg,
                                height: 20,
                                width: 20
                            ) : controller.attendanceRegularizeDetails.value.data?.elementAt(index).chkBySuperior=="Approved" ?
                            SvgPicture.asset(
                                AppImages.icApproveReg,
                                height: 20,
                                width: 20
                            ) : controller.attendanceRegularizeDetails.value.data?.elementAt(index).chkBySuperior=="Rejected" ?
                            SvgPicture.asset(
                                AppImages.icCancelReg,
                                height: 20,
                                width: 20
                            ) : GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.regularizeApplyRoute, arguments: [
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
                                ]);
                              },
                              child: SvgPicture.asset(
                                AppImages.svgAttendanceEdit,
                                height: 20,
                                width: 20,),
                            ),
                          ],),
                      )
                    ],
                  ),

                  controller.attendanceRegularizeDetails.value.data?.elementAt(index).mainStatus=="W" || controller.attendanceRegularizeDetails.value.data?.elementAt(index).mainStatus=="A" ? const SizedBox(height: 0)
                      : const SizedBox(height: 16.0),

                  /*Second Row*/
                  controller.attendanceRegularizeDetails.value.data?.elementAt(index).mainStatus=="W" || controller.attendanceRegularizeDetails.value.data?.elementAt(index).mainStatus=="A" ? Container()
                      : Row(
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
                                        controller.attendanceRegularizeDetails.value.data?.elementAt(index).shInTime?.trim() ?? "",
                                        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700,
                                            color:
                                            controller.attendanceRegularizeDetails.value.data!.elementAt(index).lateMinute! >
                                                controller.attendanceRegularizeDetails.value.data!.elementAt(index).lateTime! ? AppColors.colorD33017 : AppColors.color1C1F37
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
                                        controller.attendanceRegularizeDetails.value.data?.elementAt(index).shOutTime?.trim() ?? "",
                                        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700,
                                            color:
                                            controller.attendanceRegularizeDetails.value.data!.elementAt(index).lateMinute! >
                                                controller.attendanceRegularizeDetails.value.data!.elementAt(index).lateTime! ? AppColors.colorD33017 : AppColors.color1C1F37
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
    if(controller.attendanceRegularizeDetails.value.data!.elementAt(index).mainStatus=="A"){
      return AppImages.svgAbsentAttendance;
    }else if(controller.attendanceRegularizeDetails.value.data!.elementAt(index).mainStatus=="P"){
      return AppImages.svgPresentAttendance;
    }else if(controller.attendanceRegularizeDetails.value.data!.elementAt(index).mainStatus=="W"){
      return AppImages.svgWeekOffAttendance;
    }else if(controller.attendanceRegularizeDetails.value.data!.elementAt(index).mainStatus=="HO"){
      return AppImages.svgHolidayAttendance;
    }else if(controller.attendanceRegularizeDetails.value.data!.elementAt(index).mainStatus=="OD"){
      return AppImages.svgOdAttendance;
    }else{
      return AppImages.svgAbsentAttendance;
    }
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
                              AppSnackBar.showGetXCustomSnackBar(message: "Selected: ${controller.selectedYear.toString()}-${controller.selectedMonth.value}");
                              controller.callUserAttendanceRegularizationDetails();
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
              child: const Center(child: Text('Close',style: TextStyle(color: AppColors.color7B1FA2,fontWeight: FontWeight.w500,fontSize: 18),)),
            ),
          ],);
      },);
  }
}
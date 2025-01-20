import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/attendanceReg/userAttendanceRegularize/attendance_user_controller.dart';
import '../../../app/app_colors.dart';
import '../../../app/app_font_weight.dart';
import '../../../app/app_images.dart';
import '../../../app/app_routes.dart';
import '../../../utility/utils.dart';
import '../../../widget/common_app_bar.dart';
import '../../../widget/common_app_image.dart';
import '../../../widget/common_container.dart';
import '../../../widget/common_gradient_button.dart';
import '../../../widget/common_text.dart';

class UserAttendanceUi extends GetView<UserAttendanceController>{

  const UserAttendanceUi({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CommonAppBar(
          title: 'Attendance',
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

            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.9, // Adjust container width as needed
              decoration: BoxDecoration(
                gradient: AppColors.gradientBackground,
                // Assign default if null
                borderRadius: BorderRadius.circular(10),
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
                          const SizedBox(width: 14.0), // Spacer between image and text
                          // Column for Texts
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 45,
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  /*const SizedBox(height: 5.0),*/
                                  Obx(()=> CommonText(
                                      text: controller.userName.value,
                                      fontWeight: AppFontWeight.w500,
                                      fontSize: fontSize,
                                      color: Colors.white,
                                    ),
                                  ),
                                  /*const SizedBox(height: 5.0),*/
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

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
              width: MediaQuery.of(context).size.width * 0.9, // Adjust container width as needed
              child: _attendanceUi(context)
            ),
            /*const SizedBox(height: 16.0),*/
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
          margin: const EdgeInsets.all(10),
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
                                    "inTime1": controller.attendanceRegularizeDetails.value.data?.elementAt(index).status ?? "--:--",
                                    "outTime1": controller.attendanceRegularizeDetails.value.data?.elementAt(index).status2 ?? "--:--",
                                    "lateIn": controller.attendanceRegularizeDetails.value.data?.elementAt(index).earlyMinute ?? "--:--",
                                    "earlyOut": controller.attendanceRegularizeDetails.value.data?.elementAt(index).isLeaveApp ?? "--:--",
                                    "UiName": "AttendanceUserUi"
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

                  /*controller.attendanceRegularizeDetails.value.data?.elementAt(index).mainStatus=="W" || controller.attendanceRegularizeDetails.value.data?.elementAt(index).mainStatus=="A" ? const SizedBox(height: 0)
                      : const SizedBox(height: 16.0),*/
                  checkTime(index)==false ? const SizedBox(height: 0)
                      : const SizedBox(height: 16.0),

                  /*Second Row*/
                  /*controller.attendanceRegularizeDetails.value.data?.elementAt(index).mainStatus=="W" || controller.attendanceRegularizeDetails.value.data?.elementAt(index).mainStatus=="A" ? Container()*/
                  checkTime(index)==false ? Container() : Row(
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
                                        controller.attendanceRegularizeDetails.value.data?.elementAt(index).status?.trim() ?? "",
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
                                        controller.attendanceRegularizeDetails.value.data?.elementAt(index).status2?.trim() ?? "",
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
        /*SizedBox(height: MediaQuery.of(context).size.width * 0.03,),*/
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

  Widget _attendanceUi(BuildContext context) {
    final int currentMonth = DateTime.now().month;

    // Get the selected month or current month
    final String selectedMonth = controller.selectedMonthIndex.value == -1
        ? [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ][currentMonth - 1] // Convert month index to name
        : [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ][controller.selectedMonthIndex.value];

    return CommonGradientButton(
      text: '$selectedMonth ${controller.selectedYear.toString()} Attendance',
      imagePath: AppImages.leaveCalendarIcon, // Change the icon as needed
      onTap: () {
        controller.showYearDialog(context); // Define your on-tap behavior here
      },
    );
  }

  bool checkTime(int index) {
    if(controller.attendanceRegularizeDetails.value.data?.elementAt(index).status!=null || controller.attendanceRegularizeDetails.value.data?.elementAt(index).status2!=null){
      if(controller.attendanceRegularizeDetails.value.data?.elementAt(index).status!="" || controller.attendanceRegularizeDetails.value.data?.elementAt(index).status2!=""){
        return true;
      } else{
        return false;
      }
    } else {
      return false;
    }
  }
}
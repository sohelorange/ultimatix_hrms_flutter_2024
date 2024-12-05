import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ultimatix_hrms_flutter/screen/clockInOut/clock_in_out_controller.dart';
import '../../app/app_colors.dart';
import '../../app/app_font_weight.dart';
import '../../app/app_images.dart';
import '../../utility/utils.dart';
import '../../widget/common_app_image.dart';
import '../../widget/common_text.dart';

class ClockInOutUi extends GetView<ClockInOutController> {
  const ClockInOutUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.colorAppBars, AppColors.colorAppBars], // Gradient colors
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [0.8, 0.9], // Stops for the gradient colors
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
              child: Obx(
                    ()=> IgnorePointer(
                  ignoring: controller.isLoading.isTrue,
                  child: Stack(
                    children: [
                      Scaffold(
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
                            splashColor: AppColors.colorWhite,
                            onTap: () {
                              Get.back();
                            },
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
                              child: SvgPicture.asset(AppImages.icaarrowback,width: 12,height: 12,fit: BoxFit.contain,),
                            ),
                          ),
                          title: CommonText(
                            text: 'Clocking',
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: AppColors.colorBlueDark,
                          ),
                        ),
                        body: getClockInOutView(context),
                      ),
                      controller.isLoading.isTrue
                          ? ColoredBox(
                        color: AppColors.colorBlack.withOpacity(0.6),
                        child: Center(
                          child: Utils.commonCircularProgress(),
                        ),
                      ) : const Offstage(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getClockInOutView(BuildContext context) {
    return Obx(()=>
       Stack(
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
            height: Utils.getScreenHeight(context: context), // remove fixed height
            width: Utils.getScreenWidth(context: context),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.width * 0.3,
                      child: Card(
                        elevation: 0,
                        color: AppColors.colorLightPurple1,
                        shape: CircleBorder(
                          side: BorderSide(
                            color: AppColors.colorLightPurple2.withOpacity(0.4),
                            width: 2,
                          ),
                        ),
                        child: controller.selectedImage.value == null ? SvgPicture.asset(AppImages.svgCamera, fit: BoxFit.fill).paddingAll(37)
                          : CommonAppImage(
                          imagePath: controller.selectedImage.value!.path,
                          fit: BoxFit.fill,
                          isCircle: true,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  Center(
                    child: CommonText(
                      text: 'Select your working mode',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.colorBlueDark,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  getDropdownWidget(context),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  Card(
                    elevation: 4,
                    color: AppColors.colorLightPurple1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.zero,
                      child: CommonText(
                        text: controller.userLocAddress.value,
                        fontSize: 13,
                        maxLine: 3,
                        color: AppColors.colorBlueDark,
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        fontWeight: AppFontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  getWorkHourWidget(context),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  IconButton(
                    icon: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: !controller.isCheckIn.value ? SvgPicture.asset(AppImages.checkInBtnSvg) : SvgPicture.asset(AppImages.checkOutBtnSvg)
                    ),
                    onPressed: () {
                      controller.checkInOutEvent();
                    },
                    splashColor: AppColors.colorLightPurple2,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  getBottomWidgets(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ).marginOnly(top: 10),
        ],
      ),
    );
  }

  getDropdownWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      child: DropdownButton<String>(
        value: controller.defaultValue.value,
        hint: const Text('Select an option'),
        isExpanded: true,
        underline: const SizedBox(), // Remove the default underline
        items: controller.items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: CommonText(
              text: items,
              fontSize: 14,
              color: AppColors.color9C9BA2,
              fontWeight: AppFontWeight.w400,
              padding: const EdgeInsets.only(left: 10, right: 10),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          log("Clicked Button");
        },
      ),
    );
  }

  getWorkHourWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonText(
            text: 'Working Hours',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.color1C1F37,
          ),
          CommonText(
            text: "5 Hours",
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: AppColors.color631983,
          ),
          CommonText(
            text: "12-12-2024",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.color9C9BA2,
          ),
        ],
      ),
    );
  }

  getBottomWidgets(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.width * 0.16,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.colorLightPurple1,
            borderRadius: BorderRadius.circular(10),
          ),
          child:  Row(
            children: [
              SvgPicture.asset(height: 20, width: 20,AppImages.svgTime),
              const SizedBox(width: 10), // Space between icon and text
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CheckIn',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text( //removed obx
                      "1:00 PM",
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Container(
          width: MediaQuery.of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.width * 0.16,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.colorLightPurple1,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SvgPicture.asset(height: 20,
                  width: 20,AppImages.svgTime),
              const SizedBox(width: 10), // Space between icon and text
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CheckOut',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text( //removed obx
                      "12:30 PM",
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

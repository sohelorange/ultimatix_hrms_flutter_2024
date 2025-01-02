import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ultimatix_hrms_flutter/screen/clockInOut/clock_in_out_controller.dart';
import '../../app/app_colors.dart';
import '../../app/app_font_weight.dart';
import '../../app/app_images.dart';
import '../../utility/preference_utils.dart';
import '../../utility/utils.dart';
import '../../widget/common_app_image.dart';
import '../../widget/common_text.dart';
import '../dashboard/dash_board_controller.dart';

class ClockInOutUi extends GetView<ClockInOutController> {
  const ClockInOutUi({super.key});

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
              child: Obx(
                () => IgnorePointer(
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
                              DashController controller =
                                  Get.put(DashController());
                              controller.checkInOutStatus.value =
                                  PreferenceUtils.getIsClocking();
                              Get.back();
                            },
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 10, bottom: 10, right: 15),
                              child: SvgPicture.asset(
                                AppImages.icaarrowback,
                                width: 12,
                                height: 12,
                                fit: BoxFit.contain,
                              ),
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
                            )
                          : const Offstage(),
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
    return Obx(
      () => Stack(
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
            // remove fixed height
            width: Utils.getScreenWidth(context: context),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
                        child: controller.selectedImage.value == null
                            ? SvgPicture.asset(AppImages.svgCamera,
                                    fit: BoxFit.fill)
                                .paddingAll(37)
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
                      fontSize: FontSize.responsiveFontSize(context, 16),
                      fontWeight: FontWeight.w500,
                      color: AppColors.color1C1F37,
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
                        fontSize: FontSize.responsiveFontSize(context, 12),
                        maxLine: 3,
                        color: AppColors.color1C1F37,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
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
                        child: !controller.isCheckIn.value
                            ? SvgPicture.asset(AppImages.checkInBtnSvg)
                            : SvgPicture.asset(AppImages.checkOutBtnSvg)),
                    onPressed: () {
                      controller.imageCapture();
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
    return Obx(
      () => Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1.0, style: BorderStyle.solid, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        child: DropdownButton<String>(
          value: controller.defaultValue.value,
          hint: const Text('Select an option'),
          isExpanded: true,
          underline: const SizedBox(),
          // Remove the default underline
          items: controller.items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: CommonText(
                text: items,
                fontSize: FontSize.responsiveFontSize(context, 14),
                color: AppColors.color1C1F37,
                fontWeight: AppFontWeight.w400,
                padding: const EdgeInsets.only(left: 10, right: 10),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            controller.defaultValue.value = newValue!;
          },
        ),
      ),
    );
  }

  getWorkHourWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonText(
              text: 'Working Hours',
              fontSize: FontSize.responsiveFontSize(context, 14),
              fontWeight: FontWeight.w400,
              color: AppColors.color1C1F37,
            ),
            CommonText(
              text: controller.totalTime.value,
              fontSize: FontSize.responsiveFontSize(context, 40),
              fontWeight: FontWeight.w700,
              color: AppColors.color631983,
            ),
            CommonText(
              text: controller.nDate.value,
              fontSize: FontSize.responsiveFontSize(context, 14),
              fontWeight: FontWeight.w500,
              color: AppColors.color6B6D7A,
            ),
          ],
        ),
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
          child: Row(
            children: [
              SvgPicture.asset(height: 20, width: 20, AppImages.svgTime),
              const SizedBox(width: 10), // Space between icon and text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CheckIn',
                      style: TextStyle(
                          fontSize: FontSize.responsiveFontSize(context, 12),
                          color: AppColors.color6B6D7A,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      //removed obx
                      controller.checkInTime.value,
                      style: TextStyle(
                        fontSize: FontSize.responsiveFontSize(context, 12),
                        fontWeight: FontWeight.w700,
                        color: AppColors.color1C1F37,
                      ),
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
              SvgPicture.asset(height: 20, width: 20, AppImages.svgTime),
              const SizedBox(width: 10), // Space between icon and text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CheckOut',
                      style: TextStyle(
                          fontSize: FontSize.responsiveFontSize(context, 12),
                          color: AppColors.color6B6D7A,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      //removed obx
                      controller.checkOutTime.value,
                      style: TextStyle(
                          fontSize: FontSize.responsiveFontSize(context, 12),
                          color: AppColors.color1C1F37,
                          fontWeight: FontWeight.w700),
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

class FontSize {
  static double responsiveFontSize(BuildContext context, double fontSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    double baseWidth = 375.0; // Base screen width
    return fontSize * (screenWidth / baseWidth);
  }
}

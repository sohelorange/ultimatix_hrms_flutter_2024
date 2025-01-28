import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ultimatix_hrms_flutter/screen/clockInOut/clock_in_out_controller.dart';
import 'package:ultimatix_hrms_flutter/screen/dashboard/dash_board_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_bar_two.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_button_new.dart';
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
    return SafeArea(
      child: PopScope(
        canPop: true,
        onPopInvokedWithResult: (bool didPop, Object? result) {
          DashController controller = Get.put(DashController());
          controller.checkInOutStatus.value = PreferenceUtils.getIsClocking();
          return;
        },
        child: Scaffold(
          appBar: const CommonAppBarTwo(
            title: "Clocking",
          ),
          body: Obx(() => _buildClockInOutView(context)),
        ),
      ),
    );
  }

  Widget _buildClockInOutView(BuildContext context) {
    return Stack(
      children: [
        controller.isLoading.isTrue
            ? const Center(child: CircularProgressIndicator())
            : Container(
                width: Utils.getScreenWidth(context: context),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: _responsiveHeight(context, 0.04)),
                      Container(
                        width: _responsiveHeight(context, 0.9),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.colorLightPurple3,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: _responsiveHeight(context, 0.05)),
                            _buildProfileImage(context),
                            SizedBox(height: _responsiveHeight(context, 0.02)),
                            _buildDropdownWidget(context),
                            SizedBox(height: _responsiveHeight(context, 0.02)),
                            controller.defaultValue.value == 'Other'
                                ? _buildInputText(context)
                                : Container(),
                            _buildCardContainer(
                                context, controller.userLocAddress.value),
                            SizedBox(height: _responsiveHeight(context, 0.02)),
                            CommonButtonNew(
                                buttonText: controller.isCheckIn.value
                                    ? "Check Out"
                                    : "Check In",
                                onPressed: () {
                                  controller.checkWorkTypeValidation(context);
                                },
                                isLoading: false),
                          ],
                        ),
                      ),
                      SizedBox(height: _responsiveHeight(context, 0.02)),
                      _buildLastClockingContainer(context),
                      SizedBox(height: _responsiveHeight(context, 0.02)),
                      _getLastClockingLocation(context),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ).marginOnly(top: 2),
      ],
    );
  }

  double _responsiveHeight(BuildContext context, double factor) {
    return MediaQuery.of(context).size.width * factor;
  }

  Widget _buildProfileImage(BuildContext context) {
    return Center(
      child: SizedBox(
        width: _responsiveHeight(context, 0.3),
        height: _responsiveHeight(context, 0.3),
        child: Card(
          elevation: 0,
          color: AppColors.colorWhite,
          shape: const CircleBorder(
            side: BorderSide(
              color: AppColors.color303E9F,
              width: 2,
            ),
          ),
          child: controller.selectedImage.value == null
              ? SvgPicture.asset(AppImages.svgClockCamera, fit: BoxFit.fill)
                  .paddingAll(37)
              : CommonAppImage(
                  imagePath: controller.selectedImage.value!.path,
                  fit: BoxFit.fill,
                  isCircle: true,
                ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String text) {
    return Center(
      child: CommonText(
        text: text,
        fontSize: FontSize.responsiveFontSize(context, 16),
        fontWeight: FontWeight.w500,
        color: AppColors.color1C1F37,
      ),
    );
  }

  Widget _buildDropdownWidget(BuildContext context) {
    return Container(
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
      child: controller.items.isEmpty == true
          ? Container()
          : DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Row(
                  children: [
                    SvgPicture.asset(AppImages.svgClockNew),
                    const SizedBox(
                      width: 5,
                    ),
                    const Expanded(child: Text("Select Clocking Type",overflow: TextOverflow.ellipsis,))
                  ],
                ),
                items: controller.menuItems,
                dropdownStyleData: DropdownStyleData(
                    offset: const Offset(-20, 0),
                    maxHeight: 200,
                    width: MediaQuery.of(context).size.width * 0.82,
                    useSafeArea: true),
                iconStyleData: const IconStyleData(
                  openMenuIcon: Icon(Icons.arrow_drop_up),
                ),
                value: controller.defaultValue.value.isNotEmpty
                    ? controller.defaultValue.value
                    : null,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    controller.defaultValue.value = newValue;
                  }
                },
              ),
            ),
    );
  }

  Widget _buildCardContainer(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: AppColors.colorWhite),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        children: [
          SvgPicture.asset(AppImages.svgClockLocation),
          Expanded(
            flex: 1,
            child: CommonText(
              text: text,
              fontSize: FontSize.responsiveFontSize(context, 12),
              maxLine: 3,
              color: AppColors.color1C1F37,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              fontWeight: AppFontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkHourWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildCommonText(context, 'Working Hours', 14, AppFontWeight.w400),
          _buildCommonText(context, controller.totalTime.value, 40,
              AppFontWeight.w700, AppColors.color631983),
          _buildCommonText(context, controller.nDate.value, 14,
              AppFontWeight.w500, AppColors.color6B6D7A),
        ],
      ),
    );
  }

  Widget _buildCommonText(
      BuildContext context, String text, double fontSize, FontWeight fontWeight,
      [Color color = AppColors.color1C1F37]) {
    return CommonText(
      text: text,
      fontSize: FontSize.responsiveFontSize(context, fontSize),
      fontWeight: fontWeight,
      color: color,
    );
  }

  Widget _buildCheckInOutButton(BuildContext context) {
    return IconButton(
      icon: SizedBox(
        width: _responsiveHeight(context, 0.4),
        height: _responsiveHeight(context, 0.4),
        child: SvgPicture.asset(
          controller.isCheckIn.value
              ? AppImages.checkOutBtnSvg
              : AppImages.checkInBtnSvg,
        ),
      ),
      onPressed: () {
        controller.checkWorkTypeValidation(context);
      },
      splashColor: AppColors.colorLightPurple2,
    );
  }

  Widget _buildBottomWidgets(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTimeContainer(context, 'CheckIn', controller.checkInTime.value),
        const SizedBox(width: 20),
        _buildTimeContainer(context, 'CheckOut', controller.checkOutTime.value),
      ],
    );
  }

  Widget _buildTimeContainer(BuildContext context, String title, String time) {
    return Container(
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
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCommonText(context, title, 12, AppFontWeight.w400,
                    AppColors.color6B6D7A),
                const SizedBox(height: 4),
                _buildCommonText(context, time, 12, AppFontWeight.w700),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getLastClockingLocation(BuildContext context){
    return Container(
        padding: const EdgeInsets.all(16),
        height: _responsiveHeight(context, 0.3),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: AppColors.colorLightPurple3,
          borderRadius: BorderRadius.circular(10),
        ),
      child: _buildCardContainer(context, controller.userLocAddress.value),
    );
  }

  _buildLastClockingContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: _responsiveHeight(context, 0.3),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: AppColors.colorLightPurple3,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Last Clocking",style: TextStyle(color: AppColors.color6D24A1,fontSize: 16),),
          SizedBox(height: _responsiveHeight(context, 0.02)),
          Expanded(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Text("Mon, Jan 13,2025",style: TextStyle(color: AppColors.color2F2F31,fontWeight: FontWeight.w500,fontSize: 14),)),
          ),
        ],
      ),
    );
  }

  _buildInputText(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width > 600
              ? 500
              : MediaQuery.of(context).size.width - 32,
          padding: const EdgeInsets.only(left: 10, right: 15),
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 1.0, style: BorderStyle.solid, color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          child: TextField(
            controller: controller.textDescriptionController,
            decoration: InputDecoration(
              hintText: "Enter Reason",
              prefixIcon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    AppImages.svgClockInputReason,
                  )
              ),prefixIconConstraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
              hintStyle: const TextStyle(color: AppColors.color1C1F37),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.color6B6D7A
                        .withOpacity(0.12)), // Default grey underline
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.color6B6D7A
                        .withOpacity(0.12)), // Grey when enabled
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.color6B6D7A
                        .withOpacity(0.12)), // Blue when focused
              ),
            ),
          ),
        ),
        SizedBox(height: _responsiveHeight(context, 0.02)),
      ],
    );
  }
}

class FontSize {
  static double responsiveFontSize(BuildContext context, double fontSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    double baseWidth = 375.0;
    return fontSize * (screenWidth / baseWidth);
  }
}

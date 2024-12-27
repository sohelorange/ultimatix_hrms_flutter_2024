import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/attendanceReg/regularizeApplication/regularize_apply_controller.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_font_weight.dart';
import '../../../app/app_images.dart';
import '../../../utility/utils.dart';
import '../../../widget/common_text.dart';

class RegularizeApplyUi extends GetView<RegularizeApplyController> {
  const RegularizeApplyUi({super.key});

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
          text: 'Regularize Request',
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
                                                'Shift',
                                                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w400,color: AppColors.color6B6D7A),
                                              ),
                                              Obx(
                                                    ()=> Text(
                                                  controller.shiftTime.value.trim(),
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
                                        SvgPicture.asset(AppImages.svgPresent),// Location Icon
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Present Day',
                                                style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.w400,color: AppColors.color6B6D7A),
                                              ),
                                              Obx(
                                                    ()=> Text(
                                                  controller.presentDay.value,
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
                                                controller.inTime.toString().trim(),
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
                                                  controller.outTime.toString().trim(),
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
                                        SvgPicture.asset(AppImages.svgLateIn),// Clock Icon
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Late In',
                                                style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.w400,color: AppColors.color6B6D7A),
                                              ),
                                              Text(
                                                controller.lateIn.toString().trim(),
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
                                        SvgPicture.asset(AppImages.svgEarlyOut),// Location Icon
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Early Out',
                                                style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.w400,color: AppColors.color6B6D7A),
                                              ),
                                              Text(
                                                controller.earlyOut.toString().trim(),
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
                          ],
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16.0),
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
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.displayTimePicker("inTime");
                                    },
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
                                                Obx(()=> Text(
                                                    controller.inTime2.value,
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
                                ),
                                const SizedBox(width: 16.0), // Spacer between the two boxes
                                // Box 2
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.displayTimePicker("outTime");
                                    },
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
                                                Obx(()=> Text(
                                                    controller.outTime2.value,
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
                                ),
                              ],
                            ),
                            const SizedBox(height: 5.0),

                            SizedBox(
                              width: width > 600 ? 500 : width - 32,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                Container(
                                  width: width > 600 ? 500 : width - 32,
                                  padding: const EdgeInsets.only(left: 15,right: 15),
                                  child: Obx(()=> DropdownButtonFormField<String>(
                                      value: controller.responseReason.value.data?.elementAt(controller.selectedReasonIndex.value).reasonName, // This can be null initially
                                      hint: const Text(
                                        'Reason',
                                        style: TextStyle(color: AppColors.color1C1F37),
                                      ),
                                      icon: const Icon(Icons.arrow_drop_down),
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: AppColors.color6B6D7A.withValues(alpha: 0.12)), // Default underline color
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: AppColors.color6B6D7A.withValues(alpha: 0.12)), // Color when focused
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: AppColors.color6B6D7A.withValues(alpha: 0.12)), // Color when enabled
                                        ),
                                      ),
                                      onChanged: (String? newValue) {
                                        if(newValue!=null){
                                          for(int i=0;i<controller.responseReason.value.data!.length;i++){
                                            if(newValue==controller.responseReason.value.data!.elementAt(i).reasonName){
                                              controller.selectedReasonIndex.value=i;
                                            }
                                          }
                                        }
                                      },
                                      items: controller.responseReason.value.data?.map((element) {
                                        return DropdownMenuItem(value: element.reasonName,child: Text(element.reasonName.toString()));
                                      },).toList(),
                                      menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 5.0),

                                Container(
                                  width: width > 600 ? 500 : width - 32,
                                  padding: const EdgeInsets.only(left: 15,right: 15),
                                  child: TextField(
                                    controller: controller.textDescriptionController,
                                    decoration: InputDecoration(
                                      hintText: "Description",
                                      hintStyle: const TextStyle(color: AppColors.color1C1F37),
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

                                const SizedBox(height: 5.0),

                                Container(
                                  width: width > 600 ? 500 : width - 32,
                                  padding: const EdgeInsets.only(left: 15,right: 15),
                                  child: DropdownButtonFormField<String>(
                                    value: controller.listOfType.elementAt(controller.selectedTypeIndex.value), // This can be null initially
                                    hint: const Text(
                                      'Type',
                                      style: TextStyle(color: AppColors.color1C1F37),
                                    ),
                                    icon: const Icon(Icons.arrow_drop_down),
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(color: AppColors.color6B6D7A.withValues(alpha: 0.12)), // Default underline color
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: AppColors.color6B6D7A.withValues(alpha: 0.12)), // Color when focused
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: AppColors.color6B6D7A.withValues(alpha: 0.12)), // Color when enabled
                                      ),
                                    ),
                                    onChanged: (String? value) {
                                      if(value!=null){
                                        for(int i=0;i<controller.listOfType.length;i++){
                                          if(value==controller.listOfType.elementAt(i)){
                                            controller.selectedTypeIndex.value=i;
                                          }
                                        }
                                      }
                                    },
                                    items: controller.listOfType.map((element) {
                                      return DropdownMenuItem(value: element,child: Text(element));
                                    },).toList(),
                                  ),
                                ),


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

                                  Row(
                                    children: [
                                      Obx(()=> Checkbox(
                                          checkColor: Colors.white,
                                          activeColor: AppColors.purpleSwatch,
                                          value: controller.isCancelEarlyOut.value,
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

                          ],))]
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
                              controller.checkValidation();
                            },
                            child: CommonText(
                              text: "Submit",
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
                            text: 'Cancel',
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
}

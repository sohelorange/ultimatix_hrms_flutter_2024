import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_strings.dart';
import 'package:ultimatix_hrms_flutter/screen/location_permission/location_perm_controller.dart';
import '../../app/app_colors.dart';
import '../../app/app_images.dart';
import '../../widget/new/common_button_new.dart';

class LocationPermUi extends GetView<LocationPermController> {
  const LocationPermUi({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: SvgPicture.asset(
                            AppImages.svgLocateMe,
                            height: 200,
                            width: 200,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25,),
                      Center(child: Text(AppString.useLoc1,style: TextStyle(color: AppColors.color2F2F31,fontWeight: FontWeight.w700,fontSize: screenWidth*0.06),textAlign: TextAlign.center,),),
                      const SizedBox(height: 15,),
                      Center(child: Text(AppString.useLoc2,style: TextStyle(color: AppColors.color2F2F31,fontWeight: FontWeight.w400,fontSize: screenWidth * 0.042),textAlign: TextAlign.center),),
                      const SizedBox(height: 10,),
                      Center(child: Text(AppString.useLoc3,style: TextStyle(color: AppColors.color2F2F31,fontWeight: FontWeight.w400,fontSize: screenWidth * 0.042),textAlign: TextAlign.center),),
                      //Center(child: CommonText(text: AppString.useLoc1,fontSize: 24,textAlign: TextAlign.center,fontWeight: FontWeight.w700,color: AppColors.color2F2F31,)),
                      //Center(child: CommonText(text: AppString.useLoc2,color: AppColors.color2F2F31)),
                      //Center(child: CommonText(text: AppString.useLoc3,color: AppColors.color2F2F31)),
                    ],
                  ),
                ),
              ),
              CommonButtonNew(
                buttonText: 'Allow',
                onPressed: () {
                  controller.checkGpsEnabled();
                },
                isLoading: false,
              ).paddingOnly(top: 20),
              const SizedBox(height: 10,),
              GestureDetector(onTap: () {
                SystemNavigator.pop();
              }, child: const Text("Deny",style: TextStyle(color: AppColors.color7B1FA2),))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/app/app_strings.dart';
import 'package:ultimatix_hrms_flutter/screen/geofence/geofence_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_bar_new.dart';

import '../../app/app_images.dart';
import '../../widget/common_app_image.dart';
import '../../widget/new/common_button_new.dart';

class GeofenceView extends GetView<GeofenceController> {
  const GeofenceView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CommonNewAppBar(
        title: "Geofence",
        leadingIconSvg: AppImages.icBack,
        trailingWidgets: [
          GestureDetector(
            onTap: () {
              controller.getCurrentLocation();
            },
            child: const CommonAppImage(
              imagePath: AppImages.dashRefreshIcon,
              color: AppColors.colorWhite,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Obx(() => getGeofenceView(context)),
      ),
    ));
  }

  getGeofenceView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            //height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.colorF1EBFB,
            ),
            child: Container(
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                // Same rounded corners for clipping
                child: GoogleMap(
                  onMapCreated: controller.onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: controller.currentPosition.value,
                    zoom: 17.0,
                  ),
                  markers: Set<Marker>.of(controller.marker),
                  circles: Set<Circle>.from(controller.circles),
                  myLocationEnabled: true,
                ),
              ),
            ),
          ),
          controller.isLoading.isTrue
              ? Center(child: Utils.commonCircularProgress())
                  .paddingOnly(top: 50)
              : Column(
                  children: [
                    Container(
                      width: double.infinity,
                      //height: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.colorF1EBFB,
                      ),
                      child: Container(
                        height: 70,
                        //margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipOval(
                                //borderRadius: BorderRadius.circular(10),
                                child: controller.userImageUrl.value.isEmpty
                                    ? const CommonAppImageSvg(
                                        imagePath: AppImages
                                            .svgAvatar, // Default SVG image
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit
                                            .cover, // Ensures the image fills the space
                                      )
                                    : CommonAppImageSvg(
                                        imagePath:
                                            controller.userImageUrl.value,
                                        // Use profile image URL
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit
                                            .cover, // Ensures the image fills the space
                                      ),
                              ),
                            ),
                            Visibility(
                              visible: false,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: controller.userImageUrl.value.isEmpty
                                    ? const CommonAppImageSvg(
                                        imagePath: AppImages
                                            .svgAvatar, // Default SVG image
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit
                                            .cover, // Ensures the image fills the space
                                      )
                                    : CommonAppImageSvg(
                                        imagePath:
                                            controller.userImageUrl.value,
                                        // Use profile image URL
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit
                                            .cover, // Ensures the image fills the space
                                      ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CommonText(
                              text: controller.isWithinRadius.value
                                  ? 'Entered: ${controller.geoFenceModel.value.data != null ? controller.geoFenceModel.value.data![0].geoLocation : 'No data Available'}'
                                  : 'You are Outside of Geofence',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.color2F2F31,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      // visible: controller.distance < 100 ,
                      visible: controller.isWithinRadius.value,
                      child: Column(
                        children: [
                          CommonButtonNew(
                                  buttonText: 'Ok',
                                  onPressed: () {
                                    Get.toNamed(AppRoutes.clockInRoute);
                                  },
                                  isLoading: false)
                              .paddingOnly(top: 20),
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: CommonText(
                              text: AppString.cancel,
                              color: AppColors.colorPurple,
                              fontSize: 16,
                              fontWeight: AppFontWeight.w400,
                            ).paddingOnly(top: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ).paddingOnly(top: 15),
        ],
      ),
    );
  }
}

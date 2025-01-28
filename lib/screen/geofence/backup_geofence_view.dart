import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/app/app_strings.dart';
import 'package:ultimatix_hrms_flutter/screen/geofence/geofence_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_bar.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';
import 'package:ultimatix_hrms_flutter/widget/common_button.dart';
import 'package:ultimatix_hrms_flutter/widget/common_container.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

import '../../app/app_images.dart';
import '../../widget/common_app_image.dart';

class BackupGeofenceView extends GetView<GeofenceController> {
  const BackupGeofenceView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CommonAppBar(
        title: 'Geofence',
        actions: [
          GestureDetector(
            onTap: () {
              controller.getCurrentLocation();
            },
            child: const CommonAppImage(
              imagePath: AppImages.dashRefreshIcon,
              color: AppColors.colorDarkBlue,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: CommonContainer(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Obx(() => getGeofenceView(context)),
        ),
      ),
    ));
  }

  getGeofenceView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Shadow color
                  spreadRadius: 2, // Spread radius
                  blurRadius: 8, // Blur radius
                  offset: const Offset(0, 4), // Shadow position
                ),
              ],
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
          controller.isLoading.isTrue
              ? Center(child: Utils.commonCircularProgress())
                  .paddingOnly(top: 50)
              : Column(
                  children: [
                    Container(
                      height: 70,
                      //margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0X1C1F370D),
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // Adjust radius
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: const Offset(0, 0), // Shadow position
                                ),
                              ],
                            ),
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
                                      imagePath: controller.userImageUrl.value,
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
                                      imagePath: controller.userImageUrl.value,
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
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColors.colorDarkBlue,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      // visible: controller.distance < 100 ,
                      visible: controller.isWithinRadius.value,
                      child: Column(
                        children: [
                          CommonButton(
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
                ).paddingOnly(top: 20),
        ],
      ),
    );
  }
}

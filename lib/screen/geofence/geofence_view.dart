import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/app/app_strings.dart';
import 'package:ultimatix_hrms_flutter/screen/geofence/geofence_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

import '../../app/app_images.dart';
import '../../widget/common_app_image.dart';

class GeofenceView extends GetView<GeofenceController> {
  const GeofenceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Container(
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
                child: controller.isLoading.isTrue
                    ? SizedBox(
                    height: Utils.getScreenHeight(context: context) / 3.25,
                    child: Center(child: Utils.commonCircularProgress()))
                    : Scaffold(
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
                        Get.back();
                      },
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 15, top: 10, bottom: 10, right: 15),
                        child: CommonAppImage(
                          imagePath: AppImages.icarrowback,
                          height: 10,
                          width: 10,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    title: CommonText(
                      text: 'GeoFence',
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: AppColors.colorBlack,
                    ),
                    actions: [
                      InkWell(
                        splashColor: AppColors.colorBlack,
                        onTap: () {
                          controller.getCurrentLocation();
                        },
                        radius: 10,
                        borderRadius: BorderRadius.circular(30),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: CommonAppImage(
                            height: 20,
                            width: 20,
                            imagePath: AppImages.dashRefreshIcon,
                            color: AppColors.colorBlack,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                    // bottom: tabBarView(),
                  ),
                  body: getGeofenceView(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getGeofenceView(BuildContext context) {
    return Stack(
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
            width: Utils.getScreenWidth(context: context),
            decoration: const BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      height: 500,
                      decoration: const BoxDecoration(
                          color: AppColors.colorWhite,
                          borderRadius: BorderRadius.all(Radius.circular(25.0))),
                      child: GoogleMap(
                        onMapCreated: controller.onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: controller.currentPosition.value,
                          zoom: 17.0,
                        ),
                        // markers: Set<Marker>.of(controller.marker),
                        markers: Set<Marker>.of(controller.marker),
                        circles: Set<Circle>.from(controller.circles),
                        myLocationEnabled: true,
                        // myLocationButtonEnabled: true,
                      )).paddingOnly(left: 20, right: 20, top: 20),
                  Container(
                    height: 80,
                    child: Card(
                        elevation: 4,
                        color: AppColors.colorWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonAppImage(
                                  imagePath:controller.userImageUrl.value.isEmpty?
                                  AppImages.icavtar :
                                  controller.userImageUrl.value,
                                  height: 40,
                                  width: 40,
                                ).paddingOnly(left: 10, right: 10, top: 5),

                                CommonText(
                                  text: controller.isWithinRadius.value ?'Entered: ${controller.geolocationrecordmodel.value.data![0].geoLocation}':
                                  'You are Outside of Geofence',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: AppColors.colorBlack,
                                ).paddingOnly(left: 10, top: 10),
                              ],
                            )
                          ],
                        )).paddingOnly(top: 20),
                  ).paddingOnly(left: 20, right: 20),
                  Visibility(
                    // visible: controller.distance < 100 ,
                    visible:  controller.isWithinRadius.value ,
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 8,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateColor.resolveWith(
                                      (states) => AppColors.colorPurple,
                                ),
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ))),
                            onPressed: () {
                              Get.toNamed(AppRoutes.clockInRoute);
                            },
                            child: CommonText(
                              text: AppString.ok,
                              color: AppColors.colorWhite,
                              fontSize: 16,
                              fontWeight: AppFontWeight.w400,
                            ),
                          ),
                        ).paddingOnly(left: 30, right: 30, top: 20),
                        GestureDetector(
                          onTap: () {
                          },
                          child: CommonText(
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 12, left: 12),
                            text: AppString.cancel,
                            color: AppColors.colorPurple,
                            fontSize: 16,
                            fontWeight: AppFontWeight.regular,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
        ).marginOnly(top: 10),
      ],
    );
  }
}

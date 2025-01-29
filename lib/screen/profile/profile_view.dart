import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/screen/dashboard/drawer/drawer_dash_controller.dart';
import 'package:ultimatix_hrms_flutter/screen/profile/profile_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/constants.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';
import 'package:ultimatix_hrms_flutter/widget/common_list_row.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_bar_new.dart';

import '../../app/app_colors.dart';
import '../../app/app_images.dart';
import '../../widget/common_app_bar.dart';
import '../../widget/common_container.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        DrawerDashController controller = Get.put(DrawerDashController());
        controller.profileValueNotifier.value =
            PreferenceUtils.getProfileImage();
        return;
      },
      child: Scaffold(
        appBar: const CommonNewAppBar(
          title: "Profile",
          leadingIconSvg: AppImages.icBack, // Menu icon
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Obx(() => controller.isLoading.isTrue
              ? Center(child: Utils.commonCircularProgress())
              : controller.profilePersonalModelResponse.value.data != null
                  ? _getProfileView(context)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonAppImageSvg(
                            imagePath: AppImages.svgNoData,
                            height: 100,
                            width: MediaQuery.sizeOf(context).width),
                        const SizedBox(
                          height: 20,
                        ),
                        CommonText(
                          text: controller.profilePersonalModelResponse.value
                                      .message !=
                                  null
                              ? controller
                                  .profilePersonalModelResponse.value.message!
                              : 'Something Went Wrong',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppColors.colorDarkBlue,
                        ),
                      ],
                    )),
        ),
      ),
    ));
  }

  _getProfileView(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _headerDetailsInfo(context),
        _personalInformation().paddingOnly(top: 10),
        _bankInformation(),
        _favouriteInformation(),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.color7A1FA2,
                AppColors.color303E9F,
              ],
              stops: [0.05, 0.55],
              tileMode: TileMode.mirror,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                textAlign: TextAlign.center,
                text: 'Add Family Details',
                color: AppColors.colorWhite,
                fontSize: 16,
                fontWeight: AppFontWeight.w500,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.familyAddRoute);
                },
                child: const CommonAppImageSvg(
                  imagePath: AppImages.profileAddIcon,
                  height: 14,
                  width: 8,
                  color: AppColors.colorWhite,
                  fit: BoxFit.cover, // Ensures the image fills the space
                ),
              ),
            ],
          ),
        ).paddingOnly(top: 10),
        _familyInformation(),
        _assetInformation().paddingOnly(bottom: 10)
      ],
    ));
  }

  Widget _headerDetailsInfo(BuildContext context) {
    return Container(
      width: double.infinity,
      //height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.colorF1EBFB,
      ),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.colorWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.getOpenGalleryView(context);
                  },
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: ClipOval(
                      child: Obx(() {
                        if (controller.userImageUrl.value.isNotEmpty) {
                          // Show the camera-uploaded image
                          if (controller.userImageUrl.value.startsWith('/')) {
                            // Local file path
                            return Image.file(
                              File(controller.userImageUrl.value),
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            );
                          } else {
                            // Network image
                            return Image.network(
                              controller.userImageUrl.value,
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                // Fallback to placeholder if the network image fails
                                return const CommonAppImageSvg(
                                  imagePath: AppImages.svgAvatar,
                                  // Default placeholder SVG image
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                );
                              },
                            );
                          }
                        } else {
                          // Show the placeholder if no image is set
                          return const CommonAppImageSvg(
                            imagePath: AppImages.svgAvatar,
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          );
                        }
                      }),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CommonText(
                    textAlign: TextAlign.start,
                    text:
                        "${controller.profilePersonalModelResponse.value.data!.employeeDetails!.empCode!} - ${controller.profilePersonalModelResponse.value.data!.employeeDetails!.empFullName!}${controller.profilePersonalModelResponse.value.data!.employeeDetails!.grdName!}",
                    color: AppColors.color2F2F31,
                    fontSize: 16,
                    fontWeight: AppFontWeight.w500,
                  ),
                ),
              ],
            ),
            CommonText(
              text: 'Designation',
              color: AppColors.color2F2F31,
              fontSize: 14,
              fontWeight: AppFontWeight.w500,
            ).paddingOnly(top: 15),
            CommonText(
              text:
                  "${controller.profilePersonalModelResponse.value.data!.employeeDetails!.desigName!} (${controller.profilePersonalModelResponse.value.data!.employeeDetails!.deptName!})",
              color: AppColors.color7B758E,
              fontSize: 14,
              fontWeight: AppFontWeight.w400,
            ),
            CommonText(
              text: 'Reporting Manager',
              color: AppColors.color2F2F31,
              fontSize: 14,
              fontWeight: AppFontWeight.w500,
            ).paddingOnly(top: 10),
            CommonText(
              text: controller.profilePersonalModelResponse.value.data!
                  .employeeDetails!.empFullNameSuperior!,
              color: AppColors.color7B758E,
              fontSize: 14,
              fontWeight: AppFontWeight.w400,
            ),
            CommonText(
              text: 'Email ID',
              color: AppColors.color2F2F31,
              fontSize: 14,
              fontWeight: AppFontWeight.w500,
            ).paddingOnly(top: 10),
            CommonText(
              text: controller.profilePersonalModelResponse.value.data!
                  .employeeDetails!.workEmail!,
              color: AppColors.color7B758E,
              fontSize: 14,
              fontWeight: AppFontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _personalInformation() {
    return Container(
      width: double.infinity,
      //height: 100,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.colorF1EBFB,
      ),
      child: Container(
          //padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.colorWhite,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: 'Personal Information',
                color: AppColors.color2F2F31,
                fontSize: 16,
                fontWeight: AppFontWeight.w500,
              ).paddingOnly(left: 15, right: 10, top: 10, bottom: 10),
              _employeeDetails(
                      AppImages.profileDOJIcon,
                      'Date Of Joining',
                      controller.profilePersonalModelResponse.value.data!
                              .employeeDetails!.dateOfJoin ??
                          '')
                  .paddingOnly(left: 15, right: 15, top: 0),
              _employeeDetails(
                      AppImages.profileBloodGroupIcon,
                      'Blood Group',
                      controller.profilePersonalModelResponse.value.data!
                              .employeeDetails!.bloodGroup ??
                          '')
                  .paddingOnly(left: 15, right: 15, top: 10),
              // _employeeDetails(
              //         AppImages.leaveCalendarIcon,
              //         'Guardian Name',
              //         controller.profilePersonalModelResponse.value.data!.employeeDetails!
              //                 .grdName ??
              //             '')
              //     .paddingOnly(left: 10, right: 10, top: 10),
              _employeeDetails(
                      AppImages.profileUANIcon,
                      'UAN Number',
                      controller.maskNumber(controller
                              .profilePersonalModelResponse
                              .value
                              .data!
                              .employeeDetails!
                              .uaNNo ??
                          ''))
                  .paddingOnly(left: 15, right: 15, top: 10),
              _employeeDetails(
                      AppImages.profileAadharCardNoIcon,
                      'Aadhar Card Number',
                      controller.maskNumber(controller
                              .profilePersonalModelResponse
                              .value
                              .data!
                              .employeeDetails!
                              .aadharCardNo ??
                          ''))
                  .paddingOnly(left: 15, right: 15, top: 10),
              _employeeDetails(
                      AppImages.profilePanNoIcon,
                      'PAN Number',
                      controller.maskNumber(controller
                              .profilePersonalModelResponse
                              .value
                              .data!
                              .employeeDetails!
                              .panNo ??
                          ''))
                  .paddingOnly(left: 15, right: 15, top: 10),
              _employeeDetails(
                      AppImages.profileUANIcon,
                      'Contact No',
                      controller.profilePersonalModelResponse.value.data!
                              .employeeDetails!.mobileNo ??
                          '')
                  .paddingOnly(left: 15, right: 15, top: 10),
              // _employeeDetails(
              //         AppImages.profileCompanyEmailIcon,
              //         'Email Id',
              //         controller.profilePersonalModelResponse.value.data!
              //                 .employeeDetails!.workEmail ??
              //             '')
              //     .paddingOnly(left: 15, right: 15, top: 10),
              _employeeDetails(
                      AppImages.profilePersonEmailIcon,
                      'Person Email',
                      controller
                              .profilePersonalModelResponse
                              .value
                              .data!
                              .employeeDetails!
                              //.otherEmail ??
                              .froMEMAIL ??
                          '')
                  .paddingOnly(left: 15, right: 15, top: 10),
              _employeeDetails(AppImages.profileAddressIcon, 'Address',
                      '${controller.profilePersonalModelResponse.value.data!.employeeDetails!.street1 ?? ''},${controller.profilePersonalModelResponse.value.data!.employeeDetails!.city ?? ''},${controller.profilePersonalModelResponse.value.data!.employeeDetails!.state ?? ''},${controller.profilePersonalModelResponse.value.data!.employeeDetails!.zipCode ?? '' '.'}')
                  .paddingOnly(left: 15, right: 15, top: 10, bottom: 10)
            ],
          )).paddingOnly(top: 10),
    );
  }

  Widget _bankInformation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.colorF1EBFB,
      ),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.colorWhite,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: 'Bank Information',
                color: AppColors.color2F2F31,
                fontSize: 16,
                fontWeight: AppFontWeight.w500,
              ).paddingOnly(left: 15, right: 10, top: 10, bottom: 10),
              _employeeDetails(
                      AppImages.profileBankNameIcon,
                      'Bank Name',
                      controller.profilePersonalModelResponse.value.data!
                              .employeeDetails!.bankName ??
                          '')
                  .paddingOnly(left: 15, right: 15, top: 0),
              _employeeDetails(
                      AppImages.profileBankBranchNameIcon,
                      'Bank Branch Name',
                      controller.profilePersonalModelResponse.value.data!
                              .employeeDetails!.bankBranchName ??
                          '')
                  .paddingOnly(left: 15, right: 15, top: 10),
              _employeeDetails(
                AppImages.profileACNoIcon,
                'Account Number',
                controller.maskNumber(controller.profilePersonalModelResponse
                        .value.data!.employeeDetails!.incBankACNo ??
                    ''),
              ).paddingOnly(left: 15, right: 15, top: 10),
              _employeeDetails(
                      AppImages.profileIFSCCodeIcon,
                      'IFSC Code',
                      controller.profilePersonalModelResponse.value.data!
                              .employeeDetails!.ifscCode ??
                          '')
                  .paddingOnly(left: 15, right: 15, top: 10, bottom: 10),
            ],
          )).paddingOnly(top: 10),
    ).paddingOnly(top: 10);
  }

  Widget _favouriteInformation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.colorF1EBFB,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.colorWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: 'Favourite Information',
              color: AppColors.color2F2F31,
              fontSize: 16,
              fontWeight: AppFontWeight.w500,
            ).paddingOnly(left: 15, right: 10, top: 10, bottom: 10),
            _employeeDetails(
                    AppImages.profileFavSportIcon,
                    'Favourite Sport',
                    controller.profileFavoriteModelResponse.value.data![0]
                            .empFavSportName ??
                        '')
                .paddingOnly(left: 15, right: 15, top: 0),
            _employeeDetails(
                    AppImages.profileFavHobbyIcon,
                    'Hobby',
                    controller.profileFavoriteModelResponse.value.data![0]
                            .empHobbyName ??
                        '')
                .paddingOnly(left: 15, right: 15, top: 10),
            _employeeDetails(
                    AppImages.profileFavFoodIcon,
                    'Favourite Food',
                    controller.profileFavoriteModelResponse.value.data![0]
                            .empFavFood ??
                        '')
                .paddingOnly(left: 15, right: 15, top: 10),
            _employeeDetails(
                    AppImages.profileFavRestIcon,
                    'Favourite Restaurant',
                    controller.profileFavoriteModelResponse.value.data![0]
                            .empFavRestro ??
                        '')
                .paddingOnly(left: 15, right: 15, top: 10),
            _employeeDetails(
                    AppImages.profileFavTravelIcon,
                    'Favourite Travel Destination',
                    controller.profileFavoriteModelResponse.value.data![0]
                            .empFavTrvDestination ??
                        '')
                .paddingOnly(left: 15, right: 15, top: 10),
            _employeeDetails(
                    AppImages.profileFavFestivalIcon,
                    'Favourite Festival',
                    controller.profileFavoriteModelResponse.value.data![0]
                            .empFavFestival ??
                        '')
                .paddingOnly(left: 15, right: 15, top: 10),
            _employeeDetails(
                    AppImages.profileFavSportsPersonIcon,
                    'Favourite Sport Person',
                    controller.profileFavoriteModelResponse.value.data![0]
                            .empFavSportPerson ??
                        '')
                .paddingOnly(left: 15, right: 15, top: 10),
            _employeeDetails(
                    AppImages.profileFavSingerIcon,
                    'Favourite Singer',
                    controller.profileFavoriteModelResponse.value.data![0]
                            .empFavSinger ??
                        '')
                .paddingOnly(left: 15, right: 15, top: 10, bottom: 10),
          ],
        ),
      ).paddingOnly(top: 10),
    ).paddingOnly(top: 10);
  }

  Widget _familyInformation1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              text: 'Family Information',
              color: AppColors.colorBlack,
              fontSize: 16,
              fontWeight: AppFontWeight.w500,
            ),
            IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.familyAddRoute);
              },
              highlightColor: Colors.transparent,
              icon: const Icon(
                //size: 20,
                Icons.add,
                color: AppColors.colorBlack,
              ),
            )
          ],
        ),
        Container(
            //height: Utils.getScreenHeight(context: context) / 2.5,
            margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: controller.profileFamilyModelResponse.value.data != null &&
                      controller
                          .profileFamilyModelResponse.value.data!.isNotEmpty
                  ? DataTable(
                      columns: const [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Relationship')),
                        DataColumn(label: Text('Dependent')),
                        DataColumn(label: Text('View')),
                        // DataColumn(label: Text('Edit')),
                        // DataColumn(label: Text('Delete')),
                      ],
                      rows: controller.profileFamilyModelResponse.value.data!
                          .map((person) {
                        return DataRow(cells: [
                          DataCell(Text(person.name ?? '')),
                          DataCell(Text(person.relationship ?? '')),
                          DataCell(
                              Text(person.isDependant == true ? 'Yes' : 'No')),
                          DataCell(
                            IconButton(
                              icon: const Icon(Icons.visibility),
                              onPressed: () {
                                Get.toNamed(
                                  AppRoutes.familyViewRoute,
                                  arguments: {
                                    'familyDetails': person,
                                  },
                                );
                              },
                              highlightColor: Colors.transparent,
                            ),
                          ),
                          // DataCell(
                          //   IconButton(
                          //     icon: const Icon(Icons.edit),
                          //     onPressed: () {
                          //       Get.toNamed(
                          //         AppRoutes.familyEditRoute,
                          //         arguments: {
                          //           'familyDetails': person,
                          //         },
                          //       );
                          //     },
                          //     highlightColor: Colors.transparent,
                          //   ),
                          // ),
                          // DataCell(
                          //   IconButton(
                          //     icon: const Icon(
                          //       Icons.delete,
                          //       color: AppColors.colorRed,
                          //     ),
                          //     onPressed: () {
                          //       controller.deleteFamilyInformation(
                          //           person.rowID.toString());
                          //     },
                          //     highlightColor: Colors.transparent,
                          //   ),
                          // ),
                        ]);
                      }).toList(),
                    )
                  : SizedBox(
                      height:
                          Utils.getScreenHeight(context: Get.context!) / 7.5,
                      width: Utils.getScreenWidth(context: Get.context!),
                      child: Center(
                        child: CommonText(
                          text: Constants.noDataMsg,
                          color: AppColors.colorDarkBlue,
                          fontSize: 14,
                          fontWeight: AppFontWeight.w400,
                        ),
                      ),
                    ),
            )),
      ],
    );
  }

  Widget _familyInformation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.colorF1EBFB,
      ),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.colorWhite,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: 'Family Details',
                color: AppColors.color2F2F31,
                fontSize: 16,
                fontWeight: AppFontWeight.w500,
              ).paddingOnly(left: 15, right: 10, top: 10, bottom: 10),
              const Divider(
                height: 0.5,
                color: AppColors.colorDCDCDC,
              ).paddingOnly(bottom: 10),
              controller.profileFamilyModelResponse.value.data != null &&
                      controller
                          .profileFamilyModelResponse.value.data!.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller
                          .profileFamilyModelResponse.value.data!.length,
                      itemBuilder: (context, index) {
                        final person = controller
                            .profileFamilyModelResponse.value.data![index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.colorWhite,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _assetDetails(
                                            'Name', person.name.toString())
                                        .paddingOnly(
                                            left: 15, right: 15, top: 0),
                                  ),
                                  Visibility(
                                    visible: false,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                          AppRoutes.familyEditRoute,
                                          arguments: {
                                            'familyDetails': person,
                                          },
                                        );
                                      },
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color: AppColors.color7A1FA2,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.edit,
                                            size: 15,
                                            color: AppColors.colorWhite,
                                          ),
                                        ),
                                      ).paddingOnly(right: 10),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        AppRoutes.familyViewRoute,
                                        arguments: {
                                          'familyDetails': person,
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        color: AppColors.color7A1FA2,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.visibility,
                                          size: 15,
                                          color: AppColors.colorWhite,
                                        ),
                                        // child: CommonAppImageSvg(
                                        //   imagePath: AppImages.profileViewIcon,
                                        //   height: 10,
                                        //   width: 10,
                                        //   color: AppColors.colorWhite,
                                        // ),
                                      ),
                                    ).paddingOnly(right: 10),
                                  ),
                                  Visibility(
                                    visible: false,
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.deleteFamilyInformation(
                                            person.rowID.toString());
                                      },
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color: AppColors.color7A1FA2,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.delete,
                                            size: 15,
                                            color: AppColors.colorWhite,
                                          ),
                                        ),
                                      ).paddingOnly(right: 10),
                                    ),
                                  ),
                                ],
                              ),
                              _assetDetails(
                                      'Relationship', person.relationship ?? '')
                                  .paddingOnly(left: 15, right: 15, top: 10),
                              _assetDetails(
                                'Dependent',
                                person.isDependant == true ? 'Yes' : 'No',
                              ).paddingOnly(
                                  left: 15, right: 15, top: 10, bottom: 10),
                              if (index !=
                                  controller.profileFamilyModelResponse.value
                                          .data!.length -
                                      1)
                                const Divider(
                                  height: 0.5,
                                  color: AppColors.colorDCDCDC,
                                ).paddingOnly(bottom: 10),
                            ],
                          ),
                        );
                      },
                    )
                  : SizedBox(
                      height:
                          Utils.getScreenHeight(context: Get.context!) / 7.5,
                      width: Utils.getScreenWidth(context: Get.context!),
                      child: Center(
                        child: CommonText(
                          text: Constants.noDataMsg,
                          color: AppColors.colorDarkBlue,
                          fontSize: 14,
                          fontWeight: AppFontWeight.w400,
                        ),
                      ),
                    ),
            ],
          )).paddingOnly(top: 10),
    ).paddingOnly(top: 10);
  }

  Widget _assetInformation1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'Asset Information',
          color: AppColors.colorBlack,
          fontSize: 16,
          fontWeight: AppFontWeight.w500,
        ).paddingOnly(top: 15),
        Container(
            //height: Utils.getScreenHeight(context: context) / 2.5,
            margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: controller.profilePersonalModelResponse.value.data!
                              .assets !=
                          null &&
                      controller.profilePersonalModelResponse.value.data!
                          .assets!.isNotEmpty
                  ? DataTable(
                      columns: const [
                        DataColumn(label: Text('Asset Code')),
                        DataColumn(label: Text('Asset Name')),
                        DataColumn(label: Text('Serial no')),
                        DataColumn(label: Text('Allocation Date')),
                        DataColumn(label: Text('View')),
                      ],
                      rows: controller
                          .profilePersonalModelResponse.value.data!.assets!
                          .map((person) {
                        return DataRow(cells: [
                          DataCell(Text(person.assetCode ?? '')),
                          DataCell(Text(person.assetName ?? '')),
                          DataCell(Text(person.serialNo ?? '')),
                          DataCell(Text(AppDatePicker.convertDateTimeFormat(
                              person.allocationDate ?? '',
                              'MM/dd/yyyy HH:mm:ss',
                              'dd/MM/yyyy'))),
                          DataCell(
                            IconButton(
                              icon: const Icon(Icons.visibility),
                              onPressed: () {
                                showDialog(
                                  context: Get.context!,
                                  builder: (context) => AlertDialog(
                                    title: CommonText(
                                      text: 'Asset Details :',
                                      color: AppColors.colorDarkBlue,
                                      fontSize: 20,
                                      fontWeight: AppFontWeight.w700,
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CommonListRow(
                                              label: 'Brand name',
                                              value: person.brandName!),
                                          CommonListRow(
                                              label: 'Asset name',
                                              value: person.assetName!),
                                          CommonListRow(
                                              label: 'Allocation Date',
                                              value: AppDatePicker
                                                  .convertDateTimeFormat(
                                                      person.allocationDate ??
                                                          '',
                                                      'MM/dd/yyyy HH:mm:ss',
                                                      'dd/MM/yyyy')),
                                          CommonListRow(
                                              label: 'Type Of Asset',
                                              value: person.typeOfAsset!),
                                          CommonListRow(
                                              label: 'Model Name',
                                              value: person.modelName!),
                                          CommonListRow(
                                              label: 'Serial No',
                                              value: person.serialNo!),
                                          CommonListRow(
                                              label: 'Asset Code',
                                              value: person.assetCode!),
                                          CommonListRow(
                                              label: 'Type',
                                              value: person.type!),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          overlayColor: Colors.transparent,
                                        ),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ]);
                      }).toList(),
                    )
                  : SizedBox(
                      height:
                          Utils.getScreenHeight(context: Get.context!) / 7.5,
                      width: Utils.getScreenWidth(context: Get.context!),
                      child: Center(
                        child: CommonText(
                          text: Constants.noDataMsg,
                          color: AppColors.colorDarkBlue,
                          fontSize: 14,
                          fontWeight: AppFontWeight.w400,
                        ),
                      ),
                    ), // Fallback when data is null or empty
            )).paddingOnly(top: 10),
      ],
    );
  }

  Widget _assetInformation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.colorF1EBFB,
      ),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.colorWhite,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: 'Asset Details',
                color: AppColors.color2F2F31,
                fontSize: 16,
                fontWeight: AppFontWeight.w500,
              ).paddingOnly(left: 15, right: 10, top: 10, bottom: 10),
              controller.profilePersonalModelResponse.value.data!.assets !=
                          null &&
                      controller.profilePersonalModelResponse.value.data!
                          .assets!.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.profilePersonalModelResponse.value
                          .data!.assets!.length,
                      itemBuilder: (context, index) {
                        final person = controller.profilePersonalModelResponse
                            .value.data!.assets![index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.colorWhite,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _assetDetails('Asset Code',
                                            person.assetCode.toString())
                                        .paddingOnly(
                                            left: 15, right: 15, top: 0),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: Get.context!,
                                        builder: (context) => AlertDialog(
                                          title: CommonText(
                                            text: 'Asset Details :',
                                            color: AppColors.color2F2F31,
                                            fontSize: 20,
                                            fontWeight: AppFontWeight.w700,
                                          ),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CommonListRow(
                                                    label: 'Brand name',
                                                    value: person.brandName!),
                                                CommonListRow(
                                                    label: 'Asset name',
                                                    value: person.assetName!),
                                                CommonListRow(
                                                    label: 'Allocation Date',
                                                    value: AppDatePicker
                                                        .convertDateTimeFormat(
                                                            person.allocationDate ??
                                                                '',
                                                            'MM/dd/yyyy HH:mm:ss',
                                                            'dd/MM/yyyy')),
                                                CommonListRow(
                                                    label: 'Type Of Asset',
                                                    value: person.typeOfAsset!),
                                                CommonListRow(
                                                    label: 'Model Name',
                                                    value: person.modelName!),
                                                CommonListRow(
                                                    label: 'Serial No',
                                                    value: person.serialNo!),
                                                CommonListRow(
                                                    label: 'Asset Code',
                                                    value: person.assetCode!),
                                                CommonListRow(
                                                    label: 'Type',
                                                    value: person.type!),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                overlayColor:
                                                    Colors.transparent,
                                              ),
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: const Text('Close'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        color: AppColors.color7A1FA2,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Center(
                                        child: CommonAppImageSvg(
                                          imagePath: AppImages.profileViewIcon,
                                          height: 10,
                                          width: 10,
                                          color: AppColors.colorWhite,
                                        ),
                                      ),
                                    ).paddingOnly(right: 10),
                                  ),
                                ],
                              ),
                              _assetDetails(
                                      'Asset Name', person.assetName ?? '')
                                  .paddingOnly(left: 15, right: 15, top: 10),
                              _assetDetails(
                                'Serial No',
                                person.serialNo.toString(),
                              ).paddingOnly(left: 15, right: 15, top: 10),
                              _assetDetails(
                                      'Allocation Date',
                                      AppDatePicker.convertDateTimeFormat(
                                          person.allocationDate ?? '',
                                          'MM/dd/yyyy HH:mm:ss',
                                          'dd/MM/yyyy'))
                                  .paddingOnly(
                                      left: 15, right: 15, top: 10, bottom: 10),
                            ],
                          ),
                        );
                      },
                    )
                  : SizedBox(
                      height:
                          Utils.getScreenHeight(context: Get.context!) / 7.5,
                      width: Utils.getScreenWidth(context: Get.context!),
                      child: Center(
                        child: CommonText(
                          text: Constants.noDataMsg,
                          color: AppColors.colorDarkBlue,
                          fontSize: 14,
                          fontWeight: AppFontWeight.w400,
                        ),
                      ),
                    ),
            ],
          )).paddingOnly(top: 10),
    ).paddingOnly(top: 10);
  }

  Widget _employeeDetails(String imagePath, String label, String value) {
    return Row(
      children: [
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: AppColors.color7A1FA2,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CommonAppImageSvg(
            imagePath: imagePath,
            height: 20,
            width: 20,
            color: AppColors.colorWhite,
          ).paddingSymmetric(vertical: 10, horizontal: 10),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: label,
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColors.color2F2F31,
              ),
              CommonText(
                  softWrap: true,
                  maxLine: 2,
                  overflow: TextOverflow.visible,
                  text: value,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.color7B758E),
            ],
          ),
        ),
      ],
    );
  }

  Widget _assetDetails(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CommonText(
          text: label,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: AppColors.color2F2F31,
        ),
        CommonText(
            softWrap: true,
            maxLine: 2,
            overflow: TextOverflow.visible,
            text: value,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColors.color7B758E),
      ],
    );
  }
}

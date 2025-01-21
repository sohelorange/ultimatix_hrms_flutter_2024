import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/screen/profile/profile_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/constants.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

import '../../app/app_colors.dart';
import '../../app/app_images.dart';
import '../../widget/common_app_bar.dart';
import '../../widget/common_container.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CommonAppBar(
        title: 'Profile',
      ),
      body: CommonContainer(
        child: Container(
          padding: const EdgeInsets.all(20),
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
        Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: AppColors.gradientBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // Adjust radius
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.5),
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
                            imagePath: AppImages.svgAvatar, // Default SVG image
                            height: 80,
                            width: 80,
                            fit: BoxFit
                                .cover, // Ensures the image fills the space
                          )
                        : CommonAppImageSvg(
                            imagePath: controller.userImageUrl.value,
                            // Use profile image URL
                            height: 80,
                            width: 80,
                            fit: BoxFit
                                .cover, // Ensures the image fills the space
                          ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        textAlign: TextAlign.start,
                        text: controller.profilePersonalModelResponse.value
                            .data![0].empFullName!,
                        color: AppColors.colorWhite,
                        fontSize: 20,
                        fontWeight: AppFontWeight.w700,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CommonText(
                        textAlign: TextAlign.start,
                        text: controller.profilePersonalModelResponse.value
                            .data![0].empCode!,
                        color: AppColors.colorWhite,
                        fontSize: 14,
                        fontWeight: AppFontWeight.w500,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        CommonText(
          text: 'Designation',
          color: AppColors.color6B6D7A,
          fontSize: 12,
          fontWeight: AppFontWeight.w400,
        ).paddingOnly(top: 15),
        CommonText(
          text:
              controller.profilePersonalModelResponse.value.data![0].desigName!,
          color: AppColors.colorDarkBlue,
          fontSize: 14,
          fontWeight: AppFontWeight.w400,
        ).paddingOnly(top: 5),
        CommonText(
          text: 'Reporting Manager',
          color: AppColors.color6B6D7A,
          fontSize: 12,
          fontWeight: AppFontWeight.w400,
        ).paddingOnly(top: 15),
        CommonText(
          text: controller
              .profilePersonalModelResponse.value.data![0].empFullNameSuperior!,
          color: AppColors.colorDarkBlue,
          fontSize: 14,
          fontWeight: AppFontWeight.w400,
        ).paddingOnly(top: 5),
        _personalInformation(),
        _bankInformation(),
        _favouriteInformation(),
        _familyInformation(),
        _assetInformation()
      ],
    ));
  }

  Widget _personalInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'Personal Information',
          color: AppColors.colorBlack,
          fontSize: 16,
          fontWeight: AppFontWeight.w500,
        ).paddingOnly(top: 15),
        Container(
            //height: Utils.getScreenHeight(context: context) / 2.5,
            margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
            padding: const EdgeInsets.symmetric(vertical: 15),
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
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _employeeDetails(
                          AppImages.profileDOJIcon,
                          'Date Of Joining',
                          controller.profilePersonalModelResponse.value.data![0]
                                  .dateOfJoin ??
                              ''),
                    ),
                    Expanded(
                      child: _employeeDetails(
                          AppImages.profileBloodGroupIcon,
                          'Blood Group',
                          controller.profilePersonalModelResponse.value.data![0]
                                  .bloodGroup ??
                              ''),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 10),
                // _employeeDetails(
                //         AppImages.leaveCalendarIcon,
                //         'Guardian Name',
                //         controller.profilePersonalModelResponse.value.data![0]
                //                 .grdName ??
                //             '')
                //     .paddingOnly(left: 10, right: 10, top: 10),
                _employeeDetails(
                        AppImages.profileUANIcon,
                        'UAN Number',
                        controller.maskNumber(controller
                                .profilePersonalModelResponse
                                .value
                                .data![0]
                                .uANNo ??
                            ''))
                    .paddingOnly(left: 10, right: 10, top: 10),
                _employeeDetails(
                        AppImages.profileAadharCardNoIcon,
                        'Aadhar Card Number',
                        controller.maskNumber(controller
                                .profilePersonalModelResponse
                                .value
                                .data![0]
                                .aadharCardNo ??
                            ''))
                    .paddingOnly(left: 10, right: 10, top: 10),
                _employeeDetails(
                        AppImages.profilePanNoIcon,
                        'PAN Number',
                        controller.maskNumber(controller
                                .profilePersonalModelResponse
                                .value
                                .data![0]
                                .panNo ??
                            ''))
                    .paddingOnly(left: 10, right: 10, top: 10),
                _employeeDetails(
                        AppImages.profileUANIcon,
                        'Contact No',
                        controller.profilePersonalModelResponse.value.data![0]
                                .mobileNo ??
                            '')
                    .paddingOnly(left: 10, right: 10, top: 10),
                _employeeDetails(
                        AppImages.profileCompanyEmailIcon,
                        'Email Id',
                        controller.profilePersonalModelResponse.value.data![0]
                                .workEmail ??
                            '')
                    .paddingOnly(left: 10, right: 10, top: 10),
                _employeeDetails(
                        AppImages.profilePersonEmailIcon,
                        'Person Email',
                        controller
                                .profilePersonalModelResponse
                                .value
                                .data![0]
                                //.otherEmail ??
                                .fROMEMAIL ??
                            '')
                    .paddingOnly(left: 10, right: 10, top: 10),
                _employeeDetails(AppImages.profileAddressIcon, 'Address',
                        '${controller.profilePersonalModelResponse.value.data![0].street1 ?? ''},${controller.profilePersonalModelResponse.value.data![0].city ?? ''},${controller.profilePersonalModelResponse.value.data![0].state ?? ''},${controller.profilePersonalModelResponse.value.data![0].zipCode ?? '' '.'}')
                    .paddingOnly(left: 10, right: 10, top: 10)
              ],
            )).paddingOnly(top: 10),
      ],
    );
  }

  Widget _bankInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'Bank Information',
          color: AppColors.colorBlack,
          fontSize: 16,
          fontWeight: AppFontWeight.w500,
        ).paddingOnly(top: 15),
        Container(
            //height: Utils.getScreenHeight(context: context) / 2.5,
            margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
            padding: const EdgeInsets.symmetric(vertical: 15),
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
            child: Column(
              children: [
                _employeeDetails(
                        AppImages.profileBankNameIcon,
                        'Bank Name',
                        controller.profilePersonalModelResponse.value.data![0]
                                .bankName ??
                            '')
                    .paddingOnly(left: 10, right: 10, top: 10),
                _employeeDetails(
                        AppImages.profileBankBranchNameIcon,
                        'Bank Branch Name',
                        controller.profilePersonalModelResponse.value.data![0]
                                .bankBranchName ??
                            '')
                    .paddingOnly(left: 10, right: 10, top: 10),
                _employeeDetails(
                  AppImages.profileACNoIcon,
                  'Account Number',
                  controller.maskNumber(controller.profilePersonalModelResponse
                          .value.data![0].incBankACNo ??
                      ''),
                ).paddingOnly(left: 10, right: 10, top: 10),
                _employeeDetails(
                        AppImages.profileIFSCCodeIcon,
                        'IFSC Code',
                        controller.profilePersonalModelResponse.value.data![0]
                                .ifscCode ??
                            '')
                    .paddingOnly(left: 10, right: 10, top: 10),
              ],
            )).paddingOnly(top: 10),
      ],
    );
  }

  Widget _favouriteInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'Favourite Information',
          color: AppColors.colorBlack,
          fontSize: 16,
          fontWeight: AppFontWeight.w500,
        ).paddingOnly(top: 15),
        Container(
            //height: Utils.getScreenHeight(context: context) / 2.5,
            margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
            padding: const EdgeInsets.symmetric(vertical: 15),
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
            child: Column(
              children: [
                _employeeDetails(
                        AppImages.profileFavSportIcon,
                        'Favourite Sport',
                        controller.profileFavoriteModelResponse.value.data![0]
                                .empFavSportName ??
                            '')
                    .paddingOnly(left: 10, right: 10, top: 10),
                _employeeDetails(
                        AppImages.profileFavHobbyIcon,
                        'Hobby',
                        controller.profileFavoriteModelResponse.value.data![0]
                                .empHobbyName ??
                            '')
                    .paddingOnly(left: 10, right: 10, top: 10),
                _employeeDetails(
                        AppImages.profileFavFoodIcon,
                        'Favourite Food',
                        controller.profileFavoriteModelResponse.value.data![0]
                                .empFavFood ??
                            '')
                    .paddingOnly(left: 10, right: 10, top: 10),
                _employeeDetails(
                        AppImages.profileFavRestIcon,
                        'Favourite Restaurant',
                        controller.profileFavoriteModelResponse.value.data![0]
                                .empFavRestro ??
                            '')
                    .paddingOnly(left: 10, right: 10, top: 10),
                _employeeDetails(
                        AppImages.profileFavTravelIcon,
                        'Favourite Travel Destination',
                        controller.profileFavoriteModelResponse.value.data![0]
                                .empFavTrvDestination ??
                            '')
                    .paddingOnly(left: 10, right: 10, top: 10),
                _employeeDetails(
                        AppImages.profileFavFestivalIcon,
                        'Favourite Festival',
                        controller.profileFavoriteModelResponse.value.data![0]
                                .empFavFestival ??
                            '')
                    .paddingOnly(left: 10, right: 10, top: 10),
                _employeeDetails(
                        AppImages.profileFavSportsPersonIcon,
                        'Favourite Sport Person',
                        controller.profileFavoriteModelResponse.value.data![0]
                                .empFavSportPerson ??
                            '')
                    .paddingOnly(left: 10, right: 10, top: 10),
                _employeeDetails(
                        AppImages.profileFavSingerIcon,
                        'Favourite Singer',
                        controller.profileFavoriteModelResponse.value.data![0]
                                .empFavSinger ??
                            '')
                    .paddingOnly(left: 10, right: 10, top: 10),
              ],
            )).paddingOnly(top: 10),
      ],
    );
  }

  Widget _familyInformation() {
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

  Widget _assetInformation() {
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
              child: controller.profileFamilyModelResponse.value.data != null &&
                      controller
                          .profileFamilyModelResponse.value.data!.isNotEmpty
                  ? DataTable(
                      columns: const [
                        DataColumn(label: Text('Asset Code')),
                        DataColumn(label: Text('Asset Name')),
                        DataColumn(label: Text('Serial no')),
                        DataColumn(label: Text('Allocation Date')),
                        DataColumn(label: Text('View')),
                      ],
                      rows: controller.profileFamilyModelResponse.value.data!
                          .map((person) {
                        return DataRow(cells: [
                          DataCell(Text(person.name ?? '')),
                          DataCell(Text(person.relationship ?? '')),
                          DataCell(
                              Text(person.isDependant == true ? 'Yes' : 'No')),
                          DataCell(
                              Text(person.isDependant == true ? 'Yes' : 'No')),
                          DataCell(
                            IconButton(
                              icon: const Icon(Icons.visibility),
                              onPressed: () {
                                // Handle the "View" button press
                                showDialog(
                                  context: Get.context!,
                                  builder: (context) => AlertDialog(
                                    title: const Text('View Details'),
                                    content: Text('Name: ${person.name}\n'
                                        'Relationship: ${person.relationship}\n'
                                        'Dependent: ${person.isDependant.toString()}'),
                                    actions: [
                                      TextButton(
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

  Widget _employeeDetails(String imagePath, String label, String value) {
    return Row(
      children: [
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: AppColors.colorF8F4FA,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0X1C1F370D),
                blurRadius: 0.0,
                spreadRadius: 0.0,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: CommonAppImageSvg(
            imagePath: imagePath,
            height: 20,
            width: 20,
            color: AppColors.colorDarkBlue,
          ).paddingSymmetric(vertical: 10, horizontal: 10),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: label,
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppColors.color6B6D7A,
              ),
              CommonText(
                softWrap: true,
                maxLine: 2,
                overflow: TextOverflow.visible,
                text: value,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.colorDarkBlue,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

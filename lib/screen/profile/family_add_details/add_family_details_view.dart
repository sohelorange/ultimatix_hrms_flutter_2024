import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_date_format.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/model/hobby_model.dart';
import 'package:ultimatix_hrms_flutter/model/occupation_model.dart';
import 'package:ultimatix_hrms_flutter/model/relationship_model.dart';
import 'package:ultimatix_hrms_flutter/model/standard_model.dart';
import 'package:ultimatix_hrms_flutter/screen/profile/family_add_details/add_family_details_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image_svg.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_bar_new.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_input_date_new.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_input_new.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_button_new.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_dropdown_new.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_dropdown_with_model_new.dart';

class AddFamilyDetailsView extends GetView<AddFamilyDetailsController> {
  const AddFamilyDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CommonNewAppBar(
        title: 'Add Family Details',
        leadingIconSvg: AppImages.icBack,
      ),
      resizeToAvoidBottomInset: true,
      // Allow resizing when keyboard appears
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Expanded(child: getAddFamilyView(context)),
            Obx(() => CommonButtonNew(
                  buttonText: 'Submit',
                  onPressed: () {
                    controller.validationWithAPI();
                  },
                  isLoading: controller.isSubmitLoading.value,
                  isDisable: controller.isDisable.value,
                ).paddingOnly(top: 10, bottom: 10))
          ],
        ),
      ),
    ));
  }

  getAddFamilyView(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: 'Family members name *',
              color: AppColors.color2F2F31,
              fontSize: 16,
              fontWeight: AppFontWeight.w400,
            ),
            CommonAppInputNew(
              textEditingController:
                  controller.familyMembersNameController.value,
              hintText: "Enter Family members name ",
              textInputAction: TextInputAction.next,
              hintColor: AppColors.color7B758E,
            ).paddingOnly(top: 15),
            CommonText(
              text: 'Relationship',
              color: AppColors.color2F2F31,
              fontSize: 16,
              fontWeight: AppFontWeight.w400,
            ).paddingOnly(top: 20),
            controller.isLoading.isTrue
                ? Center(child: Utils.commonCircularProgress())
                    .paddingOnly(top: 15)
                : controller.relationshipList.isNotEmpty
                    ? CommonDropdownWithModelNew<RelationshipModel>(
                        items: controller.relationshipList,
                        displayValue: (item) => item.relationship!,
                        value: (item) => item.relationshipID.toString(),
                        hint: 'Select Relationship',
                        onChanged: (String value) {
                          // Find the selected RelationshipModel by ID
                          RelationshipModel selectedItem =
                              controller.relationshipList.firstWhere((item) =>
                                  item.relationshipID.toString() == value);

                          controller.relationShipId.value =
                              selectedItem.relationshipID.toString();
                          controller.relationShipName.value =
                              selectedItem.relationship.toString();
                        },
                      ).paddingOnly(top: 15)
                    : CommonText(
                        text: 'No relationship found',
                        fontWeight: AppFontWeight.w400,
                        fontSize: 16,
                        color: AppColors.colorDarkBlue,
                      ).paddingOnly(top: 15),
            CommonText(
              text: 'Gender',
              color: AppColors.color2F2F31,
              fontSize: 16,
              fontWeight: AppFontWeight.w400,
            ).paddingOnly(top: 20),
            CommonDropdownNew(
              items: const [
                'Male',
                'Female',
              ],
              //initialValue: 'Half Day',
              hint: 'Select Gender',
              onChanged: (String value) {
                controller.selectedGender.value = value;
              },
            ).paddingOnly(top: 15),
            CommonText(
              text: 'DOB',
              color: AppColors.color2F2F31,
              fontSize: 16,
              fontWeight: AppFontWeight.w400,
            ).paddingOnly(top: 20),
            GestureDetector(
              onTap: () {
                /*if (controller.selectedDropdownLeaveID.value.isEmpty) {
                  AppSnackBar.showGetXCustomSnackBar(
                      message: 'Please select first leave type.');
                } else {
                  Utils.closeKeyboard(context);
                  AppDatePicker.previousDateDisable(
                      context, controller.dobController.value);
                }*/

                Utils.closeKeyboard(context);
                AppDatePicker.futureDateDisable(
                    context, controller.dobController.value);
              },
              child: CommonAppInputDateNew(
                isEnable: false,
                textEditingController: controller.dobController.value,
                hintText: "DD/MM/YYYY",
                hintColor: AppColors.color7B758E,
                labelStyle: const TextStyle(
                  color: AppColors.color2F2F31,
                ),
              ),
            ).paddingOnly(top: 15),
            CommonText(
              text: 'Occupation',
              color: AppColors.color2F2F31,
              fontSize: 16,
              fontWeight: AppFontWeight.w400,
            ).paddingOnly(top: 20),
            controller.isLoading.isTrue
                ? Center(child: Utils.commonCircularProgress())
                    .paddingOnly(top: 15)
                : controller.occupationList.isNotEmpty
                    ? CommonDropdownWithModelNew<OccupationModel>(
                        items: controller.occupationList,
                        displayValue: (item) => item.occupationName!,
                        value: (item) => item.oID.toString(),
                        hint: 'Select Occupation',
                        onChanged: (String value) {
                          // Find the selected RelationshipModel by ID
                          OccupationModel selectedItem =
                              controller.occupationList.firstWhere(
                                  (item) => item.oID.toString() == value);

                          controller.occupationId.value =
                              selectedItem.oID.toString();
                          controller.occupationName.value =
                              selectedItem.occupationName.toString();
                        },
                      ).paddingOnly(top: 15)
                    : CommonText(
                        text: 'No occupation found',
                        fontWeight: AppFontWeight.w400,
                        fontSize: 16,
                        color: AppColors.colorDarkBlue,
                      ).paddingOnly(top: 15),
            //TODO : Employee & Self-Employee BL
            Visibility(
              visible: controller.occupationId.value == '10' ||
                  controller.occupationId.value == '11',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: 'Company name',
                    color: AppColors.color2F2F31,
                    fontSize: 16,
                    fontWeight: AppFontWeight.w400,
                  ).paddingOnly(top: 20),
                  CommonAppInputNew(
                    textEditingController:
                        controller.companyNameController.value,
                    hintText: "Enter Company name",
                    hintColor: AppColors.color7B758E,
                  ).paddingOnly(top: 15),
                  CommonText(
                    text: 'Company City',
                    color: AppColors.color2F2F31,
                    fontSize: 16,
                    fontWeight: AppFontWeight.w400,
                  ).paddingOnly(top: 20),
                  CommonAppInputNew(
                    textEditingController:
                        controller.companyCityController.value,
                    hintText: "Enter Company City",
                    hintColor: AppColors.color7B758E,
                  ).paddingOnly(top: 15),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                ],
              ),
            ),

            //TODO : Student BL
            Visibility(
              visible: controller.occupationId.value == '9',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: 'Standard',
                    color: AppColors.color2F2F31,
                    fontSize: 16,
                    fontWeight: AppFontWeight.w400,
                  ).paddingOnly(top: 20),
                  controller.isLoading.isTrue
                      ? Center(child: Utils.commonCircularProgress())
                          .paddingOnly(top: 15)
                      : controller.standardList.isNotEmpty
                          ? CommonDropdownWithModelNew<StandardModel>(
                              items: controller.standardList,
                              displayValue: (item) => item.standardName!,
                              value: (item) => item.sID.toString(),
                              hint: 'Select Standard',
                              onChanged: (String value) {
                                // Find the selected RelationshipModel by ID
                                StandardModel selectedItem =
                                    controller.standardList.firstWhere(
                                        (item) => item.sID.toString() == value);
                                controller.standardId.value =
                                    selectedItem.sID.toString();
                                controller.standardName.value =
                                    selectedItem.standardName.toString();
                              },
                            ).paddingOnly(top: 15)
                          : CommonText(
                              text: 'No standard found',
                              fontWeight: AppFontWeight.w400,
                              fontSize: 16,
                              color: AppColors.colorDarkBlue,
                            ).paddingOnly(top: 15),
                  CommonText(
                    text: 'School/Collage name',
                    color: AppColors.color2F2F31,
                    fontSize: 16,
                    fontWeight: AppFontWeight.w400,
                  ).paddingOnly(top: 20),
                  CommonAppInputNew(
                    textEditingController: controller.clgNameController.value,
                    hintText: "Enter School/College name",
                    hintColor: AppColors.color7B758E,
                  ).paddingOnly(top: 15),
                  CommonText(
                    text: 'School/Collage city',
                    color: AppColors.color2F2F31,
                    fontSize: 16,
                    fontWeight: AppFontWeight.w400,
                  ).paddingOnly(top: 20),
                  CommonAppInputNew(
                    textEditingController: controller.clgCityController.value,
                    hintText: "Enter School/College City",
                    hintColor: AppColors.color7B758E,
                  ).paddingOnly(top: 15),
                  CommonText(
                    text: 'Extra Activity',
                    color: AppColors.color2F2F31,
                    fontSize: 16,
                    fontWeight: AppFontWeight.w400,
                  ).paddingOnly(top: 20),
                  CommonAppInputNew(
                    textEditingController:
                        controller.extraActivityController.value,
                    hintText: "Enter Extra Activity",
                    hintColor: AppColors.color7B758E,
                  ).paddingOnly(top: 15),
                ],
              ),
            ),

            // CommonDropdownWithModel<HobbyModel>(
            //   items: controller.hobbyList,
            //   displayValue: (item) => item.hobbyName!,
            //   value: (item) => item.hID.toString(),
            //   hint: 'Select Hobby',
            //   onChanged: (String value) {
            //     // Find the selected RelationshipModel by ID
            //     HobbyModel selectedItem = controller.hobbyList
            //         .firstWhere((item) => item.hID.toString() == value);
            //     controller.hobbyId.value = selectedItem.hID.toString();
            //   },
            // ),

            CommonText(
              text: 'Hobby',
              color: AppColors.color2F2F31,
              fontSize: 16,
              fontWeight: AppFontWeight.w400,
            ).paddingOnly(top: 20),
            controller.isLoading.isTrue
                ? Center(child: Utils.commonCircularProgress())
                    .paddingOnly(top: 15)
                : controller.hobbyList.isNotEmpty
                    ? MultiSelectDialogField<HobbyModel>(
                        dialogHeight: 250,
                        isDismissible: false,
                        //dialogWidth: 500,
                        buttonText: Text(
                          textAlign: TextAlign.start,
                          'Select Hobby',
                          style: TextStyle(
                            fontWeight: AppFontWeight.w400,
                            fontSize: 16,
                            color: AppColors.color7B758E,
                          ),
                        ),
                        itemsTextStyle: TextStyle(
                            fontWeight: AppFontWeight.w500,
                            fontSize: 14,
                            color: AppColors.colorDarkGray),
                        separateSelectedItems: true,
                        selectedItemsTextStyle: TextStyle(
                            fontWeight: AppFontWeight.w900,
                            fontSize: 14,
                            color: AppColors.color2F2F31),
                        items: controller.hobbyList
                            .map((hobby) => MultiSelectItem<HobbyModel>(
                                hobby, hobby.hobbyName!))
                            .toList(),
                        listType: MultiSelectListType.LIST,
                        title: CommonText(
                          text: 'Select Hobby',
                          fontWeight: AppFontWeight.w700,
                          fontSize: 20,
                          color: AppColors.color2F2F31,
                        ),
                        selectedColor: AppColors.purpleSwatch,
                        buttonIcon: const Icon(Icons.keyboard_arrow_down,
                            color: AppColors.colorDarkGray),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1.0,
                            color: AppColors.colorDCDCDC,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        initialValue: const [],
                        onConfirm: (values) {
                          List<HobbyModel> selectedHobbies =
                              values.cast<HobbyModel>();
                          // Extract IDs as a comma-separated string
                          // controller.hobbyId.value = selectedHobbies
                          //     .map((hobby) => hobby.hID.toString())
                          //     .join(',');

                          controller.hobbyId.value = selectedHobbies
                              .map((hobby) => hobby.hID.toString())
                              .join(','); // TODO : String Format With Comma

                          // List<Map<String, dynamic>> hobbyList = selectedHobbies
                          //     .map((hobby) => {'hobbyID': hobby.hID})
                          //     .toList(); //TODO : JSON Array With Object

                          // controller.hobbyId.value = selectedHobbies
                          //     .map((hobby) => '{${hobby.hID}}')
                          //     .join(',');  //TODO : JSON Only Object Return

                          controller.hobbyName.value = selectedHobbies
                              .map((hobby) => hobby.hobbyName)
                              .join(',');
                        },
                      ).paddingOnly(top: 15)
                    : CommonText(
                        text: 'No hobby found',
                        fontWeight: AppFontWeight.w400,
                        fontSize: 16,
                        color: AppColors.colorDarkBlue,
                      ).paddingOnly(top: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.isHobbyCheck.value =
                              !controller.isHobbyCheck.value;
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: controller.isHobbyCheck.value
                                ? AppColors.color7A1FA2
                                : Colors.transparent,
                            border: Border.all(
                              color: AppColors.color2F2F31,
                              width: 1,
                            ),
                            borderRadius:
                                BorderRadius.circular(4), // For rounded corners
                          ),
                          child: controller.isHobbyCheck.value
                              ? const Center(
                                  child: Icon(
                                    Icons.check,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      CommonText(
                        text: 'Other Hobby',
                        color: AppColors.colorDarkBlue,
                        fontSize: 14,
                        fontWeight: AppFontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ],
            ).paddingOnly(top: 10),
            Visibility(
              visible: controller.isHobbyCheck.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: 'Other Hobby',
                    color: AppColors.color2F2F31,
                    fontSize: 16,
                    fontWeight: AppFontWeight.w400,
                  ).paddingOnly(top: 20),
                  CommonAppInputNew(
                    textEditingController:
                        controller.otherHobbyController.value,
                    hintText: "Enter Other Hobby",
                    hintColor: AppColors.color7B758E,
                  ).paddingOnly(top: 15),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.isResidingCheck.value =
                              !controller.isResidingCheck.value;
                          if (controller.isResidingCheck.value) {
                            controller.isResidingValue.value = 1;
                          } else {
                            controller.isResidingValue.value = 0;
                          }
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: controller.isResidingCheck.value
                                ? AppColors.color7A1FA2
                                : Colors.transparent,
                            border: Border.all(
                              color: AppColors.color2F2F31,
                              width: 1,
                            ),
                            borderRadius:
                                BorderRadius.circular(4), // For rounded corners
                          ),
                          child: controller.isResidingCheck.value
                              ? const Center(
                                  child: Icon(
                                    Icons.check,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      CommonText(
                        text: 'Is Residing with him/her?',
                        color: AppColors.colorDarkBlue,
                        fontSize: 14,
                        fontWeight: AppFontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ],
            ).paddingOnly(top: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.isDependentCheck.value =
                              !controller.isDependentCheck.value;
                          if (controller.isDependentCheck.value) {
                            controller.isDependentValue.value = 1;
                          } else {
                            controller.isDependentValue.value = 0;
                          }
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: controller.isDependentCheck.value
                                ? AppColors.color7A1FA2
                                : Colors.transparent,
                            border: Border.all(
                              color: AppColors.color2F2F31,
                              width: 1,
                            ),
                            borderRadius:
                                BorderRadius.circular(4), // For rounded corners
                          ),
                          child: controller.isDependentCheck.value
                              ? const Center(
                                  child: Icon(
                                    Icons.check,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      CommonText(
                        text: 'Is Dependent on you?',
                        color: AppColors.colorDarkBlue,
                        fontSize: 14,
                        fontWeight: AppFontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ],
            ).paddingOnly(top: 10),
            CommonText(
              text: 'Choose Photo',
              color: AppColors.color2F2F31,
              fontSize: 16,
              fontWeight: AppFontWeight.w400,
            ).paddingOnly(top: 20),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    //controller.filePickerFun();
                    //controller.imageCapture();
                    controller.pickImage();
                  },
                  child: const CommonAppImageSvg(
                    imagePath: AppImages.profileChoosePhotoIcon,
                    height: 60,
                    width: 60,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CommonText(
                    text: controller.docName.value.isEmpty
                        ? 'No File Chosen'
                        : controller.docName.value,
                    fontSize: 14,
                    color: AppColors.color7B758E,
                    fontWeight: AppFontWeight.w400,
                  ),
                )
              ],
            ).paddingOnly(top: 15),
            Visibility(
              visible: false,
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CommonText(
                      text: controller.docName.value.isEmpty
                          ? 'Choose Photo'
                          : controller.docName.value,
                      fontSize: 16,
                      color: AppColors.colorDarkBlue,
                      fontWeight: AppFontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.end,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //controller.filePickerFun();
                          //controller.imageCapture();
                          controller.pickImage();
                        },
                        child: const CommonAppImage(
                          imagePath: AppImages.icbrowse,
                          height: 25,
                          width: 25,
                        ),
                      ),
                      Visibility(
                        visible: controller.docName.value.isNotEmpty,
                        child: IconButton(
                            onPressed: () {
                              controller.docName.value = '';
                              controller.attachment.value = '';
                              controller.extension.value = '';
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 20,
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),

            CommonText(
              text: 'PAN Card (Ex. ABCDE1234A)',
              color: AppColors.color2F2F31,
              fontSize: 16,
              fontWeight: AppFontWeight.w400,
            ).paddingOnly(top: 20),
            CommonAppInputNew(
              textEditingController: controller.panCardController.value,
              hintText: "Enter PAN Card",
              maxLength: 10,
              hintColor: AppColors.color7B758E,
            ).paddingOnly(top: 15),
            CommonText(
              text: 'Aadhar Card (Ex. 1234 5678 9100)',
              color: AppColors.color2F2F31,
              fontSize: 16,
              fontWeight: AppFontWeight.w400,
            ).paddingOnly(top: 20),
            CommonAppInputNew(
              maxLength: 12,
              textEditingController: controller.aadharCardController.value,
              hintText: "Enter Aadhar Card",
              hintColor: AppColors.color7B758E,
            ).paddingOnly(top: 15),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: 'Height',
                        color: AppColors.color2F2F31,
                        fontSize: 16,
                        fontWeight: AppFontWeight.w400,
                      ).paddingOnly(top: 20),
                      CommonAppInputNew(
                        maxLength: 5,
                        textInputAction: TextInputAction.next,
                        textInputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        textEditingController:
                            controller.heightController.value,
                        hintText: "Height (cm)",
                        hintColor: AppColors.color7B758E,
                      ).paddingOnly(top: 15),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: 'Weight',
                        color: AppColors.color2F2F31,
                        fontSize: 16,
                        fontWeight: AppFontWeight.w400,
                      ).paddingOnly(top: 20),
                      CommonAppInputNew(
                        maxLength: 5,
                        textInputAction: TextInputAction.done,
                        textInputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        textEditingController:
                            controller.weightController.value,
                        hintText: "Weight (kg)",
                        hintColor: AppColors.color7B758E,
                      ).paddingOnly(top: 15),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

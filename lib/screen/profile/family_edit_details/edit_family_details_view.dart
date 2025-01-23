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
import 'package:ultimatix_hrms_flutter/screen/profile/family_edit_details/edit_family_details_controller.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_image.dart';
import 'package:ultimatix_hrms_flutter/widget/common_button.dart';
import 'package:ultimatix_hrms_flutter/widget/common_dropdown.dart';
import 'package:ultimatix_hrms_flutter/widget/common_dropdown_with_model.dart';
import 'package:ultimatix_hrms_flutter/widget/common_input_field.dart';
import 'package:ultimatix_hrms_flutter/widget/common_text.dart';

import '../../../widget/common_app_bar.dart';
import '../../../widget/common_container.dart';

class EditFamilyDetailsView extends GetView<EditFamilyDetailsController> {
  const EditFamilyDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CommonAppBar(
        title: 'Edit Family Details',
      ),
      resizeToAvoidBottomInset: true,
      // Allow resizing when keyboard appears
      body: CommonContainer(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: getAddFamilyView(context),
        ),
      ),
    ));
  }

  getAddFamilyView(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          children: [
            CommonInputField(
              textEditingController:
                  controller.familyMembersNameController.value,
              hintText: "Family members name *",
              labelStyle: const TextStyle(
                color: AppColors.colorDarkBlue,
              ),
              hintStyle: const TextStyle(
                color: AppColors.colorDarkBlue,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            controller.isLoading.isTrue
                ? Center(child: Utils.commonCircularProgress())
                : controller.relationshipList.isNotEmpty
                    ? CommonDropdownWithModel<RelationshipModel>(
                        items: controller.relationshipList,
                        // The list fetched from the API
                        initialValue: controller.relationShipId.value.isNotEmpty
                            ? controller.relationShipId.value
                            : null,
                        // Pass the selected ID from the API as the initial value
                        displayValue: (item) => item.relationship!,
                        // Display name of the relationship
                        value: (item) => item.relationshipID.toString(),
                        // ID as the value
                        hint: 'Select Relationship',
                        onChanged: (String value) {
                          // Find the selected item by ID
                          RelationshipModel selectedItem =
                              controller.relationshipList.firstWhere(
                            (item) => item.relationshipID.toString() == value,
                          );

                          // Update the controller values
                          controller.relationShipId.value =
                              selectedItem.relationshipID.toString();
                          controller.relationShipName.value =
                              selectedItem.relationship!;
                        },
                      )
                    : CommonText(
                        text: 'No relationship found',
                        fontWeight: AppFontWeight.w400,
                        fontSize: 16,
                        color: AppColors.colorDarkBlue,
                      ),
            const SizedBox(
              height: 10,
            ),
            CommonDropdown(
              initialValue:
                  controller.selectedGender.value == 'F' ? 'Female' : 'Male',
              items: const [
                'Male',
                'Female',
              ],
              //initialValue: 'Half Day',
              hint: 'Select Gender',
              onChanged: (String value) {
                controller.selectedGender.value = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
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
              child: CommonInputField(
                isEnable: false,
                textEditingController: controller.dobController.value,
                hintText: "DOB (dd/MM/yyyy)",
                labelStyle: const TextStyle(
                  color: AppColors.colorDarkBlue,
                ),
                hintStyle: const TextStyle(
                  color: AppColors.colorDarkBlue,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            controller.isLoading.isTrue
                ? Center(child: Utils.commonCircularProgress())
                : controller.occupationList.isNotEmpty
                    ? CommonDropdownWithModel<OccupationModel>(
                        items: controller.occupationList,
                        initialValue: controller.occupationId.value.isNotEmpty
                            ? controller.occupationId.value
                            : null,
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
                      )
                    : CommonText(
                        text: 'No occupation found',
                        fontWeight: AppFontWeight.w400,
                        fontSize: 16,
                        color: AppColors.colorDarkBlue,
                      ),
            const SizedBox(
              height: 10,
            ),
            //TODO : Employee & Self-Employee BL
            Visibility(
              visible: controller.occupationId.value == '10' ||
                  controller.occupationId.value == '11',
              child: Column(
                children: [
                  CommonInputField(
                    textEditingController:
                        controller.companyNameController.value,
                    hintText: "Company name",
                    labelStyle: const TextStyle(
                      color: AppColors.colorDarkBlue,
                    ),
                    hintStyle: const TextStyle(
                      color: AppColors.colorDarkBlue,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonInputField(
                    textEditingController:
                        controller.companyCityController.value,
                    hintText: "Company City",
                    labelStyle: const TextStyle(
                      color: AppColors.colorDarkBlue,
                    ),
                    hintStyle: const TextStyle(
                      color: AppColors.colorDarkBlue,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),

            //TODO : Student BL
            Visibility(
              visible: controller.occupationId.value == '9',
              child: Column(
                children: [
                  controller.isLoading.isTrue
                      ? Center(child: Utils.commonCircularProgress())
                      : controller.standardList.isNotEmpty
                          ? CommonDropdownWithModel<StandardModel>(
                              items: controller.standardList,
                              initialValue:
                                  controller.standardId.value.isNotEmpty
                                      ? controller.standardId.value
                                      : null,
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
                            )
                          : CommonText(
                              text: 'No standard found',
                              fontWeight: AppFontWeight.w400,
                              fontSize: 16,
                              color: AppColors.colorDarkBlue,
                            ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonInputField(
                    textEditingController: controller.clgNameController.value,
                    hintText: "School/College name",
                    labelStyle: const TextStyle(
                      color: AppColors.colorDarkBlue,
                    ),
                    hintStyle: const TextStyle(
                      color: AppColors.colorDarkBlue,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonInputField(
                    textEditingController: controller.clgCityController.value,
                    hintText: "School/College City",
                    labelStyle: const TextStyle(
                      color: AppColors.colorDarkBlue,
                    ),
                    hintStyle: const TextStyle(
                      color: AppColors.colorDarkBlue,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonInputField(
                    textEditingController:
                        controller.extraActivityController.value,
                    hintText: "Extra Activity",
                    labelStyle: const TextStyle(
                      color: AppColors.colorDarkBlue,
                    ),
                    hintStyle: const TextStyle(
                      color: AppColors.colorDarkBlue,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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

            controller.isLoading.isTrue
                ? Center(child: Utils.commonCircularProgress())
                : controller.hobbyList.isNotEmpty
                    ? MultiSelectDialogField<HobbyModel>(
                        dialogHeight: 250,
                        isDismissible: false,
                        buttonText: Text(
                          textAlign: TextAlign.start,
                          'Select Hobby',
                          style: TextStyle(
                            fontWeight: AppFontWeight.w400,
                            fontSize: 16,
                            color: AppColors.colorDarkBlue,
                          ),
                        ),
                        itemsTextStyle: TextStyle(
                          fontWeight: AppFontWeight.w500,
                          fontSize: 14,
                          color: AppColors.colorDarkGray,
                        ),
                        separateSelectedItems: true,
                        selectedItemsTextStyle: TextStyle(
                          fontWeight: AppFontWeight.w900,
                          fontSize: 14,
                          color: AppColors.colorDarkBlue,
                        ),
                        items: controller.hobbyList
                            .map((hobby) => MultiSelectItem<HobbyModel>(
                                hobby, hobby.hobbyName!))
                            .toList(),
                        listType: MultiSelectListType.LIST,
                        title: CommonText(
                          text: 'Select Hobby',
                          fontWeight: AppFontWeight.w700,
                          fontSize: 20,
                          color: AppColors.colorDarkBlue,
                        ),
                        selectedColor: AppColors.purpleSwatch,
                        buttonIcon: const Icon(Icons.keyboard_arrow_down,
                            color: AppColors.colorDarkGray),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: AppColors.colorDarkGray),
                          ),
                        ),
                        // Set the initial value based on the hobbyID
                        initialValue: controller.hobbyId.value.isNotEmpty
                            ? controller.hobbyList.where((hobby) {
                                final selectedIds =
                                    controller.hobbyId.value.split(',');
                                return selectedIds
                                    .contains(hobby.hID.toString());
                              }).toList()
                            : [],
                        // If no hobbyID, start with an empty list
                        onConfirm: (values) {
                          // Handle selection
                          List<HobbyModel> selectedHobbies =
                              values.cast<HobbyModel>();
                          // Extract IDs as a comma-separated string
                          controller.hobbyId.value = selectedHobbies
                              .map((hobby) => hobby.hID.toString())
                              .join(',');

                          // Extract names as a comma-separated string
                          controller.hobbyName.value = selectedHobbies
                              .map((hobby) => hobby.hobbyName)
                              .join(',');
                        },
                      )
                    : CommonText(
                        text: 'No hobby found',
                        fontWeight: AppFontWeight.w400,
                        fontSize: 16,
                        color: AppColors.colorDarkBlue,
                      ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 30,
              child: CheckboxListTile(
                value: controller.isHobbyCheck.value,
                // Bind to reactive variable
                onChanged: (bool? newValue) {
                  if (newValue != null) {
                    controller.isHobbyCheck.value = newValue;
                  }
                },
                title: CommonText(
                  text: 'Other Hobby',
                  color: AppColors.colorDarkBlue,
                  fontSize: 14,
                  fontWeight: AppFontWeight.w400,
                ),
                controlAffinity: ListTileControlAffinity.trailing,
                activeColor: AppColors.purpleSwatch,
                contentPadding: EdgeInsets.zero,
                visualDensity:
                    const VisualDensity(horizontal: -4.0, vertical: -4.0),
                tileColor: Colors.transparent,
                // Set background to transparent
                selectedTileColor:
                    Colors.transparent, // Remove tint when tapped
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            Visibility(
              visible: controller.isHobbyCheck.value,
              child: CommonInputField(
                textEditingController: controller.otherHobbyController.value,
                hintText: "Other Hobby",
                labelStyle: const TextStyle(
                  color: AppColors.colorDarkBlue,
                ),
                hintStyle: const TextStyle(
                  color: AppColors.colorDarkBlue,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 30,
              child: CheckboxListTile(
                value: controller.isResidingCheck.value,
                // Bind to reactive variable
                onChanged: (bool? newValue) {
                  if (newValue != null) {
                    controller.isResidingCheck.value = newValue;
                    if (controller.isResidingCheck.value) {
                      controller.isResidingValue.value = 1;
                    } else {
                      controller.isResidingValue.value = 0;
                    }
                  }
                },
                title: CommonText(
                  text: 'Is Residing with him/her?',
                  color: AppColors.colorDarkBlue,
                  fontSize: 14,
                  fontWeight: AppFontWeight.w400,
                ),
                controlAffinity: ListTileControlAffinity.trailing,
                activeColor: AppColors.purpleSwatch,
                contentPadding: EdgeInsets.zero,
                visualDensity:
                    const VisualDensity(horizontal: -4.0, vertical: -4.0),
                tileColor: Colors.transparent,
                // Set background to transparent
                selectedTileColor:
                    Colors.transparent, // Remove tint when tapped
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 30,
              child: CheckboxListTile(
                value: controller.isDependentCheck.value,
                // Bind to reactive variable
                onChanged: (bool? newValue) {
                  if (newValue != null) {
                    controller.isDependentCheck.value = newValue;
                    if (controller.isDependentCheck.value) {
                      controller.isDependentValue.value = 1;
                    } else {
                      controller.isDependentValue.value = 0;
                    }
                  }
                },
                title: CommonText(
                  text: 'Is Dependent on you?',
                  color: AppColors.colorDarkBlue,
                  fontSize: 14,
                  fontWeight: AppFontWeight.w400,
                ),
                controlAffinity: ListTileControlAffinity.trailing,
                activeColor: AppColors.purpleSwatch,
                contentPadding: EdgeInsets.zero,
                visualDensity:
                    const VisualDensity(horizontal: -4.0, vertical: -4.0),
                tileColor: Colors.transparent,
                // Set background to transparent
                selectedTileColor:
                    Colors.transparent, // Remove tint when tapped
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Visibility(
              visible: true,
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
                      Visibility(
                        //visible: controller.docName.value.isNotEmpty,
                        visible: false,
                        child: GestureDetector(
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
                      ),
                      Visibility(
                        visible: false,
                        //visible: controller.docName.value.isNotEmpty,
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
                      ),
                      Visibility(
                        visible: true,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  // Remove padding for better image display
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.network(
                                        controller.imagePath.value,
                                        fit: BoxFit.contain,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child; // Image is fully loaded
                                          }
                                          return const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child:
                                                  CircularProgressIndicator(), // Show a loader while loading
                                            ),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Center(
                                              child: Text(
                                                'Failed to load image',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ); // Handle image loading errors
                                        },
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        overlayColor: Colors.transparent,
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.visibility,
                            size: 20,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

            CommonInputField(
              maxLength: 10,
              textEditingController: controller.panCardController.value,
              hintText: "PAN Card",
              labelStyle: const TextStyle(
                color: AppColors.colorDarkBlue,
              ),
              hintStyle: const TextStyle(
                color: AppColors.colorDarkBlue,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CommonInputField(
              maxLength: 12,
              textEditingController: controller.aadharCardController.value,
              hintText: "Aadhar Card",
              labelStyle: const TextStyle(
                color: AppColors.colorDarkBlue,
              ),
              hintStyle: const TextStyle(
                color: AppColors.colorDarkBlue,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CommonInputField(
              maxLength: 5,
              textInputAction: TextInputAction.next,
              textInputType:
                  const TextInputType.numberWithOptions(decimal: true),
              textEditingController: controller.heightController.value,
              hintText: "Height",
              labelStyle: const TextStyle(
                color: AppColors.colorDarkBlue,
              ),
              hintStyle: const TextStyle(
                color: AppColors.colorDarkBlue,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CommonInputField(
              maxLength: 5,
              textInputAction: TextInputAction.done,
              textInputType:
                  const TextInputType.numberWithOptions(decimal: true),
              textEditingController: controller.weightController.value,
              hintText: "Weight",
              labelStyle: const TextStyle(
                color: AppColors.colorDarkBlue,
              ),
              hintStyle: const TextStyle(
                color: AppColors.colorDarkBlue,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CommonButton(
              buttonText: 'Update',
              onPressed: () {
                controller.validationWithAPI();
              },
              isLoading: controller.isSubmitLoading.value,
              isDisable: controller.isDisable.value,
            )
          ],
        ),
      ),
    );
  }
}

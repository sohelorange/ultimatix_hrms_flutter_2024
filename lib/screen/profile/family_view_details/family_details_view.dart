import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_images.dart';
import 'package:ultimatix_hrms_flutter/screen/profile/family_view_details/family_details_view_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/common_list_row.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_bar_new.dart';

class FamilyDetailsView extends GetView<FamilyDetailsViewController> {
  const FamilyDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CommonNewAppBar(
        title: "Family Details",
        leadingIconSvg: AppImages.icBack, // Menu icon
      ),
      body: Container(
        //padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.colorF1EBFB,
        ),
        child: Obx(() => SingleChildScrollView(
              child: Column(
                children: [
                  CommonListRow(label: 'Name', value: controller.getTextNA(controller.name.value)),
                  CommonListRow(
                      label: 'Relationship',
                      value: controller.getTextNA(controller.relationship.value)),
                  CommonListRow(
                      label: 'Gender', value: controller.getTextNA(controller.gender.value)),
                  CommonListRow(
                      label: 'Date Of Birth', value: controller.getTextNA(controller.dob.value)),
                  CommonListRow(
                      label: 'Occupation', value: controller.getTextNA(controller.occupation.value)),
                  CommonListRow(label: 'Hobby', value: controller.getTextNA(controller.hobby.value)),
                  CommonListRow(
                      label: 'Standard', value: controller.getTextNA(controller.standard.value)),
                  CommonListRow(
                      label: 'Specialization',
                      value: controller.getTextNA(controller.specialization.value)),
                  CommonListRow(
                      label: 'School/College', value: controller.getTextNA(controller.clg.value)),
                  CommonListRow(
                      label: 'School/College City',
                      value: controller.getTextNA(controller.city.value)),
                  CommonListRow(
                      label: 'Extra Activity',
                      value: controller.getTextNA(controller.extraActivity.value)),
                  CommonListRow(
                      label: 'Is Residing With him/her?',
                      value: controller.getTextNA(controller.isResiding.value)),
                  CommonListRow(
                      label: 'Is Dependent With on you?',
                      value: controller.getTextNA(controller.isDependent.value)),
                  CommonListRow(
                      label: 'PAN Card', value: controller.getTextNA(controller.panCard.value)),
                  CommonListRow(
                      label: 'Aadhar Card', value: controller.getTextNA(controller.aadharCard.value)),
                  CommonListRow(
                      label: 'Height', value: controller.getTextNA(controller.height.value)),
                  CommonListRow(
                      label: 'Weight', value: controller.getTextNA(controller.weight.value)),
                ],
              ),
            )),
      ),
    ));
  }
}

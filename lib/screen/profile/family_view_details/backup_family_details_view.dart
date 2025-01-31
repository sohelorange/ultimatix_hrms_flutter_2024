import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/profile/family_view_details/family_details_view_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/common_list_row.dart';

import '../../../widget/common_app_bar.dart';
import '../../../widget/common_container.dart';

class BackupFamilyDetailsView extends GetView<FamilyDetailsViewController> {
  const BackupFamilyDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CommonAppBar(
        title: 'Family Details',
      ),
      body: CommonContainer(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Obx(() => SingleChildScrollView(
                child: Column(
                  children: [
                    CommonListRow(label: 'Name', value: controller.name.value),
                    CommonListRow(
                        label: 'Relationship',
                        value: controller.relationship.value),
                    CommonListRow(
                        label: 'Gender', value: controller.gender.value),
                    CommonListRow(
                        label: 'Date Of Birth', value: controller.dob.value),
                    CommonListRow(
                        label: 'Occupation',
                        value: controller.occupation.value),
                    CommonListRow(
                        label: 'Hobby', value: controller.hobby.value),
                    CommonListRow(
                        label: 'Standard', value: controller.standard.value),
                    CommonListRow(
                        label: 'Specialization',
                        value: controller.specialization.value),
                    CommonListRow(
                        label: 'School/College', value: controller.clg.value),
                    CommonListRow(
                        label: 'School/College City',
                        value: controller.city.value),
                    CommonListRow(
                        label: 'Extra Activity',
                        value: controller.extraActivity.value),
                    CommonListRow(
                        label: 'Is Residing With him/her?',
                        value: controller.isResiding.value),
                    CommonListRow(
                        label: 'Is Dependent With on you?',
                        value: controller.isDependent.value),
                    CommonListRow(
                        label: 'PAN Card', value: controller.panCard.value),
                    CommonListRow(
                        label: 'Aadhar Card',
                        value: controller.aadharCard.value),
                    CommonListRow(
                        label: 'Height', value: controller.height.value),
                    CommonListRow(
                        label: 'Weight', value: controller.weight.value),
                  ],
                ),
              )),
        ),
      ),
    ));
  }
}

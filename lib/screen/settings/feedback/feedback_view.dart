import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/settings/feedback/feedback_controller.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_font_weight.dart';
import '../../../widget/common_app_bar.dart';
import '../../../widget/common_app_image_svg.dart';
import '../../../widget/common_app_input.dart';
import '../../../widget/common_button.dart';
import '../../../widget/common_container.dart';
import '../../../widget/common_feedback.dart';
import '../../../widget/common_text.dart';
import '../../../widget/new/common_app_bar_two.dart';
import '../../../widget/new/common_button_new.dart';

class FeedbackView extends GetView<FeedbackController> {
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CommonAppBarTwo(title: 'Feedback'),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Obx(() => SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text:
                        'We would like your feedback to improve our\nmobile app.',
                    color: AppColors.colorDarkGray,
                    fontSize: 14,
                    fontWeight: AppFontWeight.w400,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonText(
                    text: 'What is your opinion of this page?',
                    color: AppColors.colorDarkBlue,
                    fontSize: 14,
                    fontWeight: AppFontWeight.w400,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(controller.feedbackOptions.length,
                        (index) {
                      return GestureDetector(
                        onTap: () {
                          controller.selectedFeedbackOpinionIndex.value =
                              index;
                          controller.selectedFeedbackOpinion.value =
                              controller.feedbackOptions[index]["label"];
                        },
                        child: Column(
                          children: [
                            CommonAppImageSvg(
                              imagePath: controller.feedbackOptions[index]
                                  ["icon"],
                              height: 30,
                              width: 30,
                              color: controller.selectedFeedbackOpinionIndex
                                          .value ==
                                      index
                                  ? controller.feedbackOptions[index]["color"]
                                  : controller.unselectedColor,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 15),
                            CommonText(
                              text: controller.feedbackOptions[index]
                                  ["label"],
                              color: controller.selectedFeedbackOpinionIndex
                                          .value ==
                                      index
                                  ? controller.feedbackOptions[index]["color"]
                                  : controller.unselectedColor,
                              fontSize: 12,
                              fontWeight: AppFontWeight.w400,
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    height: 1,
                    color: Color(0XFFF0F0F0),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonText(
                    text: 'Please select your feedback category below :',
                    color: AppColors.colorDarkGray,
                    fontSize: 14,
                    fontWeight: AppFontWeight.w400,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CommonFeedbackTab(
                    gridItems: controller.categoryItems,
                    selectedIndex: controller.selectedCategoryIndex,
                    onItemTap: (index) {
                      controller.selectedCategoryIndex.value = index;
                      controller.selectedCategory.value =
                          controller.categoryItems[index]["name"];
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonText(
                    text: 'Please leave your valuable feedback below :',
                    color: AppColors.colorDarkBlue,
                    fontSize: 14,
                    fontWeight: AppFontWeight.w400,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonAppInput(
                    maxLines: 5,
                    borderColor: AppColors.colorDarkGray,
                    textInputAction: TextInputAction.done,
                    textEditingController:
                        controller.feedbackController.value,
                    focusNode: controller.feedbackFocus,
                    hintText: 'Type here',
                    prifixPadding: const EdgeInsets.all(12),
                    hintColor: AppColors.colorBlack.withValues(alpha: 0.3),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonButtonNew(
                      buttonText: 'Submit',
                      onPressed: () {
                        controller.feedbackWithAPI();
                      },
                      isLoading: controller.isLoading.value,
                      isDisable: controller.isDisable.value),
                ],
              ),
            )),
      ),
    ));
  }
}

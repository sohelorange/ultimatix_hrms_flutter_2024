import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/app/app_font_weight.dart';
import 'package:ultimatix_hrms_flutter/app/app_routes.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_balance/leave_balance_view.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_controller.dart';
import 'package:ultimatix_hrms_flutter/screen/leave/leave_status/leave_status_view.dart';
import 'package:ultimatix_hrms_flutter/widget/common_container.dart';

import '../../app/app_colors.dart';
import '../../widget/common_app_bar.dart';

class LeaveAppView extends GetView<LeaveController> {
  const LeaveAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CommonAppBar(
        title: 'Leave',
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.addLeaveRoute);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: CommonContainer(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: getLeaveView(context),
        ),
      ),
    ));
  }

  getLeaveView(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
              color: AppColors.colorF2F2F2,
              borderRadius: BorderRadius.circular(10)),
          child: TabBar(
            controller: controller.leaveTabController,
            physics: const ClampingScrollPhysics(),
            dividerHeight: 0,
            onTap: (i) {},
            splashBorderRadius: BorderRadius.circular(30),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.color7B1FA2,
            ),
            indicatorColor: AppColors.color7B1FA2,
            automaticIndicatorColorAdjustment: true,
            unselectedLabelColor: AppColors.colorBlack,
            labelColor: AppColors.colorWhite,
            labelPadding: const EdgeInsets.symmetric(horizontal: 20),
            labelStyle: TextStyle(fontSize: 14, fontWeight: AppFontWeight.w400),
            tabs: const [
              Tab(
                text: "Balance",
              ),
              Tab(
                text: "Status",
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller.leaveTabController,
            children: const [LeaveBalanceView(), LeaveStatusView()],
          ),
        ),
      ],
    );
  }
}

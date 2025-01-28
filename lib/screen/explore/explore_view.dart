import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimatix_hrms_flutter/screen/explore/explore_controller.dart';
import 'package:ultimatix_hrms_flutter/widget/common_app_bar.dart';
import 'package:ultimatix_hrms_flutter/widget/common_container.dart';
import 'package:ultimatix_hrms_flutter/widget/new/common_app_bar_new.dart';

import '../../widget/common_explore_grid_view.dart';

class ExploreView extends GetView<ExploreController> {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CommonAppBar(title: 'Explore'),
      body: CommonContainer(
        child: CommonExploreGridView(
          gridItems: controller.exploreItems,
          selectedIndex: controller.selectedIndex,
          onItemTap: (index) {
            controller.selectedIndex.value = index;
            controller.handleNavigation(index);
          },
        ),
      ),
    ));
  }
}

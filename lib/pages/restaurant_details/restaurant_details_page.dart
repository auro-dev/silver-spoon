import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/pages/restaurant_details/controllers/restaurant_details_controller.dart';
import 'package:platemate_user/pages/restaurant_details/widgets/restaurant_details_section.dart';
import 'package:platemate_user/pages/restaurant_details/widgets/restaurant_sliver_bar.dart';
import 'package:platemate_user/widgets/my_divider.dart';

import 'widgets/menu_category_section.dart';

///
/// Created by Auro on 24/03/23 at 12:16 AM
///

class RestaurantDetailsPage extends StatefulWidget {
  static final routeName = '/Restaurant-Details-Page';

  const RestaurantDetailsPage({Key? key}) : super(key: key);

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  late RestaurantDetailsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(RestaurantDetailsController());
    controller.onInit();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    var topPadding = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      body: controller.obx(
        (state) {
          if (state != null) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: MySliverAppBar(
                    expandedHeight: 200.0,
                    topPadding: topPadding,
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      RestaurantDetailsSection(state),
                      const SizedBox(height: 16),
                      GetBuilder(
                        init: controller,
                        builder: (c) => ListView.separated(
                          padding: const EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (c, i) => MenuCategorySection(
                            controller.menuCategories[i],
                            onTap: () => controller.handleExpanded(i),
                            canModifyCount: false,
                          ),
                          separatorBuilder: (c, i) => MyDivider(),
                          itemCount: controller.menuCategories.length,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
        onError: (e) => Center(child: Text("$e")),
      ),
    );
  }
}

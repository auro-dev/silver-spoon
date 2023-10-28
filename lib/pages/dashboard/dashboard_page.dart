import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/pages/dashboard/widgets/navigation_bar.dart';
import 'package:platemate_user/pages/home/controllers/category_controller.dart';
import 'package:platemate_user/pages/home/controllers/recommended_restaurants_controller.dart';
import 'package:platemate_user/pages/home/home_page.dart';
import 'package:platemate_user/pages/orders/orders_page.dart';
import 'package:platemate_user/pages/profile/profile_page.dart';
import 'package:platemate_user/widgets/current_location_picker.dart';

///
/// Created by Kumar Auro from Boiler plate
///

ValueNotifier<int> dashboardIndexNotifier = ValueNotifier(0);
ValueNotifier<String> currentLocationNotifier = ValueNotifier('');

class DashboardPage extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late CategoryController categoryController;
  late RecommendedRestaurantsController recommendedRestaurantsController;

  @override
  void initState() {
    super.initState();
    categoryController = Get.isRegistered<CategoryController>()
        ? Get.find<CategoryController>()
        : Get.put(CategoryController());
    if (categoryController.state == null) categoryController.getData();

    recommendedRestaurantsController =
        Get.isRegistered<RecommendedRestaurantsController>()
            ? Get.find<RecommendedRestaurantsController>()
            : Get.put(RecommendedRestaurantsController());
    recommendedRestaurantsController.getData();

    // set current location
    setCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (dashboardIndexNotifier.value != 0) {
          dashboardIndexNotifier.value = 0;
        } else {
          return true;
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        bottomNavigationBar: BottomNavBar(
          onPageChange: (index) {
            dashboardIndexNotifier.value = index;
          },
        ),
        body: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: dashboardIndexNotifier,
            builder: (ctx, value, _) => AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: [
                HomePage(),
                OrdersPage(),
                ProfilePage(),
              ][dashboardIndexNotifier.value],
            ),
          ),
        ),
      ),
    );
  }
}

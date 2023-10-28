import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:platemate_user/app_configs/app_assets.dart';
import 'package:platemate_user/pages/home/controllers/recommended_restaurants_controller.dart';
import 'package:platemate_user/pages/home/widgets/categories_slider.dart';
import 'package:platemate_user/pages/home/widgets/nearby_restaurants.dart';
import 'package:platemate_user/pages/home/widgets/recommended_restaurants_slider.dart';
import 'package:platemate_user/pages/qr_scanner/qr_scanner_page.dart';
import 'package:platemate_user/widgets/current_location_picker.dart';
import '../../app_configs/app_colors.dart';
import 'controllers/category_controller.dart';

///
/// Created by Auro on 25/02/23 at 10:42 PM
///

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    if (recommendedRestaurantsController.state == null)
      recommendedRestaurantsController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          titleSpacing: 16,
          title: CurrentLocationPicker(),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(QRSScannerPage.routeName);
              },
              icon: SvgPicture.asset(AppAssets.qr_scanner),
            ),
            const SizedBox(width: 6),
          ],
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              categoryController.getData();
              recommendedRestaurantsController.getData();
            },
            child: ListView(
              children: [
                ColoredBox(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.grey80,
                          ),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppAssets.search,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                "search restaurant or dishes",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.grey60,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CategoriesSlider(),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                RecommendedRestaurantsSlider(),
                const SizedBox(height: 24),
                NearByRestaurants(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        )
      ],
    );
  }
}

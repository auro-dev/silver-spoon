import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/pages/home/controllers/recommended_restaurants_controller.dart';
import 'package:platemate_user/pages/home/widgets/categories_slider.dart';
import 'package:platemate_user/pages/home/widgets/restaurant_card.dart';

///
/// Created by Auro on 04/03/23 at 10:36 AM
///

class RecommendedRestaurantsSlider
    extends GetView<RecommendedRestaurantsController> {
  const RecommendedRestaurantsSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle("Recommended for you"),
          const SizedBox(height: 8),
          controller.obx(
            (state) {
              if (state != null) {
                return ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.length,
                  separatorBuilder: (i, c) => SizedBox(height: 16),
                  itemBuilder: (c, i) => RestaurantCard(state[i]),
                );
              }
              return SizedBox();
            },
            onError: (e) => SizedBox(),
            onEmpty: SizedBox(),
          ),
        ],
      ),
    );
  }
}

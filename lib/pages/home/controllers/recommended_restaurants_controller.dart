import 'dart:developer';

import 'package:get/get.dart';
import 'package:platemate_user/api_services/base_api.dart';
import 'package:platemate_user/data_models/restaurant.dart';

import '../../../app_configs/api_routes.dart';

///
/// Created by Auro on 30/04/23 at 7:11 AM
///

class RecommendedRestaurantsController extends GetxController
    with StateMixin<List<Restaurant>> {
  @override
  void onInit() {
    super.onInit();
  }

  void getData() async {
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(
        ApiRoutes.recommendedRestaurants,
        query: {
          '\$limit': -1,
        },
      );

      final response =
          List<Restaurant>.from(result.data.map((e) => Restaurant.fromJson(e)));
      change(response,
          status: response.isEmpty ? RxStatus.empty() : RxStatus.success());
    } catch (e, s) {
      log("$e $s");
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}

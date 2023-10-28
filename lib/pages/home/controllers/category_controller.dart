import 'dart:developer';

import 'package:get/get.dart';
import 'package:platemate_user/api_services/base_api.dart';
import 'package:platemate_user/app_configs/api_routes.dart';
import 'package:platemate_user/data_models/category.dart';

///
/// Created by Auro on 29/04/23 at 10:16 PM
///

class CategoryController extends GetxController
    with StateMixin<List<Category>> {
  @override
  void onInit() {
    super.onInit();
  }

  void getData() async {
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(
        ApiRoutes.foodCategories,
        query: {
          '\$limit': -1,
        },
      );

      final response =
          List<Category>.from(result.data.map((e) => Category.fromJson(e)));
      change(response,
          status: response.isEmpty ? RxStatus.empty() : RxStatus.success());
    } catch (e, s) {
      log("$e $s");
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}

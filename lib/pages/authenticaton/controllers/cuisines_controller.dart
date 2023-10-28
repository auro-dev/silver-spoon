import 'dart:developer';

import 'package:get/get.dart';
import 'package:platemate_user/api_services/base_api.dart';
import 'package:platemate_user/app_configs/api_routes.dart';
import 'package:platemate_user/data_models/taste_preference.dart';

///
/// Created by Auro on 19/04/23 at 11:49 PM
///

class CuisinesController extends GetxController
    with StateMixin<List<CuisinePreference>> {
  void getData() async {
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(
        ApiRoutes.cuisines,
        query: {
          '\$sort[createdAt]': -1,
          'status': 1,
          '\$limit': -1,
        },
      );

      final response = List<CuisinePreference>.from(
          result.data.map((e) => CuisinePreference.fromJson(e)));
      change(response,
          status: response.isEmpty ? RxStatus.empty() : RxStatus.success());
    } catch (e, s) {
      log("$e $s");
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}

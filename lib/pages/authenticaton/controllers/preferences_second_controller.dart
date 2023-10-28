import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/api_services/base_api.dart';
import 'package:platemate_user/app_configs/api_routes.dart';
import 'package:platemate_user/data_models/taste_preference.dart';
import 'package:platemate_user/data_models/user.dart';
import 'package:platemate_user/global_controllers/user_controller.dart';
import 'package:platemate_user/utils/app_auth_helper.dart';
import 'package:platemate_user/utils/shared_preference_helper.dart';
import 'package:platemate_user/utils/snackbar_helper.dart';
import 'package:platemate_user/widgets/app_buttons/app_primary_button.dart';

///
/// Created by Auro on 04/03/23 at 1:13 AM
///

class PreferencesSecondController extends GetxController {
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();

  List<String> selectedFoodTypes = [];
  bool sweetTooth = false;
  double? oilLevel, spicyLevel;
  Map<String, dynamic> body = {};

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> args = Get.arguments ?? {};
    if (args["dietContext"] != null) {
      body["dietContext"] = args["dietContext"];
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  updateSweetTooth() {
    sweetTooth = !sweetTooth;
    update();
  }

  updateOilLevel(double v) {
    oilLevel = v;
    update();
  }

  updateSpicyLevel(double v) {
    spicyLevel = v;
    update();
  }

  selectFoodTypes(String value) {
    if (selectedFoodTypes.contains(value)) {
      selectedFoodTypes.remove(value);
    } else {
      selectedFoodTypes.add(value);
    }
    update();
  }

  void proceed() async {
    try {
      buttonKey.currentState?.showLoader();
      body.addAll({
        "sweetTooth": sweetTooth,
        if (oilLevel != null) "oilLevel": oilLevel,
        if (spicyLevel != null) "spicyLevel": spicyLevel,
        "cuisinePreferences": selectedFoodTypes,
      });
      final response =
          await ApiCall.post(ApiRoutes.tastePreferences, body: body);
      final datum = TastePreference.fromJson(response.data);
      UserResponse user = SharedPreferenceHelper.user!;
      user.user!.tastePreference = datum;
      SharedPreferenceHelper.storeUser(user: user);
      final userController = Get.isRegistered()
          ? Get.find<UserController>()
          : Get.put<UserController>(UserController(), permanent: true);
      userController.updateUser(user.user);
      buttonKey.currentState?.hideLoader();
      log("${SharedPreferenceHelper.user!.user!.tastePreference}");
      SnackBarHelper.show("Your taste preferences submitted.");
      AuthHelper.checkUserLevel();
    } catch (e, s) {
      log("Pref2_Page", error: e, stackTrace: s);
      SnackBarHelper.show(e.toString());
      buttonKey.currentState?.hideLoader();
    }

    // Get.offAllNamed(DashboardPage.routeName);
  }
}

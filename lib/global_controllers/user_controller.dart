import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:platemate_user/api_services/base_api.dart';
import 'package:platemate_user/app_configs/api_routes.dart';
import 'package:platemate_user/data_models/user.dart';
import 'package:platemate_user/utils/shared_preference_helper.dart';
import 'package:platemate_user/utils/snackbar_helper.dart';
import 'package:get/get.dart';

///
/// Created by Kumar Sunil from Boiler plate
///

class UserController extends GetxController with StateMixin<User> {
  Position? position;

  @override
  void onInit() {
    super.onInit();

    final user = SharedPreferenceHelper.user?.user;
    change(user, status: user == null ? RxStatus.empty() : RxStatus.success());
  }

  updateCurrentPosition(Position d) {
    position = d;
  }

  updateUser(User? user) {
    final u = SharedPreferenceHelper.user;
    if (u != null) {
      u.user = user;
      SharedPreferenceHelper.storeUser(user: u);
    }
    change(null, status: RxStatus.loading());
    change(user, status: RxStatus.success());
  }

  refreshUser() async {
    if (SharedPreferenceHelper.user == null) return;
    try {
      change(null, status: RxStatus.loading());

      final result = await ApiCall.get(
        ApiRoutes.user,
        id: SharedPreferenceHelper.user!.user!.id,
      );
      final updatedData = User.fromJson(result.data);
      // updateUser(updatedData);
      change(updatedData, status: RxStatus.success());
    } catch (e, s) {
      SnackBarHelper.show(e.toString());
      log("refreshUser", error: e, stackTrace: s);
    }
  }
}

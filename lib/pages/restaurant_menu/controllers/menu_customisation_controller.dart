import 'dart:developer';
import 'package:get/get.dart';
import 'package:platemate_user/api_services/base_api.dart';
import 'package:platemate_user/app_configs/api_routes.dart';
import 'package:platemate_user/data_models/menu_customisation.dart';
import 'package:platemate_user/data_models/restaurant.dart';

///
/// Created by Auro on 02/05/23 at 9:01 PM
///

class MenuCustomisationController extends GetxController
    with StateMixin<List<MenuCustomisation>> {
  String? menuItemId = '';
  Variant? selectedVariant;

  @override
  void onInit() {
    super.onInit();
  }

  saveId(String value) {
    menuItemId = value;
  }

  selectCustomisationValue(int i, String v) {

    List<MenuCustomisation> tempList = state ?? [];
    tempList[i].customisation.value = v;
    change(tempList, status: RxStatus.success());
  }

  selectVariant(Variant d) {
    log("on changed : ${d.id}");
    selectedVariant = d;
    update();
  }

  void getData() async {
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(
        ApiRoutes.menuCustomisations,
        query: {
          '\$limit': -1,
          '\$populate': 'customisation',
          'menuItem': '$menuItemId',
        },
      );

      final response = List<MenuCustomisation>.from(
          result.data.map((e) => MenuCustomisation.fromJson(e)));
      change(response,
          status: response.isEmpty ? RxStatus.empty() : RxStatus.success());
    } catch (e, s) {
      log("$e $s");
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}

import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:platemate_user/api_services/base_api.dart';
import 'package:platemate_user/app_configs/api_routes.dart';
import 'package:platemate_user/data_models/restaurant.dart';
import 'package:platemate_user/global_controllers/user_controller.dart';

///
/// Created by Auro on 25/04/23 at 7:03 PM
///

class RestaurantDetailsController extends GetxController
    with StateMixin<Restaurant> {
  String? restaurantId;
  String? tableId;
  List<MenuItemCategorySection> menuCategories = [];

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> args = Get.arguments ?? {};
    restaurantId = args['restaurantId'];
    tableId = args['tableId'];
  }

  @override
  void dispose() {
    super.dispose();
  }

  handleExpanded(int index) {
    menuCategories[index].visible = !menuCategories[index].visible;
    update();
  }

  getData() async {
    try {
      /// setting up current coordinates
      Position? currentPosition;
      if (Get.isRegistered<UserController>()) {
        final userController = Get.find<UserController>();
        currentPosition = userController.position;
      }

      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(
        ApiRoutes.restaurantMenuDetails,
        id: '$restaurantId',
        query: {
          if (currentPosition != null) "latitude": currentPosition.latitude,
          if (currentPosition != null) "longitude": currentPosition.longitude,
        },
      );
      final response = Restaurant.fromJson(result.data);

      /// arrange data a/c to the menu item category
      response.menuItems.forEach((element) {
        int index = menuCategories
            .indexWhere((e) => e.id == element.menuItemCategory!.id);

        if (index != -1) {
          // already there
          menuCategories[index].menuItems.add(element);
        } else {
          // new one
          menuCategories.add(
            MenuItemCategorySection(
              id: element.menuItemCategory!.id,
              name: element.menuItemCategory!.name,
              menuItems: [element],
            ),
          );
        }
      });

      change(response, status: RxStatus.success());
    } catch (e, s) {
      log("$e ::: $s");
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}

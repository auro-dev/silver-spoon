import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/api_services/base_api.dart';
import 'package:platemate_user/app_configs/api_routes.dart';
import 'package:platemate_user/data_models/restaurant.dart';
import 'package:platemate_user/pages/cart/controllers/cart_controller.dart';
import 'package:platemate_user/pages/orders/order_details_page.dart';

import '../../../widgets/app_buttons/app_primary_button.dart';

///
/// Created by Auro on 26/04/23 at 4:49 PM
///

class CheckOutController extends GetxController {
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  Restaurant? restaurant;
  String? tableId;
  String remarks = '';
  late CartController cartController;
  bool loading = false;

  onRemarksSaved(String? v) {
    remarks = v ?? '';
  }

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> args = Get.arguments ?? {};
    restaurant = args["restaurant"];
    tableId = args["table"];
    cartController = Get.isRegistered()
        ? Get.find<CartController>()
        : Get.put(CartController());
  }

  @override
  void dispose() {
    super.dispose();
  }

  showLoading() {
    loading = true;
    update();
  }

  hideLoading() {
    loading = false;
    update();
  }

  proceed() async {
    try {
      showLoading();
      Map<String, dynamic> body = {
        "items": cartController.state!
            .map(
              (e) => {
                "menuItem": "${e.menuItem.id}",
                "quantity": e.quantity,
                "variant": {
                  "title": "${e.variant.title}",
                  "price": e.variant.price,
                },
                "customisations": e.customisations
                    .map(
                      (c) => {
                        "title": "${c.title}",
                        "type": c.type,
                        "value": "${c.value}",
                      },
                    )
                    .toList(),
              },
            )
            .toList(),
        "table": "${tableId}",
        "restaurant": "${restaurant!.createdBy}",
        "restaurantDetails": "${restaurant!.id}",
        "notes": remarks,
      };
      final result = await ApiCall.post(ApiRoutes.order, body: body);
      hideLoading();

      Get.offAndToNamed(
        OrderDetailsPage.routeName,
        arguments: {
          "order": result.data['_id'],
          "tableId": tableId,
          "restaurantId": restaurant!.id,
        },
      );
    } catch (err) {
      hideLoading();
      log("ERROR : : $err");
    }
  }
}

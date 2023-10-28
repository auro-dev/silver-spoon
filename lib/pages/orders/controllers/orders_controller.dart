import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/api_services/base_api.dart';
import 'package:platemate_user/app_configs/api_routes.dart';
import 'package:platemate_user/data_models/order.dart';

///
/// Created by Auro on 30/04/23 at 9:14 AM
///

class OrdersController extends GetxController with StateMixin<List<Order>> {
  int skip = 0, limit = 20, total = 0;
  bool shouldLoadMore = true;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      final maxGeneralScroll = scrollController.position.maxScrollExtent;
      final currentGeneralScroll = scrollController.position.pixels;
      if (maxGeneralScroll <= currentGeneralScroll) {
        getMoreData();
      }
    });
  }

  magicApiCall() async {
    skip = 0;
    shouldLoadMore = true;
    try {
      final result = await ApiCall.get(
        ApiRoutes.order,
        query: {
          '\$sort[createdAt]': -1,
          '\$skip': skip,
          '\$limit': limit,
          '\$populate': ["orderedItems.menuItem", "restaurantDetails"],
        },
      );

      final response =
          List<Order>.from(result.data["data"].map((e) => Order.fromJson(e)));
      if (response.length < limit) {
        shouldLoadMore = false;
      }
      change(response, status: RxStatus.success());
    } catch (e, s) {}
  }

  void getData() async {
    skip = 0;
    shouldLoadMore = true;
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(
        ApiRoutes.order,
        query: {
          '\$sort[createdAt]': -1,
          '\$skip': skip,
          '\$limit': limit,
          '\$populate': ["orderedItems.menuItem", "restaurantDetails"],
        },
      );

      log("$result");

      final response =
          List<Order>.from(result.data["data"].map((e) => Order.fromJson(e)));
      if (response.length < limit) {
        shouldLoadMore = false;
      }
      change(response,
          status: response.isEmpty ? RxStatus.empty() : RxStatus.success());
    } catch (e, s) {
      log("$e $s");
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void getMoreData() async {
    if (shouldLoadMore && !status.isLoadingMore) {
      skip = state!.length;
      try {
        change(state, status: RxStatus.loadingMore());
        final result = await ApiCall.get(
          ApiRoutes.order,
          query: {
            '\$sort[createdAt]': -1,
            '\$skip': skip,
            '\$limit': limit,
            '\$populate': ["orderedItems.menuItem", "restaurantDetails"],
          },
        );

        final response =
            List<Order>.from(result.data["data"].map((e) => Order.fromJson(e)));
        if (response.length < limit) {
          shouldLoadMore = false;
        }
        change((state ?? []) + response, status: RxStatus.success());
      } catch (e) {
        change(null, status: RxStatus.error(e.toString()));
      }
    }
  }
}

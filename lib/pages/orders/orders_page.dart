import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/pages/orders/controllers/orders_controller.dart';
import 'package:platemate_user/pages/orders/widgets/order_tile.dart';
import 'package:platemate_user/widgets/app_error_widget.dart';

///
/// Created by Auro on 25/02/23 at 10:43 PM
///

class OrdersPage extends StatefulWidget {
  static const routeName = '/orders';

  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late OrdersController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<OrdersController>()
        ? Get.find<OrdersController>()
        : Get.put(OrdersController());
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: Text(
          "My orders",
          style: TextStyle(
              // color: Colors.white,
              ),
        ),
        // elevation: 1,
        // backgroundColor: AppColors.brightPrimary,
        backgroundColor: Colors.white,
        elevation: 0.2,
      ),
      body: controller.obx(
        (state) {
          if (controller.status.isSuccess && state != null) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.getData();
              },
              child: ListView.separated(
                controller: controller.scrollController,
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: state.length,
                separatorBuilder: (c, i) => const SizedBox(height: 16),
                itemBuilder: (c, i) => OrderTile(state[i]),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
        onError: (e) => AppErrorWidget(title: e ?? 'Some error occurred'),
        onEmpty: AppEmptyWidget(title: 'No orders found'),
        // onLoading: FavoritesShimmer(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/pages/cart/controllers/cart_controller.dart';
import 'package:platemate_user/pages/cart/widgets/cart_details_bar.dart';
import 'package:platemate_user/pages/checkout/checkout_page.dart';
import 'package:platemate_user/pages/restaurant_details/controllers/restaurant_details_controller.dart';
import 'package:platemate_user/pages/restaurant_details/widgets/menu_category_section.dart';
import 'package:platemate_user/pages/restaurant_menu/widgets/menu_restaurant_details.dart';
import 'package:platemate_user/widgets/app_buttons/app_back_button.dart';
import 'package:platemate_user/widgets/my_divider.dart';

///
/// Created by Auro on 26/04/23 at 9:38 PM
///

class RestaurantMenuPage extends StatefulWidget {
  static final routeName = '/Restaurant-Menu-Page';

  const RestaurantMenuPage({Key? key}) : super(key: key);

  @override
  State<RestaurantMenuPage> createState() => _RestaurantMenuPageState();
}

class _RestaurantMenuPageState extends State<RestaurantMenuPage> {
  late RestaurantDetailsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(RestaurantDetailsController());
    controller.onInit();
    controller.getData();
    clearCartAndProceed();
  }

  clearCartAndProceed() {
    final cartController = Get.isRegistered<CartController>()
        ? Get.find<CartController>()
        : Get.put(CartController());
    cartController.clearCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ordering Menu"),
        centerTitle: true,
        leading: RoundedBackButton(),
        backgroundColor: Colors.white,
      ),
      body: controller.obx(
        (state) {
          if (state != null) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      MenuRestaurantDetails(state),
                      const SizedBox(height: 16),
                      GetBuilder(
                        init: controller,
                        builder: (c) => ListView.separated(
                          padding: const EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (c, i) => MenuCategorySection(
                            controller.menuCategories[i],
                            onTap: () => controller.handleExpanded(i),
                            canModifyCount: true,
                          ),
                          separatorBuilder: (c, i) => MyDivider(),
                          itemCount: controller.menuCategories.length,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                CartDetailsBar(
                  btnName: "Proceed to checkout",
                  onTap: () {
                    Get.toNamed(
                      CheckOutPage.routeName,
                      arguments: {
                        "restaurant": controller.state,
                        "table": controller.tableId,
                      },
                    );
                  },
                ),
              ],
            );
          }
          return SizedBox();
        },
        onError: (e) => Center(child: Text("$e")),
      ),
    );
  }
}

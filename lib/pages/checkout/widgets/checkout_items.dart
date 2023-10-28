import 'package:flutter/material.dart';
import 'package:platemate_user/data_models/order.dart';
import 'package:platemate_user/pages/checkout/widgets/cart_item_tile.dart';
import 'package:platemate_user/widgets/app_title.dart';
import 'package:platemate_user/widgets/my_divider.dart';

///
/// Created by Auro on 26/04/23 at 3:41 PM
///

class CheckOutItemsSection extends StatelessWidget {
  final List<OrderedItem> data;

  const CheckOutItemsSection(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MediumTitleText("Cart items"),
          const SizedBox(height: 16),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (c, i) => CartItemTile(data[i]),
            separatorBuilder: (c, i) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: MyDivider(),
            ),
            itemCount: data.length,
          ),
        ],
      ),
    );
  }
}

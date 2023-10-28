import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platemate_user/app_configs/app_assets.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/data_models/order.dart';
import 'package:platemate_user/widgets/app_title.dart';
import 'package:platemate_user/widgets/my_divider.dart';

///
/// Created by Auro on 01/05/23 at 10:01 PM
///

class OrderedItems extends StatelessWidget {
  final List<OrderedItem> data;

  const OrderedItems(this.data, {Key? key}) : super(key: key);

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
          MediumTitleText("Ordered items"),
          const SizedBox(height: 16),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (c, i) => OrderedItemTile(data[i]),
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

class OrderedItemTile extends StatelessWidget {
  final OrderedItem datum;

  const OrderedItemTile(this.datum, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.veg,
                    height: 14,
                    color: datum.menuItem.dietContext == 2
                        ? Color(0xffF54D3D)
                        : Colors.green,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      '${datum.menuItem.name} ( x ${datum.quantity} )',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Customization",
                      style: TextStyle(
                        color: AppColors.grey40,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(AppAssets.arrow, height: 6),
                ],
              ),
            ],
          ),
        ),
        Text(
          'Rs. ${(datum.variant.price * datum.quantity).toStringAsFixed(1)}',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/data_models/order.dart';
import 'package:platemate_user/pages/orders/order_details_page.dart';
import 'package:platemate_user/widgets/app_order_status_widget.dart';
import 'package:platemate_user/widgets/my_image.dart';

///
/// Created by Auro on 30/04/23 at 2:08 PM
///

class OrderTile extends StatelessWidget {
  final Order datum;

  const OrderTile(this.datum);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(
        //   color: AppColors.borderColor.withOpacity(0.3),
        // ),
      ),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(
            OrderDetailsPage.routeName,
            arguments: {
              "order": datum.id,
            },
          );
        },
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: MyImage(
                  "${datum.orderedItems.first.menuItem.avatar}",
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            datum.orderedItems.length == 1
                                ? "${datum.orderedItems.first.menuItem.name}"
                                : "${datum.orderedItems.first.menuItem.name} & ${(datum.orderedItems.length - 1)} more",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 10),
                        AppOrderStatusWidget(
                          datum.status,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Order ID : ${datum.bookingId}",
                      style: TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "₹${datum.price.finalPrice}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

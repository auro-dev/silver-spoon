import 'package:flutter/material.dart';

///
/// Created by Auro on 21/01/22 at 6:37 pm
///

class AppPriceWidget extends StatelessWidget {
  final double totalPrice, discount;
  final double? deliveryCharges, couponDiscount, taxPercentage;
  final String? coupon;

  const AppPriceWidget(this.totalPrice, this.discount,
      {this.deliveryCharges,
      this.coupon,
      this.couponDiscount,
      this.taxPercentage});

  @override
  Widget build(BuildContext context) {
    final double discountPercentage = (discount / totalPrice) * 100;
    final double taxAmount = totalPrice * ((taxPercentage ?? 0) / 100);
    final discountTextStyle = TextStyle(color: const Color(0xff56AB18));
    final double netTotal = (totalPrice + (deliveryCharges ?? 0)) -
        discount -
        (couponDiscount ?? 0) -
        taxAmount;
    final netTotalTextStyle =
        TextStyle(fontWeight: FontWeight.w600, fontSize: 16);
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Text('Subtotal'),
            Spacer(),
            Text('₹${totalPrice.toStringAsFixed(2)}'),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text('Discount (${discountPercentage.toStringAsFixed(0)}%)',
                style: discountTextStyle),
            Spacer(),
            Text('-₹${discount.toStringAsFixed(2)}', style: discountTextStyle),
          ],
        ),
        const SizedBox(height: 8),
        if (couponDiscount != null) ...[
          Row(
            children: [
              Text('Coupon (${coupon?.toUpperCase() ?? ''})',
                  style: discountTextStyle),
              Spacer(),
              Text('-₹${couponDiscount!.toStringAsFixed(2)}',
                  style: discountTextStyle),
            ],
          ),
          const SizedBox(height: 8)
        ],
        if (deliveryCharges != null)
          Row(
            children: [
              Text('Travel charge'),
              Spacer(),
              Text(
                  '${deliveryCharges != null && deliveryCharges != 0 ? deliveryCharges : 'Free'}'),
            ],
          ),
        if (taxPercentage != null)
          Row(
            children: [
              Text('Tax ($taxPercentage %)'),
              Spacer(),
              Text('₹$taxAmount'),
            ],
          ),
        Divider(),
        Row(
          children: [
            Expanded(
              child: Text(
                'Net total',
                //style: netTotalTextStyle,
              ),
            ),
            Text(
              '₹${netTotal.toStringAsFixed(2)}',
              style: netTotalTextStyle,
            ),
          ],
        ),
      ],
    );
  }
}

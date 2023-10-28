import 'package:flutter/material.dart';
import 'package:platemate_user/app_configs/app_colors.dart';

///
/// Created by Auro  on 21/01/22 at 9:27 pm
///

class PaymentTypeWidget extends StatelessWidget {
  final int currentType;
  final Function(int r)? onChanged;
  final bool online;
  final bool cod;
  final bool isPaid;

  const PaymentTypeWidget({
    Key? key,
    required this.currentType,
    this.onChanged,
    this.online = true,
    this.cod = true,
    this.isPaid = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xffEBECF2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          if (cod)
            InkWell(
              onTap: () {
                onChanged?.call(1);
              },
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text('Pay after service',
                        style: TextStyle(fontSize: 16)),
                  ),
                  Radio(
                      value: 1,
                      groupValue: currentType,
                      onChanged: (d) {
                        onChanged?.call(1);
                      }),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          if (online && cod) Divider(height: 3),
          if (online)
            InkWell(
              onTap: () {
                onChanged?.call(2);
              },
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text('Pay online', style: TextStyle(fontSize: 16)),
                  ),
                  isPaid
                      ? Row(
                          children: [
                            // SvgPicture.asset(
                            //   AppAssets.greenTick,
                            // ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                "Paid",
                                style: TextStyle(
                                  color: AppColors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        )
                      : Radio(
                          value: 2,
                          groupValue: currentType,
                          onChanged: (d) {
                            onChanged?.call(2);
                          }),
                  const SizedBox(width: 8),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

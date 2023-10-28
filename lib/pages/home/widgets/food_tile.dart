import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platemate_user/app_configs/app_assets.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/data_models/restaurant.dart';
import 'package:platemate_user/widgets/my_image.dart';
import 'package:platemate_user/utils/my_extensions.dart';

///
/// Created by Auro on 04/03/23 at 10:51 AM
///

class FoodTile extends StatelessWidget {
  final MenuItem datum;

  const FoodTile(this.datum, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minPriceVariants = datum.variants.sortedBy((e) => e.price);

    return Container(
      width: 240,
      clipBehavior: Clip.antiAlias,
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.grey80,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppAssets.veg),
                  const SizedBox(height: 6),
                  Text(
                    "${datum.name}",
                    style: TextStyle(
                      color: AppColors.grey20,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Rs. ${minPriceVariants.first.price}",
                    style: TextStyle(
                      color: AppColors.grey20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          MyImage(
            "${datum.avatar}",
            width: 80,
            fit: BoxFit.cover,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/data_models/restaurant.dart';
import 'package:platemate_user/widgets/my_image.dart';
import '../../../app_configs/app_assets.dart';

///
/// Created by Auro on 26/04/23 at 3:17 PM
///

class CheckOutRestaurantDetails extends StatelessWidget {
  final Restaurant datum;

  const CheckOutRestaurantDetails(this.datum, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: MyImage(
              "${datum.avatar}",
              fit: BoxFit.cover,
              width: 60,
              height: 60,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ordering at",
                  style: TextStyle(
                    color: AppColors.grey40,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "${datum.name}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          RotatedBox(
            quarterTurns: 1,
            child: SvgPicture.asset(AppAssets.arrow),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platemate_user/app_configs/app_assets.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/data_models/restaurant.dart';
import 'package:platemate_user/utils/common_functions.dart';
import 'package:platemate_user/utils/my_extensions.dart';
import 'package:platemate_user/widgets/my_divider.dart';

///
/// Created by Auro on 25/04/23 at 7:29 PM
///

class RestaurantDetailsSection extends StatelessWidget {
  final Restaurant datum;

  const RestaurantDetailsSection(this.datum, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    DateTime openingTime = datum.openingTime!
        .toLocal()
        .withDate(currentTime.year, currentTime.month, currentTime.day);
    DateTime closingTime = datum.closingTime!
        .toLocal()
        .withDate(currentTime.year, currentTime.month, currentTime.day);

    bool isOpen = currentTime.isAfterOrEqual(openingTime) &&
        currentTime.isBeforeOrEqual(closingTime);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.location_on_rounded),
              const SizedBox(width: 4),
              Text(
                '${(datum.distance! / 1000).toStringAsFixed(1)} kms away ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "  |  ${isOpen ? "Open now" : "Closed"}",
                style: TextStyle(
                  color: isOpen ? Colors.green : Colors.red,
                ),
              ),
              Spacer(),
              if (datum.coordinates.isNotEmpty)
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(AppAssets.share),
                  ),
                  onTap: () {
                    openMap(datum.coordinates[1], datum.coordinates[0]);
                  },
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "${datum.address.addressLine}, ${datum.address.city}, ${datum.address.state} - ${datum.address.pinCode}",
            style: TextStyle(
              color: AppColors.grey40,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          MyDivider(),
          const SizedBox(height: 12),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: SvgPicture.asset(AppAssets.star, height: 24),
              ),
              const SizedBox(width: 10),
              Text(
                "${datum.averageRating!.toStringAsFixed(1)}",
                style: TextStyle(
                  color: AppColors.rating_yellow,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "( ${datum.totalRatings} ratings )",
                style: TextStyle(
                  color: AppColors.grey40,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                "Rs. ${datum.averagePrice}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                " for two",
                style: TextStyle(
                  color: AppColors.grey40,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                height: 4,
                width: 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.grey40,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "${datum.discountPercentage.toStringAsFixed(1)}% off",
                style: TextStyle(
                  color: AppColors.orange,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

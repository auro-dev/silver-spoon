import 'package:flutter/material.dart';

import '../../../app_configs/app_colors.dart';

///
/// Created by Auro on 04/03/23 at 10:05 AM
///

class LocationPicker extends StatelessWidget {
  const LocationPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                color: Color(0xff333333),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  "Bhubaneswar",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.grey20,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.grey20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

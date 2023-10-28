import 'package:flutter/material.dart';
import 'package:platemate_user/app_configs/app_colors.dart';

///
/// Created by Auro on 19/01/22 at 7:26 pm
///

class SheetTopBar extends StatelessWidget {
  final String title;
  final String subTitle;

  const SheetTopBar({this.title = '', this.subTitle = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          child: Text(
            "$title",
            style: TextStyle(
              color: AppColors.brightPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: Text(
            "$subTitle",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:platemate_user/app_configs/app_colors.dart';

///
/// Created by Auro on 04/02/22 at 5:07 pm
///

class ProfileTile extends StatelessWidget {
  final String asset;
  final String title;
  final VoidCallback? onTap;
  final bool isColored;
  final bool isBottomBorder;
  final bool isTopBorder;

  const ProfileTile(
      {this.asset = '',
      this.title = '',
      this.onTap,
      this.isColored = false,
      this.isBottomBorder = true,
      this.isTopBorder = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            // border: Border(
            //   bottom: BorderSide(
            //     color: isBottomBorder
            //         ? Colors.grey.withOpacity(0.2)
            //         : Colors.transparent,
            //   ),
            //   top: BorderSide(
            //     color: isTopBorder
            //         ? Colors.grey.withOpacity(0.2)
            //         : Colors.transparent,
            //   ),
            // ),
            ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: SvgPicture.asset(
                asset,
                height: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
                child: Text(
              "$title",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isColored ? AppColors.brightPrimary : Color(0xff323232),
              ),
            )),
            Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: Color(0xff323232),
            )
          ],
        ),
      ),
    );
  }
}

///
/// Created by Auro on 18/04/23 at 1:58 AM
///

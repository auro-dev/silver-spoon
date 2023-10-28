import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/widgets/my_image.dart';
import '../../../app_configs/app_assets.dart';

///
/// Created by Auro on 25/04/23 at 5:59 PM
///

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double topPadding;

  MySliverAppBar({required this.expandedHeight, this.topPadding = 0});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double secondaryTextOpacity =
        max(0, 1 - (shrinkOffset / expandedHeight) * 2.6);
    double imageOpacity = max(0, 1 - (shrinkOffset / expandedHeight) * 1.2);
    return ColoredBox(
      color: AppColors.brightPrimary,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 1,
            child: SafeArea(
              child: AppBar(
                backgroundColor: AppColors.brightPrimary,
                titleSpacing: 0,
                title: Text(
                  "Bonfire Food Court",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Opacity(
            opacity: imageOpacity,
            child: MyImage(
              "https://d4t7t8y8xqo0t.cloudfront.net/resized/750X436/eazytrendz%2F2953%2Ftrend20201009113426.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: imageOpacity,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: topPadding,
            left: 10,
            child: Opacity(
              opacity: secondaryTextOpacity,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: SvgPicture.asset(
                    AppAssets.back_button,
                    color: Colors.white,
                    height: 32,
                    width: 32,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20 + shrinkOffset * 0.3,
            left: 20 + shrinkOffset * 0.58,
            child: Opacity(
              opacity: secondaryTextOpacity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bonfire Food Court",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "North Indian, Chinese",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + topPadding;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

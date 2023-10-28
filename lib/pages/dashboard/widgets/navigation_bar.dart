import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:platemate_user/app_configs/app_assets.dart';
import 'package:platemate_user/pages/dashboard/dashboard_page.dart';
import '../../../app_configs/app_colors.dart';

///
/// Created by Auro on 19/01/22 at 12:31 am
///

class BottomNavBar extends StatelessWidget {
  final Function(int)? onPageChange;

  const BottomNavBar({this.onPageChange});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dashboardIndexNotifier,
      builder: (ctx, value, _) => Container(
        height: 69,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: dashboardIndexNotifier.value,
          selectedItemColor: Color(0xff333333),
          onTap: onPageChange,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 6, top: 1),
                child: SvgPicture.asset(
                  AppAssets.home,
                  color: dashboardIndexNotifier.value == 0
                      ? AppColors.brightPrimary
                      : Color(0xff999999),
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 6, top: 1),
                child: SvgPicture.asset(
                  AppAssets.order,
                  color: dashboardIndexNotifier.value == 1
                      ? AppColors.brightPrimary
                      : null,
                ),
              ),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 6, top: 1),
                child: SvgPicture.asset(
                  AppAssets.profile,
                  color: dashboardIndexNotifier.value == 2
                      ? AppColors.brightPrimary
                      : null,
                ),
              ),
              label: 'Profile',
            ),
          ],
        ),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color(0xff4F4F4F).withOpacity(0.05),
            offset: Offset(0, -4),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ]),
      ),
    );
  }
}

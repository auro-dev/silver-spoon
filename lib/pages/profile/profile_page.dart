import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/app_configs/app_assets.dart';
import 'package:platemate_user/app_configs/environment.dart';
import 'package:platemate_user/global_controllers/user_controller.dart';
import 'package:platemate_user/pages/authenticaton/login/login_page.dart';
import 'package:platemate_user/pages/profile/widgets/profile_card.dart';
import 'package:platemate_user/pages/profile/widgets/profile_tile.dart';
import 'package:platemate_user/pages/web_view/web_view_page.dart';
import 'package:platemate_user/utils/dialog_helper.dart';
import 'package:platemate_user/utils/shared_preference_helper.dart';

///
/// Created by Auro on 25/02/23 at 10:43 PM
///

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Profile",
      //     style: TextStyle(
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: GetBuilder(
          init: userController,
          builder: (ctx) {
            return userController.obx((state) {
              return ListView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  ProfileCard(
                    state,
                    onUpdated: () {
                      final u = SharedPreferenceHelper.user!.user;
                      if (u != null) {
                        userController.updateUser(u);
                      }
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(
                        //     offset: Offset(0, 0),
                        //     blurRadius: 10,
                        //     spreadRadius: 0,
                        //     color: Color(0xff1A1A1A).withOpacity(0.1),
                        //   ),
                        // ],
                        ),
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            if (state != null)
                              ProfileTile(
                                asset: AppAssets.fav,
                                title: "My Favorites",
                                onTap: () {
                                  // if (SharedPreferenceHelper.user != null) {
                                  //   Get.toNamed(
                                  //     DashboardPage.routeName +
                                  //         FavoritesPage.routeName,
                                  //   );
                                  // } else {
                                  //   Get.toNamed(
                                  //     LoginPage.routeName,
                                  //     arguments: {
                                  //       "parent": Get.currentRoute,
                                  //     },
                                  //   );
                                  // }
                                },
                              ),
                            ProfileTile(
                              asset: AppAssets.rate,
                              title: "Rate us",
                              onTap: () {
                                // if (SharedPreferenceHelper.user != null) {
                                //   Get.toNamed(
                                //     DashboardPage.routeName +
                                //         GalleryPage.routeName,
                                //   );
                                // } else {
                                //   Get.toNamed(
                                //     LoginPage.routeName,
                                //     arguments: {
                                //       "parent": Get.currentRoute,
                                //     },
                                //   );
                                // }
                              },
                            ),
                            ProfileTile(
                              asset: AppAssets.about_us,
                              title: "About Us",
                              onTap: () {
                                Get.toNamed(
                                  WebViewPage.routeName,
                                  arguments: {
                                    "appBarName": "About Us",
                                    // "url": Environment.aboutUs,
                                  },
                                );
                              },
                            ),
                            ProfileTile(
                              asset: AppAssets.contact,
                              title: "Contact Us",
                              onTap: () {},
                            ),
                            ProfileTile(
                              asset: AppAssets.faq,
                              title: "FAQs",
                              onTap: () {
                                Get.toNamed(
                                  WebViewPage.routeName,
                                  arguments: {
                                    "appBarName": "FAQs",
                                    "url": Environment.privacyUrl,
                                  },
                                );
                              },
                            ),
                            ProfileTile(
                              asset: AppAssets.privacy,
                              title: "Privacy Policy",
                              onTap: () {
                                Get.toNamed(
                                  WebViewPage.routeName,
                                  arguments: {
                                    "appBarName": "Privacy Policy",
                                    "url": Environment.privacyUrl,
                                  },
                                );
                              },
                            ),
                            ProfileTile(
                              asset: AppAssets.terms,
                              title: "Terms and Conditions",
                              onTap: () {
                                Get.toNamed(
                                  WebViewPage.routeName,
                                  arguments: {
                                    "appBarName": "Terms and Conditions",
                                    "url": Environment.privacyUrl,
                                  },
                                );
                              },
                            ),
                            if (state != null)
                              ProfileTile(
                                isBottomBorder: false,
                                asset: AppAssets.log_out,
                                title: "Logout",
                                isColored: true,
                                onTap: () {
                                  showMyDialog(
                                      title: 'Are you sure you want to logout?',
                                      positiveCallback: () {
                                        Get.back();
                                        userController.updateUser(null);
                                        SharedPreferenceHelper.logout();
                                        Get.offAllNamed(LoginPage.routeName);
                                      });
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            });
          },
        ),
      ),
    );
  }
}

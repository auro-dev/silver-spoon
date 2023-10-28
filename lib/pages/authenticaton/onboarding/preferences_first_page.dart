import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/global_controllers/user_controller.dart';
import 'package:platemate_user/pages/authenticaton/controllers/preferences_first_controller.dart';
import 'package:platemate_user/pages/authenticaton/login/login_page.dart';
import 'package:platemate_user/utils/dialog_helper.dart';
import 'package:platemate_user/utils/shared_preference_helper.dart';

import '../../../app_configs/app_assets.dart';
import '../../../widgets/app_buttons/app_primary_button.dart';
import '../signup/signup_page.dart';

///
/// Created by Auro on 04/03/23 at 12:42 AM
///

class PreferencesFirstPage extends StatefulWidget {
  static const routeName = '/preference-first-page';

  const PreferencesFirstPage({Key? key}) : super(key: key);

  @override
  State<PreferencesFirstPage> createState() => _PreferencesFirstPageState();
}

class _PreferencesFirstPageState extends State<PreferencesFirstPage> {
  late PreferencesFirstController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = PreferencesFirstController();
    _controller.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(AppAssets.back_button),
        ),
        actions: [
          TextButton(
            onPressed: () {
              showMyDialog(
                title: 'Are you sure you want to logout?',
                positiveCallback: () {
                  Get.back();
                  final userController = Get.find<UserController>();
                  userController.updateUser(null);
                  SharedPreferenceHelper.logout();
                  Get.offAllNamed(LoginPage.routeName);
                },
              );
            },
            child: Text("Logout"),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GetBuilder(
                init: _controller,
                builder: (c) => ListView(
                  physics:
                      BouncingScrollPhysics(parent: ClampingScrollPhysics()),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    LargeTitle("What is your preference?"),
                    const SizedBox(height: 8),
                    ..._controller.preferenceList.map((e) {
                      int index = _controller.preferenceList.indexOf(e);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => _controller.selectIndex(index),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: index == _controller.selectedIndex
                                    ? AppColors.brightPrimary
                                    : AppColors.grey80,
                              ),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  index == _controller.selectedIndex
                                      ? AppAssets.check_enabled
                                      : AppAssets.check_disabled,
                                ),
                                const SizedBox(width: 16),
                                Expanded(child: Text("$e")),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AppPrimaryButton(
                  child: Text("Next".toUpperCase()),
                  onPressed: _controller.proceed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

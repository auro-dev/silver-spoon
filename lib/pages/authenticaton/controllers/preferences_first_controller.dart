import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/pages/authenticaton/onboarding/preferences_second_page.dart';
import 'package:platemate_user/utils/snackbar_helper.dart';
import 'package:platemate_user/widgets/app_buttons/app_primary_button.dart';

///
/// Created by Auro on 04/03/23 at 1:13 AM
///

class PreferencesFirstController extends GetxController {
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  List<String> preferenceList = [
    'Vegetarian',
    'Non Vegetarian',
    'Vegan',
    'Pure Veg - without onion & garlic',
  ];

  int? selectedIndex;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  selectIndex(int c) {
    selectedIndex = c;
    update();
  }

  void proceed() async {
    if (selectedIndex == null) {
      SnackBarHelper.show("Please select any of them to proceed");
      return;
    }
    Get.toNamed(
      PreferencesSecondPage.routeName,
      arguments: {
        "dietContext": (selectedIndex ?? 0) + 1,
      },
    );
  }
}

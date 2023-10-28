import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/api_services/base_api.dart';
import 'package:platemate_user/pages/authenticaton/onboarding/preferences_first_page.dart';
import 'package:platemate_user/utils/app_auth_helper.dart';
import 'package:platemate_user/utils/snackbar_helper.dart';

import '../../../widgets/app_buttons/app_primary_button.dart';
import '../../../widgets/photo_chooser.dart';

///
/// Created by Auro on 04/03/23 at 12:26 AM
///

class AvatarSelectionController extends GetxController {
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  File? image;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void chooseImages() async {
    final result = await Get.bottomSheet(
      PhotoChooser(),
      backgroundColor: Color(0xffffffff),
    );

    if (result != null) {
      image = result;
      update();
    }
  }

  removeImage() {
    image = null;
    update();
  }

  void proceed() async {
    try {
      if (image != null) {
        buttonKey.currentState?.showLoader();
        final url = await ApiCall.singleFileUpload(image!);
        await AuthHelper.updateUser({"avatar": url});
        buttonKey.currentState?.hideLoader();
        SnackBarHelper.show("Profile picture updated");
      }
      AuthHelper.checkUserLevel();
    } catch (e, s) {
      log("Signup_Page", error: e, stackTrace: s);
      SnackBarHelper.show(e.toString());
      buttonKey.currentState?.hideLoader();
    }
  }
}

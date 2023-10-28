import 'dart:developer';

import 'package:platemate_user/data_models/user.dart';
import 'package:platemate_user/global_controllers/user_controller.dart';
import 'package:platemate_user/pages/authenticaton/onboarding/avatar_selection_page.dart';
import 'package:platemate_user/utils/app_auth_helper.dart';
import 'package:platemate_user/utils/shared_preference_helper.dart';
import 'package:platemate_user/utils/snackbar_helper.dart';
import 'package:platemate_user/widgets/app_buttons/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  String _password_1 = '', _password_2 = '';
  String _emailId = '';
  String _name = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late Rx<AutovalidateMode> autoValidateMode;
  String? parentPath;
  RxBool isObscure = RxBool(true);

  @override
  void onInit() {
    super.onInit();
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
  }

  @override
  void dispose() {
    autoValidateMode.close();
    isObscure.close();
    super.dispose();
  }

  void onNameSaved(String? newValue) {
    _name = newValue!.trim();
  }

  void onEmailSaved(String? newValue) {
    _emailId = newValue!.trim();
  }

  void onPasswordSaved(String? newValue) {
    _password_1 = newValue!.trim();
  }

  void onConfirmPasswordSaved(String? newValue) {
    _password_2 = newValue!.trim();
  }

  void visibilityChange() {
    isObscure.value = !isObscure.value;
  }

  void proceed() {
    // Get.toNamed(AvatarSelectionPage.routeName);
    // return;
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      state.save();
      buttonKey.currentState?.showLoader();
      if (_password_1 != _password_2) {
        SnackBarHelper.show("Both the passwords should be same");
        return;
      }
      AuthHelper.registerUser(_name, _emailId, _password_1).then((value) {
        final String accessToken = value['accessToken'];
        final datum = UserResponse.fromJson(value);
        SharedPreferenceHelper.storeUser(user: datum);
        SharedPreferenceHelper.storeAccessToken(accessToken);
        final userController = Get.isRegistered()
            ? Get.find<UserController>()
            : Get.put<UserController>(UserController(), permanent: true);
        userController.updateUser(datum.user);
        SnackBarHelper.show("Account created successfully");
        Get.offAllNamed(AvatarSelectionPage.routeName);
      }).catchError((e, s) {
        log("Signup_Page", error: e, stackTrace: s);
        SnackBarHelper.show(e.toString());
      }).whenComplete(() => buttonKey.currentState?.hideLoader());
    }
  }
}

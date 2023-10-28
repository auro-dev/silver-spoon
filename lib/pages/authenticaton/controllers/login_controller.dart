///
/// Created by Auro on 01/01/23 at 12:08 PM
///

import 'dart:developer';

import 'package:platemate_user/data_models/user.dart';
import 'package:platemate_user/global_controllers/user_controller.dart';
import 'package:platemate_user/utils/app_auth_helper.dart';
import 'package:platemate_user/utils/shared_preference_helper.dart';
import 'package:platemate_user/utils/snackbar_helper.dart';
import 'package:platemate_user/widgets/app_buttons/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  String _email = '';
  String _password = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late Rx<AutovalidateMode> autoValidateMode;
  String? parentPath;
  RxBool isObscure = RxBool(true);
  String? emailErr, passwordErr;

  @override
  void onInit() {
    super.onInit();
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
    final Map<String, dynamic>? map = Get.arguments ?? {};
    if (map != null) {
      parentPath = map['parent'];
    }
  }

  @override
  void dispose() {
    autoValidateMode.close();
    isObscure.close();
    super.dispose();
  }

  void onEmailSaved(String? newValue) {
    _email = newValue!.trim();
  }

  void onPasswordSaved(String? newValue) {
    _password = newValue!.trim();
  }

  void visibilityChange() {
    isObscure.value = !isObscure.value;
    update();
  }

  void proceed() async {
    if (_email.isEmpty) {
      emailErr = "Email id is required";
      update();
      return;
    } else {
      emailErr = null;
      update();
    }
    if (_password.isEmpty) {
      passwordErr = "Password is required";
      update();
      return;
    } else {
      passwordErr = null;
      update();
    }
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      state.save();
      buttonKey.currentState?.showLoader();
      AuthHelper.userLoginWithEmail(_email, _password).then((value) {
        final String accessToken = value['accessToken'];
        final user = UserResponse.fromJson(value);
        SharedPreferenceHelper.storeUser(user: user);
        SharedPreferenceHelper.storeAccessToken(accessToken);
        final userController = Get.isRegistered()
            ? Get.find<UserController>()
            : Get.put<UserController>(UserController(), permanent: true);
        userController.updateUser(user.user);
        SnackBarHelper.show("Login successful");
        AuthHelper.checkUserLevel(parentPath: parentPath);
      }).catchError((e, s) {
        log("Login_Phone_Password_Error", error: e, stackTrace: s);
        SnackBarHelper.show(e.toString());
      }).whenComplete(() => buttonKey.currentState?.hideLoader());
    }
  }
}

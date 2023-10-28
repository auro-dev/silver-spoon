import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:platemate_user/app_configs/app_assets.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/app_configs/app_decorations.dart';
import 'package:platemate_user/app_configs/app_validators.dart';
import 'package:platemate_user/app_configs/environment.dart';
import 'package:platemate_user/pages/authenticaton/controllers/signup_controller.dart';
import 'package:platemate_user/widgets/app_buttons/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:platemate_user/data_models/user.dart';
import 'package:platemate_user/utils/app_auth_helper.dart';
import 'package:platemate_user/utils/snackbar_helper.dart';
import 'package:platemate_user/widgets/app_loader.dart';

import '../login/login_page.dart';

///
/// Created by Auro on 27/10/22 at 8:05 PM
///

class SignupPage extends StatefulWidget {
  static const routeName = '/sign-up-page';

  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late SignupController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = SignupController();
    _controller.onInit();
  }

  void socialSignIn(int type) async {
    Get.key.currentState!.push(LoaderOverlay());
    try {
      UserResponse? user;
      switch (type) {
        case 1:
          user = await AuthHelper.userLoginWithGoogle();
          break;

        case 2:
          user = await AuthHelper.userLoginWithFacebook();
          break;

        case 3:
          user = await AuthHelper.userLoginWithApple();
          break;
      }
      if (user != null) {
        AuthHelper.checkUserLevel(parentPath: _controller.parentPath);
      } else {
        Get.key.currentState!.pop();
      }
    } catch (err, s) {
      Get.key.currentState!.pop();
      log('$err $s');
      SnackBarHelper.show("$err");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(AppAssets.back_button),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Get.focusScope!.unfocus();
        },
        child: SafeArea(
          child: Obx(
            () => Form(
              key: _controller.formKey,
              autovalidateMode: _controller.autoValidateMode.value,
              child: ListView(
                physics: BouncingScrollPhysics(parent: ClampingScrollPhysics()),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  LargeTitle("Create your account."),
                  TFTitle("Name"),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onChanged: _controller.onNameSaved,
                    validator: (data) =>
                        AppFormValidators.validateEmpty(data, context),
                    decoration:
                        AppDecorations.textFieldDecoration(context).copyWith(
                      hintText: "enter your name",
                    ),
                    keyboardType: TextInputType.name,
                    scrollPadding: EdgeInsets.only(bottom: 40),
                  ),
                  const SizedBox(height: 16),
                  TFTitle("Email"),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onChanged: _controller.onEmailSaved,
                    validator: (data) =>
                        AppFormValidators.validateMail(data, context),
                    decoration:
                        AppDecorations.textFieldDecoration(context).copyWith(
                      hintText: "example@mail.com",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    scrollPadding: EdgeInsets.only(bottom: 40),
                  ),
                  const SizedBox(height: 16),
                  TFTitle("Set Password"),
                  TextFormField(
                    obscureText: _controller.isObscure.value,
                    textInputAction: TextInputAction.next,
                    validator: (data) =>
                        AppFormValidators.validateEmpty(data, context),
                    onChanged: _controller.onPasswordSaved,
                    decoration:
                        AppDecorations.textFieldDecoration(context).copyWith(
                      hintText: "set a password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _controller.isObscure.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.labelColor,
                          size: 22,
                        ),
                        onPressed: _controller.visibilityChange,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TFTitle("Confirm Password"),
                  TextFormField(
                    obscureText: _controller.isObscure.value,
                    textInputAction: TextInputAction.done,
                    validator: (data) =>
                        AppFormValidators.validateEmpty(data, context),
                    onChanged: _controller.onConfirmPasswordSaved,
                    decoration:
                        AppDecorations.textFieldDecoration(context).copyWith(
                      hintText: "re-enter the password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _controller.isObscure.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.labelColor,
                          size: 22,
                        ),
                        onPressed: _controller.visibilityChange,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  AppPrimaryButton(
                    key: _controller.buttonKey,
                    child: Text("Create Account".toUpperCase()),
                    onPressed: _controller.proceed,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            height: 1.5,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xffffffff),
                                  Color(0xff999999),
                                ],
                              ),
                            )),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("or"),
                      ),
                      Expanded(
                        child: Container(
                            height: 1.5,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff999999),
                                  Color(0xffffffff),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: SocialIconButton(
                          asset: AppAssets.fb,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: SocialIconButton(
                          asset: AppAssets.google,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: SocialIconButton(
                          asset: AppAssets.apple,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "   Already have an account?",
                        style: TextStyle(
                          // fontWeight: FontWeight.w500,
                          fontFamily: Environment.fontFamily,
                          fontSize: 14,
                          color: Color(0xff868686),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' ' + "Login".toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.brightPrimary,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  // Get.toNamed(
                                  //   ForgotPasswordPage.routeName,
                                  //   arguments: {
                                  //     "parent": _loginController.parentPath,
                                  //   },
                                  // );
                                })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final String name;
  final String asset;
  final VoidCallback? onTap;

  const LoginButton({this.name = '', this.asset = '', this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 95,
        padding: const EdgeInsets.symmetric(vertical: 18),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: SvgPicture.asset(asset),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white)),
      ),
    );
  }
}

class LargeTitle extends StatelessWidget {
  final String text;

  const LargeTitle(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, top: 10),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 32,
        ),
      ),
    );
  }
}

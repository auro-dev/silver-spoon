import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:platemate_user/app_configs/app_assets.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/app_configs/app_decorations.dart';
import 'package:platemate_user/app_configs/app_validators.dart';
import 'package:platemate_user/app_configs/environment.dart';
import 'package:platemate_user/pages/authenticaton/controllers/login_controller.dart';
import 'package:platemate_user/pages/authenticaton/signup/signup_page.dart';
import 'package:platemate_user/pages/demo/create_footprint_page.dart';
import 'package:platemate_user/widgets/app_buttons/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:platemate_user/data_models/user.dart';
import 'package:platemate_user/utils/app_auth_helper.dart';
import 'package:platemate_user/utils/snackbar_helper.dart';
import 'package:platemate_user/widgets/app_loader.dart';

///
/// Created by Auro on 27/10/22 at 8:05 PM
///

class LoginPage extends StatefulWidget {
  static const routeName = '/login-page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _parentPath;
  late LoginController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic>? map = Get.arguments ?? {};
    if (map != null) {
      _parentPath = map['parent'] ?? "";
    }
    _controller = LoginController();
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
        AuthHelper.checkUserLevel(parentPath: _parentPath);
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
                  Image.asset(AppAssets.login),
                  const SizedBox(height: 40),
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
                  TFTitle("Password"),
                  TextFormField(
                    obscureText: _controller.isObscure.value,
                    textInputAction: TextInputAction.done,
                    validator: (data) =>
                        AppFormValidators.validateEmpty(data, context),
                    onChanged: _controller.onPasswordSaved,
                    decoration:
                        AppDecorations.textFieldDecoration(context).copyWith(
                      hintText: "enter your password",
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
                    child: Text("Login"),
                    onPressed: _controller.proceed,
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: "   Forgot your password? ",
                      style: TextStyle(
                        // fontWeight: FontWeight.w500,
                        fontFamily: Environment.fontFamily,
                        fontSize: 14,
                        color: Color(0xff868686),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' ' + "Reset password".toUpperCase(),
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
                  const SizedBox(height: 24),
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
                  const SizedBox(height: 24),
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
                          onTap: () {
                            Get.toNamed(CreateFootPrintsPage.routeName);
                          },
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
                  const SizedBox(height: 32),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "   New user? ",
                        style: TextStyle(
                          // fontWeight: FontWeight.w500,
                          fontFamily: Environment.fontFamily,
                          fontSize: 14,
                          color: Color(0xff868686),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' ' + "CREATE ACCOUNT".toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.brightPrimary,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  Get.toNamed(
                                    SignupPage.routeName,
                                  );
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

class TFTitle extends StatelessWidget {
  final String text;

  const TFTitle(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class SocialIconButton extends StatelessWidget {
  final String? asset;
  final VoidCallback? onTap;

  const SocialIconButton({Key? key, this.asset, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffE6E6E6)),
            borderRadius: BorderRadius.circular(12)),
        child: SvgPicture.asset(asset!),
      ),
    );
  }
}

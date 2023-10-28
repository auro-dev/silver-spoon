import 'dart:developer';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:platemate_user/pages/authenticaton/login/login_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:platemate_user/pages/authenticaton/onboarding/preferences_first_page.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:platemate_user/api_services/base_api.dart';
import 'package:platemate_user/app_configs/api_routes.dart';
import 'package:platemate_user/app_configs/environment.dart';
import 'package:platemate_user/data_models/user.dart';
import 'package:platemate_user/global_controllers/user_controller.dart';
import 'package:platemate_user/pages/dashboard/dashboard_page.dart';
import 'package:platemate_user/utils/shared_preference_helper.dart';
import 'package:get/get.dart';

import 'snackbar_helper.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AuthHelper {
  static Future<dynamic> userLoginWithEmail(
      String email, String password) async {
    final fcmId = await FirebaseMessaging.instance.getToken();
    final deviceInfo = await getDeviceDetails();
    Map<String, dynamic> body = {
      "strategy": "local",
      "email": "$email",
      "password": "$password",
      "deviceId": deviceInfo['deviceId'],
      "deviceType": deviceInfo['deviceType'],
      "deviceName": deviceInfo['deviceName'],
      "fcmId": fcmId,
    };
    final result = await ApiCall.post(
      ApiRoutes.authenticateEmail,
      body: body,
      isAuthNeeded: false,
    );
    return result.data;
  }

  /// send otp to phone
  static Future<dynamic> sendOTPToPhone(String phone,
      {bool login = false, String? operation}) async {
    Map<String, dynamic> body = {
      "phone": phone,
      "operation": operation != null
          ? operation
          : login
              ? "login"
              : "signup",
      "role": 3,
    };
    final result = await ApiCall.post(
      ApiRoutes.authentication,
      body: body,
      isAuthNeeded: operation != null ? true : false,
    );
    print('OTP result $result');
    SnackBarHelper.show("OTP sent to $phone");
    return result.data;
  }

  /// verify OTP
  static Future<UserResponse> verifyOtp(String phone, String otp,
      {bool login = false, String? operation}) async {
    final fcmId = await FirebaseMessaging.instance.getToken();
    // final Position latLng = await CheckPermissions.getCurrentLocation();

    final deviceInfo = await getDeviceDetails();
    // final fcmId = "345545644sffdsfdsdsssffsdf1dssdfse";

    Map<String, dynamic> body = {
      "phone": phone,
      "operation": operation != null
          ? operation
          : login
              ? "login"
              : "signup",
      "role": 3,
      "otp": otp,
      // "phone": phone,
      // "otp": otp,
      // "platform": deviceInfo['deviceType'],
      "fcmId": fcmId,
      // "deviceId": deviceInfo['deviceId'],
      // "deviceType": deviceInfo['deviceType'],
      // "deviceName": deviceInfo['deviceName'],
      // "role": 1,
    };
    final result = await ApiCall.patch(
      ApiRoutes.authentication,
      body: body,
      isAuthNeeded: operation != null ? true : false,
    );
    return UserResponse.fromJson(result.data);
  }

  /// register user
  static Future<dynamic> registerUser(
    String name,
    String email,
    String password,
  ) async {
    final fcmId = await FirebaseMessaging.instance.getToken();
    // final Position latLng = await CheckPermissions.getCurrentLocation();

    final deviceInfo = await getDeviceDetails();
    // final fcmId = "345545644sffdsfdsdsssffsdf1dssdfse";

    Map<String, dynamic> body = {
      "role": 3,
      "name": name,
      "email": email,
      "password": password,
      "deviceId": deviceInfo['deviceId'],
      "deviceType": deviceInfo['deviceType'],
      "deviceName": deviceInfo['deviceName'],
      "fcmId": fcmId,
    };
    final result = await ApiCall.post(
      ApiRoutes.user,
      body: body,
      isAuthNeeded: false,
    );
    return result.data;
  }

  static Future<Map<String, dynamic>> getDeviceDetails() async {
    String? deviceName;
    int? deviceType;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        deviceType = 1;
        final build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        //deviceVersion = build.version.toString();
      } else if (Platform.isIOS) {
        deviceType = 2;
        final data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        //deviceVersion = data.systemVersion;
      }
    } on PlatformException {
      throw 'Failed to get platform version';
    }
    return {
      "deviceId": Platform.isAndroid ? 1 : 2,
      "deviceName": deviceName,
      "deviceType": deviceType
    };
  }

  ///
  /// Normal user Google login
  /// On error it will throw [RestError]
  /// If cancelled it will return null
  ///
  static Future<UserResponse?> userLoginWithGoogle() async {
    GoogleSignIn _googleSignIn =
        GoogleSignIn(scopes: ['email'], clientId: Environment.googleClientId);
    try {
      // final Position latLng = await CheckPermissions.getCurrentLocation();

      final deviceInfo = await getDeviceDetails();
      final fcmId = await FirebaseMessaging.instance.getToken();
      // final fcmId = "345545644sffdsfdsdsssffsdf1dssdfse";
      GoogleSignInAccount? result = await _googleSignIn.signIn();
      if (result == null) {
        return null;
      }
      GoogleSignInAuthentication googleAuth = await result.authentication;
      log('TOKEN ${googleAuth.accessToken}');
      final resultMap = await ApiCall.post(ApiRoutes.social_login,
          body: {
            "accessToken": googleAuth.accessToken,
            "loginType": 1,
            "fcmId": fcmId,
            "deviceId": deviceInfo['deviceId'],
            "platform": deviceInfo['deviceType'],
          },
          isAuthNeeded: false);
      print("google-login result :::::$resultMap");
      final userResponse = UserResponse.fromJson(resultMap.data);
      SharedPreferenceHelper.storeUser(user: userResponse);
      SharedPreferenceHelper.storeAccessToken(userResponse.accessToken);
      final userController = Get.isRegistered()
          ? Get.find<UserController>()
          : Get.put<UserController>(UserController(), permanent: true);
      userController.updateUser(userResponse.user);
      return userResponse;
    } catch (e) {
      rethrow;
    } finally {
      _googleSignIn.signOut();
    }
  }

  ///
  /// Normal user Facebook login
  /// After success it will check for pincode is empty or not. If empty or null it will redirects to [ChooseLocationPage.routeName]
  /// On error it will throw [RestError]
  /// If cancelled it will return null
  ///
  static Future<UserResponse?> userLoginWithFacebook() async {
    final fcmId = await FirebaseMessaging.instance.getToken();
    // final fcmId = "345545644sffdsfdsdsssffsdf1dssdfse";
    final deviceInfo = await getDeviceDetails();

    final facebookLogin = FacebookAuth.instance;
    final facebookLoginResult = await facebookLogin.login(
      permissions: [
        'public_profile',
        'email',
      ],
    );

    switch (facebookLoginResult.status) {
      case LoginStatus.failed:
        print("${facebookLoginResult.message}");
        throw facebookLoginResult.message ?? "";
      case LoginStatus.cancelled:
        return null;
      case LoginStatus.success:
        log('TOKEN ${facebookLoginResult.accessToken!.token}');

        Map<String, dynamic> body = {
          "accessToken": facebookLoginResult.accessToken!.token,
          "loginType": 2,
          "fcmId": fcmId,
          "deviceId": deviceInfo['deviceId'],
          "platform": deviceInfo['deviceType'],
        };
        final resultMap = await ApiCall.post(
          ApiRoutes.social_login,
          body: body,
          isAuthNeeded: false,
        );
        print('fb body -============================ $body ');

        await facebookLogin.logOut();

        final userResponse = UserResponse.fromJson(resultMap.data);
        SharedPreferenceHelper.storeUser(user: userResponse);
        final userController = Get.isRegistered()
            ? Get.find<UserController>()
            : Get.put<UserController>(UserController(), permanent: true);
        userController.updateUser(userResponse.user);
        return userResponse;
      default:
        return null;
    }
  }

  ///
  /// Normal user Apple login
  /// After success it will check for pincode is empty or not. If empty or null it will redirects to [ChooseLocationPage.routeName]
  /// On error it will throw [RestError]
  /// If cancelled it will return null
  ///
  static Future<UserResponse?> userLoginWithApple() async {
    // final fcmId = await FirebaseMessaging.instance.getToken();
    final fcmId = "345545644sffdsfdsdsssffsdf1dssdfse";
    final deviceInfo = await getDeviceDetails();
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        // TODO: set client id and redirect url

        webAuthenticationOptions:
            WebAuthenticationOptions(clientId: '', redirectUri: Uri.parse('')),
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      print("api call with apple cred : ${credential.identityToken}");
      final resultMap = await ApiCall.post(ApiRoutes.signInWithApple,
          body: {
            "accessToken": credential.identityToken,
            "fcmId": fcmId,
            "deviceId": deviceInfo['deviceId'],
            "platform": deviceInfo['deviceType'],
          },
          isAuthNeeded: false);

      print("apple login result : $resultMap");
      final userResponse = UserResponse.fromJson(resultMap.data);
      SharedPreferenceHelper.storeUser(user: userResponse);
      SharedPreferenceHelper.storeAccessToken(userResponse.accessToken);
      return userResponse;
    } catch (e) {
      if (e is SignInWithAppleAuthorizationException) {
        switch (e.code) {
          case AuthorizationErrorCode.canceled:
            return null;
          default:
            throw 'Unable to login with apple';
        }
      }
      throw e.toString();
    }
  }

  ///
  /// Checks the user on-boarding
  ///
  static Future<void> checkUserLevel(
      {String? parentPath, String? phone}) async {
    final user = SharedPreferenceHelper.user;

    if (user == null) {
      Get.offAllNamed(LoginPage.routeName);
    } else if (user.user!.tastePreference == null) {
      Get.offAllNamed(PreferencesFirstPage.routeName);
    } else {
      Get.offAllNamed(DashboardPage.routeName);
    }
  }

  static Future<String?> refreshAccessToken() async {
    final fcmId = await FirebaseMessaging.instance.getToken();
    // final fcmId = "345545644sffdsfdsdsssffsdf1dssdfse";
    final deviceInfo = await getDeviceDetails();
    if (SharedPreferenceHelper.user == null) return null;
    final String? oldToken = SharedPreferenceHelper.user?.accessToken;
    if (oldToken?.isEmpty ?? true) return null;
    final result = await ApiCall.post(
      ApiRoutes.authenticateJwt,
      body: {
        'accessToken': oldToken,
        "fcmId": fcmId,
        "deviceId": deviceInfo['deviceId'],
        "deviceType": deviceInfo['deviceType'],
      },
    );
    log("$result");
    final String accessToken = result.data['accessToken'];
    final user = UserResponse.fromJson(result.data);
    SharedPreferenceHelper.storeUser(user: user);
    final userController = Get.isRegistered()
        ? Get.find<UserController>()
        : Get.put<UserController>(UserController(), permanent: true);
    userController.updateUser(user.user);
    return accessToken;
  }

  static Future<void> logoutUser() async {
    // await ApiCall.post('authentication', basePath: ApiRoutes.baseUrl);
    SharedPreferenceHelper.logout();
    checkUserLevel();
  }

  static Future<User?> updateUser(Map<String, dynamic> body) async {
    final u = SharedPreferenceHelper.user;
    if (u!.user == null) return null;
    final result =
        await ApiCall.patch(ApiRoutes.user, id: u.user!.id, body: body);
    final user = User.fromJson(result.data);
    u.user = user;
    SharedPreferenceHelper.storeUser(user: u);
    final userController = Get.isRegistered()
        ? Get.find<UserController>()
        : Get.put<UserController>(UserController(), permanent: true);
    userController.updateUser(u.user);
    return user;
  }
}

import 'package:flutter/services.dart';

class SnackBarHelper {
  static const platform =
      MethodChannel('com.platemate.user/toast');

  static Future<void> show(String message, {isLong = false}) async {
    await platform
        .invokeMethod('toast', {"message": message, "isLong": isLong});
  }
// static void show(String title, String message) {
//   Get.snackbar(title, message,
//       snackPosition: SnackPosition.BOTTOM,
//       snackStyle: SnackStyle.FLOATING,
//       borderRadius: 6,
  //       // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //       margin: const EdgeInsets.all(12),
  //       backgroundColor: const Color(0xFF171717),
  //       colorText: Colors.white,
  //       animationDuration: const Duration(milliseconds: 300));
  // }
}

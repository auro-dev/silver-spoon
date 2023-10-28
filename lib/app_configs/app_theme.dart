import 'package:flutter/material.dart';
import 'package:platemate_user/app_configs/environment.dart';

import 'app_colors.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
mixin AppThemes {
  static final appTheme = ThemeData(
    fontFamily: Environment.fontFamily,
    canvasColor: AppColors.brightBackground,
    primarySwatch: AppColors.brightPrimary,
    primaryColor: AppColors.brightPrimary,
    accentColor: AppColors.brightPrimary,
    backgroundColor: AppColors.brightBackground,
    scaffoldBackgroundColor: AppColors.brightBackground,
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.brightPrimary,
        selectionHandleColor: AppColors.brightPrimary,
        selectionColor: AppColors.brightPrimary.withOpacity(0.3)),
    // iconTheme: IconThemeData(color: Colors.white),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      elevation: 0,
      titleSpacing: 0,
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.transparent,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(primary: AppColors.brightPrimary),
    ),
    // textTheme: TextTheme(
    //   bodyText1:
    //       TextStyle(color: Color(0xff2A2A2A), fontFamily: 'Rubik'),
    //   bodyText2:
    //       TextStyle(color: Color(0xff2A2A2A), fontFamily: 'Rubik'),
    // ),
  );
// static final darkTheme = ThemeData(
//   fontFamily: Environment.fontFamily,
//   canvasColor: AppColors.darkBackground,
//   backgroundColor: AppColors.darkBackground,
//   primarySwatch: AppColors.darkPrimary,
//   primaryColor: AppColors.darkPrimary,
//   accentColor: AppColors.darkPrimary,
//   textSelectionTheme: TextSelectionThemeData(
//       cursorColor: AppColors.darkPrimary,
//       selectionHandleColor: AppColors.darkPrimary,
//       selectionColor: AppColors.brightPrimary.withOpacity(0.3)),
//   iconTheme: IconThemeData(color: Colors.black),
//   visualDensity: VisualDensity.adaptivePlatformDensity,
//   brightness: Brightness.dark,
//   appBarTheme: AppBarTheme(
//     elevation: 0,
//     iconTheme: IconThemeData(color: Colors.white),
//   ),
//   outlinedButtonTheme: OutlinedButtonThemeData(
//     style: OutlinedButton.styleFrom(primary: AppColors.darkPrimary),
//   ),
//   // textTheme: TextTheme(
//   //   bodyText1:
//   //       TextStyle(color: Color(0xff2A2A2A), fontFamily: 'Rubik'),
//   //   bodyText2:
//   //       TextStyle(color: Color(0xff2A2A2A), fontFamily: 'Rubik'),
//   // ),
// );
}

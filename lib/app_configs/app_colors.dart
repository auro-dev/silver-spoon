import 'package:flutter/material.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
mixin AppColors {
  static const brightBackground = Color(0xffF5F5F5);
  static const darkBackground = Color(0xff3e3e3e);
  static const borderColor = Color(0xc8bababa);
  static const brightSecondaryColor = Color(0xff3E9AFF);
  static const green = Color(0xff56AB18);
  static const divider = Color(0xffF1F1F1);
  static const darkGrey = Color(0xff676F75);
  static const grey = Color(0xff888888);
  static const brightTextColor = Color(0xff2D2D2D);
  static const dividerSlot = Color(0xffEAEAEA);
  static const blue = Color(0xff3582EC);
  static const desc = Color(0xffB1B1B1);
  static const primary = Color(0xffB1B1B1);
  static const labelColor = Color(0xff949494);
  static const rating_yellow = Color(0xffFAC400);
  static const desc_2 = Color(0xff666666);
  static const green_2_0 = Color(0xff1DC973);
  static const green_0 = Color(0xff40BF55);


  static const orange = Color(0xffF57C3D);
  static const grey20 = Color(0xff333333);
  static const grey40 = Color(0xff666666);
  static const grey60 = Color(0xff999999);
  static const grey80 = Color(0xffCCCCCC);
  static const grey90 = Color(0xffE6E6E6);
  static const grey96 = Color(0xffF5F5F5);
  static const grey100 = Color(0xffFFFFFF);

  static const MaterialColor brightPrimary =
      MaterialColor(brightPrimaryValue, <int, Color>{
    50: Color(0xFFFEEFE8),
    100: Color(0xFFFCD8C5),
    200: Color(0xFFFABE9E),
    300: Color(0xFFF8A377),
    400: Color(0xFFF7905A),
    500: Color(brightPrimaryValue),
    600: Color(0xFFF47437),
    700: Color(0xFFF2692F),
    800: Color(0xFFF05F27),
    900: Color(0xFFEE4C1A),
  });
  static const int brightPrimaryValue = 0xFFF57C3D;

  static const MaterialColor darkPrimary =
      MaterialColor(_darkprimaryPrimaryValue, <int, Color>{
    50: Color(0xFFFFE1E9),
    100: Color(0xFFFFB5C7),
    200: Color(0xFFFF84A2),
    300: Color(0xFFFF527C),
    400: Color(0xFFFF2D60),
    500: Color(_darkprimaryPrimaryValue),
    600: Color(0xFFFF073E),
    700: Color(0xFFFF0635),
    800: Color(0xFFFF042D),
    900: Color(0xFFFF021F),
  });
  static const int _darkprimaryPrimaryValue = 0xFFFF0844;

  static const MaterialColor darkprimaryAccent =
      MaterialColor(_darkprimaryAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_darkprimaryAccentValue),
    400: Color(0xFFFFBFC4),
    700: Color(0xFFFFA6AC),
  });
  static const int _darkprimaryAccentValue = 0xFFFFF2F3;
}

import 'package:flutter/material.dart';

import 'app_colors.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
mixin AppDecorations {
  static const introLinearGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(248, 249, 255, 1),
        Color.fromRGBO(248, 249, 255, 0.83),
        Color.fromRGBO(248, 249, 255, 1),
      ]);

  static LinearGradient purpleGrad = LinearGradient(
    colors: [
      Color(0xff9B92FF),
      Color(0xff271BA4),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient draftGrad = LinearGradient(
    colors: [
      Color(0xff2F23AA).withOpacity(0.8),
      Color(0xff6F65DC).withOpacity(0.8),
      Color(0xffBAB5EE).withOpacity(0.38),
      Colors.grey.shade200.withOpacity(0.18),
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static InputDecoration textFieldDecoration(BuildContext context,
      {double radius = 12}) {
    return InputDecoration(
        // fillColor: Colors.grey.shade200,
        filled: false,
        counterText: '',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        contentPadding: EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade300
                  : AppColors.borderColor,
              width: 1.2,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade300
                  : AppColors.borderColor,
              width: 1.2,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: AppColors.borderColor,
              width: 1.2,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade300
                  : AppColors.borderColor,
              width: 1.2,
            )));
  }

  static InputDecoration textFieldDecoration_2(BuildContext context,
      {double radius = 8}) {
    return InputDecoration(
        fillColor: Colors.grey.shade200.withOpacity(0.18),
        filled: true,
        counterText: '',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        contentPadding: EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 1.2,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 1.2,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 1.2,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 1.2,
            )));
  }

  static InputDecoration underLinedTextFieldDecoration(BuildContext context,
      {double radius = 8}) {
    return InputDecoration(
        // fillColor: Colors.grey.shade200,
        filled: false,
        counterText: '',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        contentPadding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
        disabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade300
                  : AppColors.borderColor,
              width: 1.2,
            )),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade300
                : AppColors.borderColor,
            width: 1.2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: AppColors.borderColor,
              width: 1.2,
            )),
        enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade300
                  : AppColors.borderColor,
              width: 1.2,
            )));
  }

  static TextStyle commentTitle(BuildContext context) => TextStyle(
    fontSize: 12,
    color: Theme.of(context).brightness == Brightness.light
        ? Color(0xff6A6A6A)
        : Colors.white.withOpacity(0.7),
  );
}

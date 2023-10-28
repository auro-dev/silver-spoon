import 'package:platemate_user/app_configs/environment.dart';
import 'package:flutter/material.dart';

import '../app_loader.dart';

///
/// Created by Sunil Kumar from Boiler plate
///

class AppOutlineButton extends StatefulWidget {
  const AppOutlineButton(
      {required this.child,
      Key? key,
      this.onPressed,
      this.height,
      this.width,
      this.color,
      this.borderColor,
      this.shape,
      this.padding,
      this.textStyle})
      : super(key: key);

  final ShapeBorder? shape;
  final Widget child;
  final VoidCallback? onPressed;
  final double? height, width;
  final Color? color;
  final Color? borderColor;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  @override
  AppOutlineButtonState createState() => AppOutlineButtonState();
}

class AppOutlineButtonState extends State<AppOutlineButton> {
  bool _isLoading = false;

  void showLoader() {
    setState(() {
      _isLoading = true;
    });
  }

  void hideLoader() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _isLoading
        ? AppProgress(color: widget.color ?? theme.primaryColor)
        : OutlinedButton(
            key: widget.key,
            onPressed: widget.onPressed,
            // style: ButtonStyle(
            //   padding: MaterialStateProperty.all(
            //     widget.padding ??
            //         const EdgeInsets.symmetric(vertical: 14, horizontal: 48),
            //   ),
            //   textStyle: MaterialStateProperty.resolveWith(
            //       (Set<MaterialState> states) {
            //     if (states.contains(MaterialState.disabled))
            //       return TextStyle(color: Colors.grey.shade500);

            //     return TextStyle(color: AppColors.brightPrimary);
            //   }),
            //   foregroundColor: MaterialStateProperty.resolveWith<Color?>(
            //     (Set<MaterialState> states) {
            //       if (states.contains(MaterialState.pressed))
            //         return AppColors.brightPrimary.shade800;
            //       else if (states.contains(MaterialState.disabled))
            //         return Colors.grey.shade500;
            //         return AppColors.brightPrimary;
            //     },
            //   ),
            // ),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.white, width: 3),
              ),
              // primary: theme.primaryColor,
              padding: widget.padding ??
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
              textStyle: widget.textStyle ??
                  TextStyle(
                    fontSize: 16,
                    fontFamily: Environment.fontFamily,
                    letterSpacing: 1.4,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            child: widget.child,
          );
  }
}

class MyOutlinedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const MyOutlinedButton({this.title = '', this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: OutlinedButton(
        // style: ButtonStyle(
        //   textStyle: MaterialStateProperty.all(TextStyle(
        //     fontSize: 16,
        //     fontWeight: FontWeight.w600,
        //   )),
        //   padding: MaterialStateProperty.all(EdgeInsets.all(16)),
        //   shape: MaterialStateProperty.all(RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(10.0),
        //       side: BorderSide(
        //         color: MyColors.brightPrimary,
        //         width: 1,
        //         style: BorderStyle.solid,
        //       ))),
        // ),
        onPressed: onTap,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(16)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
                color: Colors.white.withOpacity(0.8),
                width: 0.8,
                style: BorderStyle.solid),
          )),
          overlayColor:
              MaterialStateProperty.all(Colors.grey.shade200.withOpacity(0.18)),
        ),
        child: Text(
          "$title",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xffFFFFFF),
            fontFamily: Environment.fontFamily,
            letterSpacing: 1,
          ),
        ),
        // padding: EdgeInsets.all(16),
        // borderSide: BorderSide(color: Color(0xff6A6A6A)),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}

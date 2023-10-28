import 'package:flutter/material.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AppCircleButton extends StatelessWidget {
  final Color? color;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;
  final Widget? child;
  final Size? size;
  AppCircleButton(
      {this.child, this.size, this.color, this.onPressed, this.padding});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tight(size ?? Size(54, 54)),
      onPressed: onPressed,
      padding: padding ?? EdgeInsets.zero,
      child: child,
      shape: const CircleBorder(),
      fillColor: color ?? Colors.white,
    );
  }
}

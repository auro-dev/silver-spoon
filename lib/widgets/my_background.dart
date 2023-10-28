import 'dart:ui';
import 'package:flutter/material.dart';

///
/// Created by Auro on 13/10/22 at 9:52 AM
///

class MyBackground extends StatelessWidget {
  const MyBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff0A061D),
            ),
          ),
        ),
        Positioned(
          top: -35,
          left: -80,
          child: BlurryDots(
            color: Color(0xff625AA8),
          ),
        ),
        Positioned(
          top: 151,
          right: -120,
          child: BlurryDots(
            color: Color(0xff764111),
          ),
        ),
        Positioned(
          top: 400,
          left: -130,
          child: BlurryDots(
            color: Color(0xff764111),
          ),
        ),
        Positioned(
          bottom: -40,
          right: -100,
          child: Opacity(
            opacity: 0.3,
            child: BlurryDots(
              color: Color(0xff625AA8),
            ),
          ),
        ),
      ],
    );
  }
}

class BlurryDots extends StatelessWidget {
  final Color color;

  const BlurryDots({Key? key, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: new BoxDecoration(
            color: Colors.white.withOpacity(0.0),
          ),
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.3),
        gradient: RadialGradient(
          center: Alignment.center,
          colors: [color, color.withOpacity(0.4), Colors.transparent],
        ),
      ),
    );
  }
}

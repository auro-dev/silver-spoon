import 'package:flutter/material.dart';
import 'package:platemate_user/app_configs/app_colors.dart';

///
/// Created by Auro on 24/01/22 at 4:56 pm
///

class AppTabIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;

  AppTabIndicator(
      {this.indicatorColor = AppColors.brightPrimary,
      this.indicatorHeight = 3.5});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      IndicatorPainter(this, onChanged);
}

class IndicatorPainter extends BoxPainter {
  final AppTabIndicator homeTabIndicator;

  IndicatorPainter(this.homeTabIndicator, onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Rect rect = Offset(offset.dx,
            configuration.size!.height - homeTabIndicator.indicatorHeight) &
        Size(configuration.size!.width, homeTabIndicator.indicatorHeight);
    final Paint paint = Paint();
    paint.color = homeTabIndicator.indicatorColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRect(rect, paint);
  }
}

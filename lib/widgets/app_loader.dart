import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoaderOverlay extends ModalRoute<void> {
  final String? message;

  LoaderOverlay({this.message});

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Get.theme.scaffoldBackgroundColor.withOpacity(0.8);

  @override
  String get barrierLabel => 'loader-overlay';

  @override
  Future<RoutePopDisposition> willPop() async {
    return RoutePopDisposition.doNotPop;
  }

  @override
  bool get maintainState => false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppProgress(color: Get.theme.primaryColor),
          Text(
            message ?? 'Please wait...',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}

class AppProgress extends StatefulWidget {
  final Color? color;
  final double? strokeWidth;
  final Size? size;
  const AppProgress(
      {Key? key, this.strokeWidth, this.color, this.size = const Size(50, 50)})
      : super(key: key);

  @override
  _AppProgressState createState() => _AppProgressState();
}

class _AppProgressState extends State<AppProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    this._controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    this._controller.repeat();
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: widget.size,
      child: AspectRatio(
        aspectRatio: 1,
        child: AnimatedBuilder(
          animation: this._controller,
          builder: (ctx, child) => CustomPaint(
            child: Container(),
            foregroundPainter: _CircleProgressBarPainter(
                color: widget.color ?? Theme.of(context).primaryColor,
                percentage: Tween<double>(begin: 0.0, end: 1.0)
                    .animate(CurvedAnimation(
                        curve: Curves.fastOutSlowIn, parent: _controller))
                    .value,
                strokeWidth: this.widget.strokeWidth),
          ),
        ),
      ),
    );
  }
}

class _CircleProgressBarPainter extends CustomPainter {
  final double? percentage;
  final double strokeWidth;
  final Color? color;

  _CircleProgressBarPainter({
    @required this.color,
    @required this.percentage,
    double? strokeWidth,
  }) : this.strokeWidth = strokeWidth ?? 6;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);

    final shortestSide = Math.min(size.width, size.height);
    final foregroundPaint = Paint()
      ..color = this.color!
      ..strokeWidth = this.strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final radius = (shortestSide / 2) - ((this.strokeWidth) / 2).ceil();

    final double startAngle = 2 * Math.pi * (percentage ?? 0);

    final count = 8;
    final gapSize = 20;
    final double gap = Math.pi / 180 * gapSize;
    final double singleAngle = (Math.pi * 2) / count;

    final Paint paint = Paint()
      ..color = color!
      ..strokeWidth = strokeWidth - 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < count; i++) {
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          gap + singleAngle * i, singleAngle - gap * 2, false, paint);
    }
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      singleAngle - gap * 5,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as _CircleProgressBarPainter);
    return oldPainter.percentage != this.percentage;
  }
}

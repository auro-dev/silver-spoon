import 'package:flutter/material.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 24/01/22 at 10:21 pm
///

class MySeparator extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const MySeparator(
      {this.height = 1, this.color = Colors.black, this.width = 4});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = width;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

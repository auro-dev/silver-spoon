///
/// Created by Auro on 15/11/22 at 12:53 PM
///

import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/widgets/pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';

class PieChartView extends StatelessWidget {
  final double amount;
  const PieChartView(this.amount, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) => Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              spreadRadius: -10,
              blurRadius: 17,
              offset: Offset(-5, -5),
              color: AppColors.primary,
            ),
            BoxShadow(
              spreadRadius: -2,
              blurRadius: 10,
              offset: Offset(7, 7),
              color: Color.fromRGBO(14, 42, 69, 1.0),
            )
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: constraint.maxWidth * 0.6,
                child: CustomPaint(
                  child: Center(),
                  foregroundPainter: PieChart(
                    width: constraint.maxWidth * 0.7,
                    categories: kCategories,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                height: constraint.maxWidth * 0.7,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      offset: Offset(-1, -1),
                      color: AppColors.primary,
                    ),
                    BoxShadow(
                      spreadRadius: -2,
                      blurRadius: 10,
                      offset: Offset(5, 5),
                      color: Colors.black.withOpacity(0.5),
                    )
                  ],
                ),
                child: Center(
                  child: Text('\$$amount'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

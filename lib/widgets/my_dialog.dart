import 'package:platemate_user/widgets/my_background.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 08/12/22 at 9:52 PM
///

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String? description;
  final String positiveText;
  final String negativeText;
  final VoidCallback? positiveCallback;
  final VoidCallback? negativeCallBack;

  const MyAlertDialog({
    Key? key,
    this.title = '',
    this.description,
    this.positiveText = 'Yes',
    this.negativeCallBack,
    this.negativeText = 'Cancel',
    this.positiveCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Material(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ColoredBox(
                    color: Color(0xff0A061D),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text("$description"),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

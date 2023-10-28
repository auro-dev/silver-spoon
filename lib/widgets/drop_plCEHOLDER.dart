///
/// Created by Auro on 28/11/22 at 12:19 AM
///

import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 17/05/22 at 2:53 pm
///

class DropDownPlaceholder extends StatelessWidget {
  final String name;

  const DropDownPlaceholder(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$name",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
          Icon(Icons.arrow_drop_down),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.borderColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

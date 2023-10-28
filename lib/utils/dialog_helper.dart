///
/// Created by Auro on 18/03/22 at 10:25 am
///

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showMyDialog(
    {String title = '',
    String? description,
    String positiveText = 'Yes',
    String negativeText = 'Cancel',
    VoidCallback? positiveCallback,
    VoidCallback? negativeCallBack}) {
  if (Platform.isAndroid)
    Get.dialog(
        CupertinoAlertDialog(
          title: Text(title),
          content: description != null ? Text(description) : null,
          actions: [
            CupertinoDialogAction(
              child: Text('No'),
              onPressed: negativeCallBack ??
                      () {
                    Get.back();
                  },
            ),
            CupertinoDialogAction(
              child: Text('Yes'),
              onPressed: positiveCallback ?? () {},
            ),
          ],
        )
      // MyAlertDialog(
      //   title: title,
      //   description: description,
      //   negativeCallBack: negativeCallBack,
      //   negativeText: negativeText,
      //   positiveCallback: positiveCallback,
      //   positiveText: positiveText,
      // ),
      // AlertDialog(
      //   title: Text(title),
      //   content: description != null ? Text(description) : null,
      //   actions: [
      //     TextButton(
      //       child: Text(
      //         negativeText,
      //         style: TextStyle(color: Colors.white),
      //       ),
      //       onPressed: negativeCallBack ??
      //           () {
      //             Get.back();
      //           },
      //     ),
      //     TextButton(
      //       child: Text(
      //         positiveText,
      //         style: TextStyle(color: Colors.white),
      //       ),
      //       onPressed: positiveCallback ?? () {},
      //     ),
      //   ],
      // ),
    );
  else
    Get.dialog(CupertinoAlertDialog(
      title: Text(title),
      content: description != null ? Text(description) : null,
      actions: [
        CupertinoDialogAction(
          child: Text('No'),
          onPressed: negativeCallBack ??
              () {
                Get.back();
              },
        ),
        CupertinoDialogAction(
          child: Text('Yes'),
          onPressed: positiveCallback ?? () {},
        ),
      ],
    ));
}

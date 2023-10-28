import 'package:flutter/material.dart';
import 'package:platemate_user/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';

Future<bool?> showAppAlertSheet() {
  return Get.bottomSheet(AlertSheet());
}

class AlertSheet extends StatelessWidget {
  final String title;
  final String description;
  final String positiveText, negativeText;

  AlertSheet(
      {this.title = 'Alert',
      this.positiveText = 'Ok',
      this.description = '',
      this.negativeText = 'Cancel'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
              child: Material(
                child: SizedBox(height: 4, width: 100),
                color: Colors.grey.shade300,
                shape: StadiumBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          if (description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          SizedBox(height: 16),
          AppPrimaryButton(
            child: Text(positiveText),
            onPressed: () => Get.back(result: true),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(negativeText),
          ),
          SizedBox(height: 22),
        ],
      ),
    );
  }
}

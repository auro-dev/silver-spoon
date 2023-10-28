import 'package:flutter/material.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/widgets/app_title.dart';
import 'package:platemate_user/widgets/my_divider.dart';

///
/// Created by Auro on 26/04/23 at 9:59 PM
///

class CustomisationInputBox extends StatelessWidget {
  final String? selectedValue;
  final List<String> data;
  final Function(String v)? onChanged;
  final String? title;

  const CustomisationInputBox({
    Key? key,
    this.selectedValue,
    this.data = const [],
    this.onChanged,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey90),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 14),
          MediumTitleText(title ?? ""),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            separatorBuilder: (c, i) => MyDivider(),
            itemBuilder: (c, i) => InkWell(
              onTap: () => onChanged!.call(data[i]),
              child: Row(
                children: [
                  Expanded(
                    child: Text('${data[i]}'),
                  ),
                  Radio(
                    value: data[i],
                    groupValue: selectedValue,
                    onChanged: (d) => onChanged!.call(d as String),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VariantsInputBox extends StatelessWidget {
  final String? selectedValue;
  final List<String> data;
  final List<String> displayData;
  final Function(String v)? onChanged;
  final String? title;

  const VariantsInputBox({
    Key? key,
    this.selectedValue,
    this.data = const [],
    this.displayData = const [],
    this.onChanged,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey90),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 14),
          MediumTitleText(title ?? ""),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            separatorBuilder: (c, i) => MyDivider(),
            itemBuilder: (c, i) => InkWell(
              onTap: () => onChanged!.call(data[i]),
              child: Row(
                children: [
                  Expanded(
                    child: Text('${displayData[i]}'),
                  ),
                  Radio(
                    value: data[i],
                    groupValue: selectedValue,
                    onChanged: (d) => onChanged!.call(d as String),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

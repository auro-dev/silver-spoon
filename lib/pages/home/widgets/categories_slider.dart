import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/pages/home/controllers/category_controller.dart';
import 'package:platemate_user/widgets/user_circle_avatar.dart';

///
/// Created by Auro on 04/03/23 at 10:14 AM
///

class CategoriesSlider extends GetView<CategoryController> {
  const CategoriesSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SectionTitle("Browse by Categories"),
        ),
        SizedBox(
          height: 112,
          child: controller.obx(
            (state) {
              if (state != null) {
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (c, i) => SizedBox(width: 16),
                  itemBuilder: (c, i) => Column(
                    children: [
                      UserCircleAvatar("${state[i].avatar}"),
                      const SizedBox(height: 6),
                      Text(
                        "${state[i].name}",
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.grey20,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox();
            },
            onError: (e) => SizedBox(),
            onEmpty: SizedBox(),
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;

  const SectionTitle(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: AppColors.grey20,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/data_models/user.dart';
import 'package:platemate_user/pages/authenticaton/login/login_page.dart';
import 'package:platemate_user/widgets/user_circle_avatar.dart';

///
/// Created by Auro on 18/04/23 at 1:59 AM
///

class ProfileCard extends StatelessWidget {
  final User? user;
  final VoidCallback? onUpdated;

  const ProfileCard(this.user, {this.onUpdated});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: user == null
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Colors.white),
                    ),
                  ),
                  onPressed: () async {
                    await Get.toNamed(
                      LoginPage.routeName,
                      arguments: {
                        "parent": Get.currentRoute,
                      },
                    );
                    onUpdated!.call();
                  },
                  child: Text("Sign In"),
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.fromLTRB(22, 22, 22, 22),
              child: Row(
                children: [
                  UserCircleAvatar("${user!.avatar}"),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${user!.name}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "+91 ${user!.phone}, ${user!.email}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: Colors.white),
                            ),
                          ),
                          onPressed: () {},
                          child: Text("Edit"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
      decoration: BoxDecoration(
        color: AppColors.brightPrimary,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

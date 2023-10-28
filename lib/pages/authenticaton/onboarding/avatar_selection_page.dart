import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:platemate_user/global_controllers/user_controller.dart';
import 'package:platemate_user/pages/authenticaton/controllers/avatar_selection_controller.dart';
import 'package:platemate_user/pages/authenticaton/login/login_page.dart';
import 'package:platemate_user/pages/authenticaton/onboarding/preferences_first_page.dart';
import 'package:platemate_user/utils/dialog_helper.dart';
import 'package:platemate_user/utils/shared_preference_helper.dart';

import '../../../app_configs/app_assets.dart';
import '../../../app_configs/app_colors.dart';
import '../../../widgets/app_buttons/app_primary_button.dart';
import '../../../widgets/dotted_border.dart';
import '../signup/signup_page.dart';

///
/// Created by Auro on 04/03/23 at 12:26 AM
///

class AvatarSelectionPage extends StatefulWidget {
  static const routeName = '/avatar-selection-page';

  const AvatarSelectionPage({Key? key}) : super(key: key);

  @override
  State<AvatarSelectionPage> createState() => _AvatarSelectionPageState();
}

class _AvatarSelectionPageState extends State<AvatarSelectionPage> {
  late AvatarSelectionController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AvatarSelectionController();
    _controller.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(AppAssets.back_button),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.offAllNamed(PreferencesFirstPage.routeName);
            },
            child: Text("Skip", style: TextStyle(fontSize: 16)),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GetBuilder(
                init: _controller,
                builder: (c) => ListView(
                  physics:
                      BouncingScrollPhysics(parent: ClampingScrollPhysics()),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    LargeTitle("Set profile picture."),
                    const SizedBox(height: 26),
                    Center(
                      child: GestureDetector(
                        onTap: _controller.chooseImages,
                        behavior: HitTestBehavior.translucent,
                        child: DottedBorder(
                          dashPattern: const [10, 7],
                          padding: const EdgeInsets.all(0),
                          color: _controller.image == null
                              ? AppColors.grey80
                              : AppColors.brightPrimary,
                          strokeWidth: 4,
                          // radius: const Radius.circular(56),
                          borderType: BorderType.Circle,
                          child: Container(
                            height: 300,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Color(0xffF5F5F5),
                              shape: BoxShape.circle,
                              image: _controller.image == null
                                  ? null
                                  : DecorationImage(
                                      image: FileImage(_controller.image!),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            child: _controller.image != null
                                ? SizedBox.shrink()
                                : Center(
                                    child: SvgPicture.asset(
                                      AppAssets.img_placeholder,
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: TextButton(
                        onPressed: _controller.chooseImages,
                        child: Text("CHANGE IMAGE"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GetBuilder(
              init: _controller,
              builder: (c) => SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AppPrimaryButton(
                    key: _controller.buttonKey,
                    child: Text("Next".toUpperCase()),
                    onPressed: _controller.proceed,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

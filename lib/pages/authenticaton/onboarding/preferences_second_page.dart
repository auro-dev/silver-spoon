import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:platemate_user/global_controllers/user_controller.dart';
import 'package:platemate_user/pages/authenticaton/controllers/cuisines_controller.dart';
import 'package:platemate_user/pages/authenticaton/controllers/preferences_second_controller.dart';
import 'package:platemate_user/pages/authenticaton/login/login_page.dart';
import 'package:platemate_user/utils/dialog_helper.dart';
import 'package:platemate_user/utils/shared_preference_helper.dart';

import '../../../app_configs/app_assets.dart';
import '../../../app_configs/app_colors.dart';
import '../../../widgets/app_buttons/app_primary_button.dart';
import '../../../widgets/slider_custom.dart';
import '../signup/signup_page.dart';

///
/// Created by Auro on 04/03/23 at 12:43 AM
///

class PreferencesSecondPage extends StatefulWidget {
  static const routeName = '/preference-second-page';

  const PreferencesSecondPage({Key? key}) : super(key: key);

  @override
  State<PreferencesSecondPage> createState() => _PreferencesSecondPageState();
}

class _PreferencesSecondPageState extends State<PreferencesSecondPage> {
  late PreferencesSecondController _controller;
  late CuisinesController _cuisinesController;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = PreferencesSecondController();
    _controller.onInit();
    _cuisinesController = CuisinesController();
    _cuisinesController.getData();
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
              showMyDialog(
                title: 'Are you sure you want to logout?',
                positiveCallback: () {
                  Get.back();
                  final userController = Get.find<UserController>();
                  userController.updateUser(null);
                  SharedPreferenceHelper.logout();
                  Get.offAllNamed(LoginPage.routeName);
                },
              );
            },
            child: Text("Logout"),
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
                    LargeTitle("What do you like?"),
                    _cuisinesController.obx((state) {
                      if (state != null) {
                        return Wrap(
                          spacing: 12.0,
                          runSpacing: 2.0,
                          children: <Widget>[
                            ...state.map(
                              (e) => FilterChip(
                                label: Text(
                                  '${e.name}',
                                  style: TextStyle(
                                    color: _controller.selectedFoodTypes
                                            .contains(e.id)
                                        ? Colors.white
                                        : null,
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    side: BorderSide(
                                      width: 1.0,
                                      color: _controller.selectedFoodTypes
                                              .contains(e.id)
                                          ? AppColors.brightPrimary
                                          : AppColors.grey80,
                                    )),
                                onSelected: (bool val) {
                                  _controller.selectFoodTypes(e.id);
                                },
                                selected: _controller.selectedFoodTypes
                                    .contains(e.id),
                                showCheckmark: false,
                                selectedColor: AppColors.brightPrimary,
                              ),
                            ),
                          ],
                        );
                      }
                      return SizedBox();
                    }),
                    const SizedBox(height: 32),
                    MediumTitle("Do you have a sweet tooth?"),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: _controller.updateSweetTooth,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _controller.sweetTooth
                                ? AppColors.brightPrimary
                                : AppColors.grey80,
                          ),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              _controller.sweetTooth
                                  ? AppAssets.check_enabled
                                  : AppAssets.check_disabled,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                                child: Text(
                              "Yes, I have a sweet tooth",
                              style: TextStyle(
                                fontWeight: _controller.sweetTooth
                                    ? FontWeight.w500
                                    : FontWeight.w400,
                                fontSize: 16,
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    MediumTitle("Oil level you prefer"),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: AppColors.brightPrimary,
                        inactiveTrackColor: const Color(0xffF1F1F1),
                        trackHeight: 26,
                        trackShape:
                            GradientRectSliderTrackShape(darkenInactive: true),
                        thumbShape: FeedbackSliderThumbShape(
                          thumbRadius: 20,
                        ),
                        overlayColor: Colors.purple.withAlpha(32),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 21.0),
                      ),
                      child: Slider(
                        value: _controller.oilLevel ?? 0,
                        min: 0,
                        max: 4,
                        divisions: 4,
                        onChanged: _controller.updateOilLevel,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: SizedBox()),
                        Expanded(
                            child: Text(
                          "Super Healthy",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        )),
                        Expanded(
                            child: Text(
                          "Healthy",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        )),
                        Expanded(
                            child: Text(
                          "Tasty",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        )),
                        Expanded(
                            child: Text(
                          "Super Tasty",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        )),
                      ],
                    ),
                    const SizedBox(height: 32),
                    MediumTitle("Spicy level you prefer"),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: AppColors.brightPrimary,
                        inactiveTrackColor: const Color(0xffF1F1F1),
                        trackHeight: 26,
                        trackShape:
                            GradientRectSliderTrackShape(darkenInactive: true),
                        thumbShape: FeedbackSliderThumbShape(
                          thumbRadius: 20,
                        ),
                        overlayColor: Colors.purple.withAlpha(32),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 21.0),
                      ),
                      child: Slider(
                        value: _controller.spicyLevel ?? 0,
                        min: 0,
                        max: 4,
                        divisions: 4,
                        onChanged: _controller.updateSpicyLevel,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: SizedBox()),
                        Expanded(
                            child: Text(
                          "🙂",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22),
                        )),
                        Expanded(
                            child: Text(
                          "😬",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22),
                        )),
                        Expanded(
                            child: Text(
                          "🥵",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22),
                        )),
                        Expanded(
                            child: Text(
                          "🤯",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AppPrimaryButton(
                  key: _controller.buttonKey,
                  child: Text("Submit".toUpperCase()),
                  onPressed: _controller.proceed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MediumTitle extends StatelessWidget {
  final String text;

  const MediumTitle(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: AppColors.grey40,
        ),
      ),
    );
  }
}

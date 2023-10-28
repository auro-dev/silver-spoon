import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:platemate_user/app_configs/app_assets.dart';
import 'package:platemate_user/pages/restaurant_menu/restaurant_menu_page.dart';
import 'package:scan/scan.dart';
import '../../app_configs/app_colors.dart';
import '../../widgets/app_buttons/app_outline_button.dart';
import '../../widgets/photo_chooser.dart';

///
/// Created by Auro on 25/04/23 at 12:19 AM
///

class QRSScannerPage extends StatefulWidget {
  static const routeName = '/scan-qr-page';

  const QRSScannerPage({Key? key}) : super(key: key);

  @override
  State<QRSScannerPage> createState() => _QRSScannerPageState();
}

class _QRSScannerPageState extends State<QRSScannerPage> {
  bool isFlashOn = false;
  late ScanController controller;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    controller = ScanController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(AppAssets.back_button),
        ),
        actions: [],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 0),
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Scan & Go',
                  style: TextStyle(
                    letterSpacing: -3,
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'To scan and pay, align the QR code inside the frame.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 56,
                ),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 280,
                        width: 280,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                                color: AppColors.brightPrimary, width: 6)),
                      ),
                      Container(
                        height: 160,
                        width: 300,
                        color: Colors.white,
                      ),
                      Container(
                        height: 300,
                        width: 160,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 240,
                        width: 240,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: ScanView(
                            controller: controller,
                            scanAreaScale: 1,
                            scanLineColor: Colors.transparent,
                            onCapture: (data) async {
                              controller.pause();
                              Get.offAndToNamed(
                                RestaurantMenuPage.routeName,
                                arguments: {
                                  "restaurantId": "64397d66da1479c2868aa847",
                                  "tableId": "643aaa892711194f7d89d280",
                                },
                              );
                              // var id = data.split(',')[0];
                              // if (id == SharedPreferenceHelper.user!.user!.id ||
                              //     data.split(',').length != 2) {
                              //   isVisible = true;
                              // } else if (id !=
                              //     SharedPreferenceHelper.user!.user!.id) {
                              //   controller.pause();
                              //   isVisible = false;
                              //   Get.offNamed(PaymentTransferPage.routeName,
                              //       arguments: {'recipient': data});
                              // }
                              // controller.resume();
                              // setState(() {});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: IconButton(
                        icon: isFlashOn
                            ? SvgPicture.asset(AppAssets.flashFilledVector)
                            : SvgPicture.asset(AppAssets.flashVector),
                        onPressed: () async {
                          if (await Permission.camera.isGranted) {
                            isFlashOn = !isFlashOn;
                            controller.toggleTorchMode();
                            setState(() {});
                          }
                        })),
                Visibility(
                    visible: isVisible,
                    child: const Center(
                        child: Text(
                      'Please provide a valid qr code',
                      style: TextStyle(color: Colors.red),
                    ))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 44),
            child: AppOutlineButton(
                onPressed: () {
                  controller.pause();
                  Get.focusScope?.unfocus();
                  Get.bottomSheet(const PhotoChooser(),
                          backgroundColor: Get.isDarkMode
                              ? AppColors.darkBackground
                              : AppColors.brightBackground)
                      .then((value) async {
                    // if (value != null && value is File) {
                    //   String? str = await Scan.parse(value.path);
                    //   if (str != null) {
                    //     var id = str.split(',')[0];
                    //     if (str.split(',').length != 2 ||
                    //         id == SharedPreferenceHelper.user!.user!.id) {
                    //       isVisible = true;
                    //     } else if (id !=
                    //         SharedPreferenceHelper.user!.user!.id) {
                    //       isVisible = false;
                    //       Get.offNamed(PaymentTransferPage.routeName,
                    //           arguments: {'recipient': str});
                    //     }
                    //     setState(() {});
                    //   } else {
                    //     isVisible = true;
                    //     setState(() {});
                    //   }
                    // }
                  }).then((value) => controller.resume());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.upload,
                      height: 30,
                      color: AppColors.brightPrimary,
                    ),
                    const SizedBox(width: 16),
                    Text('Upload from gallery'.toUpperCase()),
                  ],
                )),
          )
        ],
      ),
    );
  }
}

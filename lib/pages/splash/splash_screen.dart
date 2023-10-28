import 'package:flutter/material.dart';
import 'package:platemate_user/utils/app_auth_helper.dart';
import 'package:flutter_svg/svg.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class SplashPage extends StatefulWidget {
  static const routeName = '/';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation _arrowAnimation;
  late AnimationController _arrowAnimationController;
  final backGround = SvgPicture.asset("assets/icons/splash_back.svg");
  final logo = SvgPicture.asset(
    "assets/icons/splash_logo.svg",
    height: 300,
  );

  @override
  void initState() {
    super.initState();
    _arrowAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _arrowAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_arrowAnimationController);
    // _arrowAnimationController.forward();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 2)).then((value) {
        AuthHelper.refreshAccessToken().whenComplete(() {
          AuthHelper.checkUserLevel();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFF945B),
      body: Stack(
        children: [
          Positioned.fill(
            child: backGround,
          ),
          Positioned.fill(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: logo,
              ),
            ),
          ),
          // Positioned.fill(
          //   child: Center(
          //     child: SlideTransition(
          //       position: Tween(
          //         begin: Offset(0.0, 0.5),
          //         end: Offset(0.0, 0.0),
          //       ).animate(_arrowAnimationController),
          //       // position: AlwaysStoppedAnimation(
          //       //     Offset(0, -_arrowAnimation.value * 5)),
          //       // offset: Offset(0, -_arrowAnimation.value * 40),
          //       child: Padding(
          //         padding: const EdgeInsets.only(bottom: 60),
          //         child: SvgPicture.asset(
          //           AppAssets.splashLogo,
          //           height: 300,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

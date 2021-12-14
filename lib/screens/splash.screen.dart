import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:noisechecker/screens/main.screen.dart';
import 'package:noisechecker/utils/styles.util.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/images/logo_splash.png'),
      logoSize: 45.w,
      backgroundColor: ColorPalettes.navyDark,
      showLoader: false,
      navigator: MainScreen(),
      durationInSeconds: 3,
    );
  }
}

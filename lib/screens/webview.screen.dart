import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noisechecker/utils/custom_text.util.dart';
import 'package:noisechecker/utils/styles.util.dart';
import 'package:sizer/sizer.dart';

class WebScreen extends StatelessWidget {
  static const routeName = '/webscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PrimaryText(
          text: "Exhaust dB Checker",
          fontSize: 14.0.sp,
          color: ColorPalettes.grayLight,
        ),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'MainScreen',
                style: TextStyle(color: ColorPalettes.grayLight),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

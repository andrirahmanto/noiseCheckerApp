import 'package:flutter/material.dart';
import 'package:noisechecker/utils/custom_text.util.dart';
import 'package:get/get.dart';
import 'package:noisechecker/utils/styles.util.dart';
import 'package:sizer/sizer.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/mainscreen';
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 5.w, left: 5.w, right: 5.w),
          width: 100.w,
          color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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

import 'package:flutter/material.dart';
import 'package:noisechecker/screens/webview.screen.dart';
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
              GestureDetector(
                onTap: () {
                  Get.toNamed(WebScreen.routeName);
                },
                child: Container(
                    width: 90.w,
                    padding: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                        color: ColorPalettes.white,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 9,
                          child: PrimaryText(
                            text:
                                "Check the regulation about the limit of exhaust noise on the official Korlantas Polri website",
                            fontSize: 10.sp,
                            color: ColorPalettes.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Icon(Icons.arrow_forward_ios,
                              color: ColorPalettes.black, size: 16.sp),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 10.h,
              ),
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

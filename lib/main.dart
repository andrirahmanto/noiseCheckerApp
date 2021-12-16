import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noisechecker/utils/styles.util.dart';
import 'package:sizer/sizer.dart';

import 'screens/main.screen.dart';
import 'screens/splash.screen.dart';
import 'screens/webview.screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            appBarTheme: AppBarTheme(
              backgroundColor: ColorPalettes.navyLight,
              iconTheme: IconThemeData(color: ColorPalettes.white),
              brightness: Brightness.dark,
            ),
            primarySwatch: Colors.blue,
            fontFamily: 'Poppins',
            backgroundColor: ColorPalettes.navyDark,
            scaffoldBackgroundColor: ColorPalettes.navyDark),
        routes: {
          // SplashScreen.routeName: (ctx) => SplashScreen(),
          MainScreen.routeName: (ctx) => MainScreen(),
          WebScreen.routeName: (ctx) => WebScreen(),
        },
        home: SplashScreen(),
      );
    });
  }
}

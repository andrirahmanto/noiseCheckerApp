import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noisechecker/utils/custom_text.util.dart';
import 'package:noisechecker/utils/styles.util.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatefulWidget {
  static const routeName = '/webscreen';
  @override
  _WebScreenState createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: PrimaryText(
          text: "Web Screen",
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
      body: WebView(
        initialUrl:
            "https://korlantas.polri.go.id/news/razia-knalpot-brong-berikut-ukuran-maksimal-kebisingan-yang-diperbolehkan/",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
// class WebScreen extends StatelessWidget {
//   static const routeName = '/webscreen';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: PrimaryText(
//           text: "Web Screen",
//           fontSize: 14.0.sp,
//           color: ColorPalettes.grayLight,
//         ),
//         centerTitle: true,
//         leading: BackButton(
//           onPressed: () {
//             Get.back();
//           },
//         ),
//       ),
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               SingleChildScrollView(
//                 child: WebView(
//                   initialUrl: 'https://flutter.dev',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

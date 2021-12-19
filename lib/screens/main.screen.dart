import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:noisechecker/models/ChartData.model.dart';
import 'package:noisechecker/screens/webview.screen.dart';
import 'package:noisechecker/utils/custom_text.util.dart';
import 'package:get/get.dart';
import 'package:noisechecker/utils/styles.util.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/mainscreen';
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isRecording = false;
  // ignore: cancel_subscriptions
  StreamSubscription<NoiseReading>? _noiseSubscription;
  late NoiseMeter _noiseMeter;
  double? maxDB;
  double? meanDB;
  List<ChartData> chartData = <ChartData>[];
  // ChartSeriesController? _chartSeriesController;
  late int previousMillis;

  @override
  void initState() {
    super.initState();
    _noiseMeter = NoiseMeter(onError);
  }

  void onData(NoiseReading noiseReading) {
    this.setState(() {
      if (!this._isRecording) this._isRecording = true;
    });
    maxDB = noiseReading.maxDecibel;
    meanDB = noiseReading.meanDecibel;

    chartData.add(
      ChartData(
        maxDB,
        meanDB,
        ((DateTime.now().millisecondsSinceEpoch - previousMillis) / 1000)
            .toDouble(),
      ),
    );
  }

  void onError(Object e) {
    print(e.toString());
    _isRecording = false;
  }

  void start() async {
    previousMillis = DateTime.now().millisecondsSinceEpoch;
    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
    } catch (e) {
      print(e);
    }
  }

  void stop() async {
    try {
      _noiseSubscription!.cancel();
      _noiseSubscription = null;

      this.setState(() => this._isRecording = false);
    } catch (e) {
      print('stopRecorder error: $e');
    }
    previousMillis = 0;
    chartData.clear();
  }

  void copyValue(
    bool theme,
  ) {
    Clipboard.setData(
      ClipboardData(
          text: 'It\'s about ${maxDB!.toStringAsFixed(1)}dB loudness'),
    ).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 2500),
          content: Row(
            children: [
              Icon(
                Icons.check,
                size: 14,
                color: theme ? Colors.white70 : Colors.black,
              ),
              SizedBox(width: 10),
              Text('Copied')
            ],
          ),
        ),
      );
    });
  }

  String getFeedback(double? maxDB) {
    var noise = maxDB ?? 0;
    if (noise > 80) {
      return 'Your exhaust noise exceeds the\nregulatory limit';
    }
    return 'Your exhaust noise is within regulatory\nsafety limits';
  }

  Color getFeedbackColor(double? maxDB) {
    var noise = maxDB ?? 0;
    if (noise > 80) {
      return ColorPalettes.red;
    }
    return ColorPalettes.green;
  }

  @override
  Widget build(BuildContext context) {
    if (chartData.length >= 30) {
      chartData.removeAt(0);
    }
    return Scaffold(
      appBar: AppBar(
        title: PrimaryText(
          text: "Exhaust dB Checker",
          fontSize: 14.0.sp,
          color: ColorPalettes.grayLight,
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(_isRecording ? 'Stop' : 'Start'),
        onPressed: _isRecording ? stop : start,
        icon: !_isRecording ? Icon(Icons.play_arrow) : Icon(Icons.pause),
        backgroundColor: _isRecording ? ColorPalettes.red : ColorPalettes.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 5.w, left: 5.w, right: 5.w),
          width: 100.w,
          // color: Colors.red,
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
                    padding:
                        EdgeInsets.symmetric(vertical: 2.w, horizontal: 5.w),
                    decoration: BoxDecoration(
                        color: ColorPalettes.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
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
                        Spacer(),
                        Flexible(
                          flex: 1,
                          child: Icon(Icons.arrow_forward_ios,
                              color: ColorPalettes.black, size: 16.sp),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 4.h,
              ),
              Container(
                child: Column(
                  children: [
                    PrimaryText(
                      text: maxDB != null
                          ? maxDB!.toStringAsFixed(1) + ' dB'
                          : '0.0 dB',
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w500,
                      color: getFeedbackColor(maxDB),
                    ),
                    Container(
                        constraints: BoxConstraints(
                            minHeight: 10.h, minWidth: double.infinity),
                        padding: EdgeInsets.symmetric(
                            vertical: 2.w, horizontal: 5.w),
                        decoration: BoxDecoration(
                            color: getFeedbackColor(maxDB),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Center(
                          child: PrimaryText(
                            text: getFeedback(maxDB),
                            fontSize: 11.sp,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      width: 90.w,
                      height: 30.h,
                      padding:
                          EdgeInsets.symmetric(vertical: 2.w, horizontal: 5.w),
                      decoration: BoxDecoration(
                          color: ColorPalettes.navyLight,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: SfCartesianChart(
                        series: <LineSeries<ChartData, double>>[
                          LineSeries<ChartData, double>(
                              dataSource: chartData,
                              color: getFeedbackColor(maxDB),
                              xAxisName: 'Time',
                              yAxisName: 'dB',
                              name: 'dB values over time',
                              xValueMapper: (ChartData value, _) =>
                                  value.frames,
                              yValueMapper: (ChartData value, _) => value.maxDB,
                              animationDuration: 0),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

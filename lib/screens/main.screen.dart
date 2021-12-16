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
        icon: !_isRecording ? Icon(Icons.circle) : null,
        backgroundColor: _isRecording ? Colors.red : Colors.green,
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
              Container(
                child: Column(
                  children: [
                    Text(
                      maxDB != null ? maxDB!.toStringAsFixed(2) : 'Press start',
                      style: GoogleFonts.exo2(fontSize: 76),
                    ),
                    Text(
                      meanDB != null
                          ? 'Mean: ${meanDB!.toStringAsFixed(2)}'
                          : 'Awaiting data',
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                    ),
                    SfCartesianChart(
                      series: <LineSeries<ChartData, double>>[
                        LineSeries<ChartData, double>(
                            dataSource: chartData,
                            xAxisName: 'Time',
                            yAxisName: 'dB',
                            name: 'dB values over time',
                            xValueMapper: (ChartData value, _) => value.frames,
                            yValueMapper: (ChartData value, _) => value.maxDB,
                            animationDuration: 0),
                      ],
                    ),
                    SizedBox(
                      height: 68,
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

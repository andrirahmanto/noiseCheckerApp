import 'package:flutter/material.dart';
import 'package:noisechecker/utils/styles.util.dart';
import 'package:styled_text/styled_text.dart';
import 'package:sizer/sizer.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;

  CustomText(
      {required this.text,
      required this.fontSize,
      this.fontWeight = FontWeight.w500,
      this.color = ColorPalettes.black,
      this.maxLines = 1,
      this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return StyledText(
      text: text,
      maxLines: maxLines,
      textAlign: textAlign!,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}

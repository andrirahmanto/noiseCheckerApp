import 'package:flutter/material.dart';
import 'package:noisechecker/utils/styles.util.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;

  const PrimaryText({
    required this.text,
    required this.fontSize,
    this.color: ColorPalettes.white,
    this.fontWeight: FontWeight.w700,
    this.overflow: TextOverflow.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: 'Poppins',
        fontWeight: fontWeight,
      ),
    );
  }
}
// class CustomText extends StatelessWidget {
//   final String text;
//   final double fontSize;
//   final FontWeight? fontWeight;
//   final Color? color;
//   final int? maxLines;
//   final TextAlign? textAlign;

//   CustomText(
//       {required this.text,
//       required this.fontSize,
//       this.fontWeight = FontWeight.w500,
//       this.color = ColorPalettes.black,
//       this.maxLines = 1,
//       this.textAlign = TextAlign.left});

//   @override
//   Widget build(BuildContext context) {
//     return StyledText(
//       text: text,
//       maxLines: maxLines,
//       textAlign: textAlign!,
//       style: TextStyle(
//         fontSize: fontSize,
//         fontWeight: fontWeight,
//         color: color,
//       ),
//     );
//   }
// }

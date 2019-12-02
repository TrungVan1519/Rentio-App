import 'package:flutter/cupertino.dart';

class ReusableAttributes {
  double fontSize;
  FontWeight fontWeight;
  Color color;

  ReusableAttributes({this.fontSize, this.fontWeight, this.color});

  TextStyle setTextStyle() {
    return TextStyle(fontWeight: fontWeight, fontSize: fontSize, color: color);
  }
}

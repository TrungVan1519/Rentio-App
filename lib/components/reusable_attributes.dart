// Chu thich (Trung): cai nay la de phuc vu viec reuse cac thuoc tinh neu
//    sau nay can, hien tai chua can dung den, neu sau nay dung thi xoa cmt
//    nay di

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

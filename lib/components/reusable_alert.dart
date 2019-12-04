import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ReusableAlert {
  BuildContext context;
  String title;
  String desc;

  ReusableAlert({@required this.context, this.title, this.desc});

  Future<bool> getAlert() async {
    return await Alert(
      context: context,
      style: AlertStyle(),
      type: AlertType.info,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          child: Text(
            'OK',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(30.0),
        ),
      ],
    ).show();
  }
}

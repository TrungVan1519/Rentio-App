import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentio/utilities/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ReusableAlert {
  final BuildContext context;
  final String title;
  final String desc;
  final List<DialogButtonInfoModel> list;

  ReusableAlert({@required this.context, this.title, this.desc, this.list});

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

  Future<bool> getUserOption() {
    List<DialogButton> dialogButtonList = [];
    for (var item in list) {
      dialogButtonList.add(
        DialogButton(
          onPressed: item.onPressed,
          color: item.color,
          radius: BorderRadius.circular(30.0),
          child: Text(
            item.contentOption,
            style: TextStyle(
              color: Colors.white,
              fontSize: kFontLabelSize,
            ),
          ),
        ),
      );
    }

    return Alert(
      context: context,
      type: AlertType.success,
      title: title,
      desc: desc,
      buttons: dialogButtonList,
    ).show();
  }
}

class DialogButtonInfoModel {
  final String contentOption;
  final Color color;
  final Function onPressed;

  DialogButtonInfoModel(
      {@required this.contentOption,
      @required this.color,
      @required this.onPressed});
}

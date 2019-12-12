import 'package:flutter/material.dart';
import 'package:rentio/local_json_getter/sign_in_json_getter.dart';

class NotificationScreen extends StatefulWidget {
  static String routeName = 'notificationScreen';
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var jsonData;

  Future getJson() async {
    return await JsonGetter(jsonFileName: 'data/').loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

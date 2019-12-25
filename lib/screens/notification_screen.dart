import 'dart:io';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'package:rentio/local_json_getter/sign_in_json_getter.dart';
import 'package:rentio/utilities/constants.dart';

class NotificationScreen extends StatefulWidget {
  static String routeName = 'notificationScreen';

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var jsonData;

  // Future getJson() async {
  //   return await JsonGetter(jsonFileName: 'data/').loadData();
  // }

  List<Widget> notificationList = [
    ListTile(
      leading: Icon(
        Icons.notifications,
        color: Colors.red,
        size: 30.0,
      ),
      title: Text('Hello!'),
      subtitle: Text('Hello again!'),
    ),
    ListTile(
      leading: Icon(
        Icons.notifications,
        color: Colors.red,
        size: 30.0,
      ),
      title: Text('Hello!'),
      subtitle: Text('Hello again!'),
    ),
    ListTile(
      leading: Icon(
        Icons.notifications,
        color: Colors.green,
        size: 30.0,
      ),
      title: Text('Hello!'),
      subtitle: Text('Hello again!'),
    ),
    ListTile(
      leading: Icon(
        Icons.notifications,
        color: Colors.green,
        size: 30.0,
      ),
      title: Text('Hello!'),
      subtitle: Text('Hello again!'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Color(kGradientColorElement2),
                Color(kGradientColorElement1),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: notificationList.length,
        itemBuilder: (context, index) {
          return notificationList[index];
        },
      ),
    );
  }
}

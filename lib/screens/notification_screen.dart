import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rentio/global_data/notification_data.dart';
import 'package:rentio/local_json_getter/sign_in_json_getter.dart';
import 'package:rentio/screens/request_for_renting_screen.dart';
import 'package:rentio/utilities/constants.dart';

class NotificationScreen extends StatefulWidget {
  static String routeName = 'notificationScreen';

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  //

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
      body: ListView(
        children: notificationList,
      ),
    );
  }
}

List<Widget> notificationList = [
  ListTile(
    onTap: () {
      
    },
    leading: Icon(
      Icons.notifications,
      color: Colors.red,
      size: 30.0,
    ),
    title: Text('Someone want to rent your pencil!'),
    subtitle: Text('Name: Nguyen Thanh Tung,...'),
  ),
  ListTile(
    onTap: () {},
    leading: Icon(
      Icons.notifications,
      color: Colors.green,
      size: 30.0,
    ),
    title: Text('Your request for your desk has been accepted!'),
    subtitle: Text('Start date: 23/12/2019...'),
  ),
];

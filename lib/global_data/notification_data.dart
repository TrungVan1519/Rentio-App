import 'package:http/http.dart' as http;
import 'package:rentio/global_data/global_user.dart';
import 'package:rentio/services/http_executioner.dart';
import 'dart:convert';

import 'package:rentio/utilities/constants.dart';

class NotificationData {
  static var jsonData;
  static http.Response responseGet;
  static List notificationList = [];

  static void listenToNoti() async {
    responseGet = await HttpExecutioner.get(
      requestURL:
          "$apiURL/notification/renters/${GlobalUser.globalUser.userID}",
      headers: {
        'content-type': 'application/json',
        'authorization': 'JWT ${GlobalUser.globalUser.id}'
      },
    );
  }

  static void startListening() async {
    while (true) {
      listenToNoti();
      jsonData = await json.decode(responseGet.body);
      if (jsonData['requested_orders'].length > 0) {
        for (int i = 0; i < jsonData['requested_orders'].length; i++) {
          notificationList.add(jsonData['requested_orders'][i]);
        }
      }
      new Future.delayed(Duration(seconds: 5));
    }
  }
}

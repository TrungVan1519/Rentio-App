import 'package:flutter/material.dart';
import 'package:rentio/global_data/global_user.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NotiListener {
  static WebSocketChannel renterChannel;
  static WebSocketChannel lenderChannel;
  static WebSocketChannel expiringChannel;
  static WebSocketChannel expiredChannel;
  static void startListening() {
    renterChannel = IOWebSocketChannel.connect(
        'http://192.168.2.107:8080/notification/renters/${GlobalUser.globalUser.userID}');
    lenderChannel = IOWebSocketChannel.connect(
        'http:/192.168.2.107:8080/notification/lenders/${GlobalUser.globalUser.userID}');
    expiringChannel = IOWebSocketChannel.connect(
        'http:/192.168.2.107:8080/notification/renters/${GlobalUser.globalUser.userID}/expiring');
    expiredChannel = IOWebSocketChannel.connect(
        'http:/192.168.2.107:8080/notification/renters/${GlobalUser.globalUser.userID}/expired');
  }
}

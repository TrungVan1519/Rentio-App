import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class NotiListener {
  static var renterChannel;
  static var lenderChannel;
  static var expiringChannel;
  static var expiredChannel;
  static void startListening() {
    renterChannel = IOWebSocketChannel.connect('http://192.168.2.107:8080/');
    lenderChannel = IOWebSocketChannel.connect('http:/192.168.2.107:8080/');
    expiringChannel = IOWebSocketChannel.connect('http:/192.168.2.107:8080/');
    expiredChannel = IOWebSocketChannel.connect('http:/192.168.2.107:8080/');
  }
}

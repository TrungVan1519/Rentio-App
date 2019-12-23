import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:rentio/global_data/global_user.dart';
import 'package:rentio/global_data/global_user.dart';

class HttpExecutioner {
  static Future<dynamic> post(
      {@required String requestURL,
      @required Map<String, String> headers,
      @required dynamic body}) async {
//    HttpClient httpClient = new HttpClient();
//    HttpClientRequest request = await httpClient.postUrl(Uri.parse(requestURL));
//    request.headers.set('content-type', 'application/json');
//    request.add(utf8.encode(json.encode(body)));
//    HttpClientResponse response = await request.close();
//    String reply = await response.transform(utf8.decoder).join();
//    httpClient.close();
//    return reply;

    http.Response response = await http.post(
      requestURL,
      headers: headers,
      body: utf8.encode(json.encode(body)),
    );

    if (response.statusCode < 200 || response.statusCode > 400) {
      throw new Exception('Error while fetching data');
    }
    return response;
  }

  static Future<dynamic> get(
      {String requestURL, Map<String, String> headers}) async {
    http.Response response = await http.get(
      requestURL,
      headers: headers,
    );

    if (response.statusCode < 200 || response.statusCode > 400) {
      throw new Exception('Error while geting data');
    }
    return response;
  }
}

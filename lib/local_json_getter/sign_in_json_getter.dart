import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class JsonGetter {
  Future<String> _loadJson(String jsonFileName) async {
    String jsonString = await rootBundle.loadString(jsonFileName);
    return jsonString;
  }

  Future<dynamic> loadData({String jsonFileName}) async {
    String jsonData = await _loadJson(jsonFileName);
    return json.decode(jsonData);
  }
}

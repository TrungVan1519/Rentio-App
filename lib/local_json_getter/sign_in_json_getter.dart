import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class JsonGetter {
  String jsonNameFile;

  JsonGetter({this.jsonNameFile});

  Future<String> _loadJson() async {
    return await rootBundle.loadString(jsonNameFile);
  }

  Future<dynamic> loadData() async {
    await Future.delayed(Duration(seconds: 5), () => {});
    String jsonString = await _loadJson();
    return json.decode(jsonString);
  }

  Future<dynamic> loadDataWithoutDelay() async {
    String jsonString = await _loadJson();
    return json.decode(jsonString);
  }
}

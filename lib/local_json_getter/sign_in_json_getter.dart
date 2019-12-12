import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class JsonGetter {
  String jsonFileName;

  JsonGetter({this.jsonFileName});

  Future<String> _loadJson() async {
    return await rootBundle.loadString(jsonFileName);
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

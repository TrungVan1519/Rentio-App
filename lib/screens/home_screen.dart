import 'package:flutter/material.dart';
import 'package:rentio/components/reusable_item_card.dart';
import 'package:rentio/local_json_getter/sign_in_json_getter.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var jsonData;

  void getJson() async {
    jsonData =
        await JsonGetter(jsonNameFile: 'data/popular_product.json').loadData();
  }

  @override
  void initState() {
    getJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}

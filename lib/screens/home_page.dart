import 'package:flutter/material.dart';
import 'package:rentio/services/search_engine.dart';
import 'package:rentio/components/reusable_item_card.dart';
import 'package:rentio/screens/account_screen.dart';
import 'package:rentio/screens/category_screen.dart';
import 'package:rentio/screens/notification_screen.dart';
import 'package:rentio/utilities/constants.dart';
import 'package:rentio/utilities/try_new_widget.dart';
import 'dart:convert';
import '../models/product_in_stock.dart';
import '../local_json_getter/sign_in_json_getter.dart';
import 'home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:rentio/services/http_executioner.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List<Widget> widgetOption = [
    HomeScreen(),
    CategoryScreen(),
    NotificationScreen(),
    AccountScreen()
  ];

  var jsonData;

  Future getInitProductData() async {
    // return await JsonGetter(jsonFileName: 'data/get_all_products.json')
    //     .loadData();
    http.Response responseGet = await HttpExecutioner.get(
      requestURL: "$apiURL/api/products",
      headers: {
        "content-type": "application/json",
      },
    );

    return await json.decode(responseGet.body);
  }

  Future getInitProductJson() async {
    var json = await getInitProductData();
    return json;
  }

  @override
  void initState() {
    super.initState();
    getInitProductData().then((result) {
      jsonData = result;
    }).then((_) {
      for (int i = 0; i < jsonData['products'].length; i++) {
        productInStockList.add(ProductInStock(
          id: jsonData['products'][i]['id'],
          name: jsonData['products'][i]['name'],
          status: jsonData['products'][i]['status'],
          daily_price: jsonData['products'][i]['daily_price'],
          weekly_price: jsonData['products'][i]['weekly_price'],
          monthly_price: jsonData['products'][i]['monthly_price'],
          user_id: jsonData['products'][i]['user_id'],
        ));
      }
    }).then((_) {
      for (int i = 0; i < jsonData['products'].length; i++) {
        print(jsonData['products'][i]['name']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: widgetOption.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Category'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notification'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Account'),
          )
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Color(0xFF43C6AC),
        onTap: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

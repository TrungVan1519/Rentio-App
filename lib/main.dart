import 'package:flutter/material.dart';
import 'package:rentio/screens/account_screen.dart';
import 'package:rentio/screens/category_screen.dart';
import 'package:rentio/screens/home_page.dart';
import 'package:rentio/screens/home_screen.dart';
import 'package:rentio/screens/lending_screen.dart';
import 'package:rentio/screens/list_items_screen.dart';
import 'package:rentio/screens/notification_screen.dart';
import 'package:rentio/screens/product_detail_screen.dart';
import 'package:rentio/screens/product_list.dart';
import 'package:rentio/screens/signin_screen.dart';
import 'package:rentio/screens/signup_screen.dart';
import 'package:rentio/services/zip_extractor.dart';
import 'package:rentio/utilities/try_new_widget.dart';

import 'mainscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Color(0xFFF3F3F7),
      ),
      home: HomePage(),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        CategoryScreen.routeName: (context) => CategoryScreen(),
        NotificationScreen.routeName: (context) => NotificationScreen(),
        ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
        ListItemsScreen.routeName: (context) => ListItemsScreen(),
        ProductListScreen.routeName: (context) => ProductListScreen(),
      },
    );
  }
}

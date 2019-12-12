import 'package:flutter/material.dart';
import 'package:rentio/screens/account_screen.dart';
import 'package:rentio/screens/category_screen.dart';
import 'package:rentio/screens/home_page.dart';
import 'package:rentio/screens/home_screen.dart';
import 'package:rentio/screens/lending_screen.dart';
import 'package:rentio/screens/notification_screen.dart';
import 'package:rentio/screens/product_detail_screen.dart';
import 'package:rentio/screens/signin_screen.dart';
import 'package:rentio/screens/signup_screen.dart';

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
      home: ProductDetailScreen(),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        CategoryScreen.routeName: (context) => CategoryScreen(),
        NotificationScreen.routeName: (context) => NotificationScreen(),
        ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
      },
    );
  }
}

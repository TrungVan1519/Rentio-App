import 'package:flutter/material.dart';
import 'package:rentio/components/reusable_item_card.dart';
import 'package:rentio/screens/account_screen.dart';
import 'package:rentio/screens/category_screen.dart';
import 'package:rentio/utilities/constants.dart';
import 'package:rentio/utilities/try_new_widget.dart';

import 'home_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List<Widget> widgetOption = [
    HomeScreen(),
    CategoryScreen(),
    MyTestWidget(),
    AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Color(kGradientColorElement2),
                Color(kGradientColorElement1),
              ],
            ),
          ),
        ),
        title: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                'Rentio',
              ),
            ),
            Flexible(
              child: TextField(
                style: TextStyle(
                  fontSize: kFontLabelSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                //controller: editingController,
                decoration: InputDecoration(
                  hintText: "Bạn cần tìm gì...",
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                  prefixIcon: Icon(Icons.search),
//                  border: OutlineInputBorder(
//                    borderRadius: BorderRadius.all(
//                      Radius.circular(25.0),
//                    ),
//                  ),
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            alignment: Alignment.centerRight,
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductSearch(),
              );
            },
          ),
        ],
      ),
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
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
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

class ProductSearch extends SearchDelegate<Product> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () {}),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return null;
  }
}

class Product {}

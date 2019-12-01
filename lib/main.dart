import 'package:flutter/material.dart';
import 'package:rentio/component/reusable_item_card.dart';
import 'package:rentio/screens/category_screen.dart';
import 'package:rentio/screens/home_screen.dart';
import 'package:rentio/utility/try_new_widget.dart';

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
      //home: HomePage(),
      home: HomePage(),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        CategoryScreen.routeName: (context) => CategoryScreen(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List<Widget> widgetOption = [
    HomeScreen(),
    ReusableItemCard(
      productName: 'Ao Son Tung',
      productAddress: 'Thanh Xuan',
      price: 123456,
      imageUrl:
          'https://i.kym-cdn.com/entries/icons/original/000/027/475/Screen_Shot_2018-10-25_at_11.02.15_AM.png',
    ),
    MyTestWidget(),
    Text(
      'Index 3: Baby',
    ),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rentio'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Color(0xFF191654),
                Color(0xFF43C6AC),
              ],
            ),
          ),
        ),

        // Flexible(
        //   child: TextField(
        //     //controller: editingController,
        //     decoration: InputDecoration(
        //       hintText: "Bạn cần tìm gì...",
        //       prefixIcon: Icon(Icons.search),
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.all(
        //           Radius.circular(25.0),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

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
            icon: Icon(Icons.home),
            title: Text('Home'),
          )
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Color(0xFF43C6AC),
        onTap: onItemTapped,
      ),
    );
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

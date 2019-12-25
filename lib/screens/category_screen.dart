import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rentio/components/reusable_item_card.dart';
import 'package:rentio/local_json_getter/sign_in_json_getter.dart';
import 'package:rentio/screens/list_items_screen.dart';
import 'package:rentio/screens/product_list.dart';
import 'package:rentio/services/search_engine.dart';
import 'package:rentio/utilities/constants.dart';
import 'package:rentio/utilities/try_new_widget.dart';
import 'package:http/http.dart' as http;
import 'package:rentio/services/http_executioner.dart';

class CategoryScreen extends StatefulWidget {
  static String routeName = 'categoryScreen';
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var jsonData;

  Future getData() async {
    //return await JsonGetter(jsonFileName: 'data/catalog.json').loadData();
    http.Response responseGet = await HttpExecutioner.get(
      requestURL: "http://192.168.2.107:8080/api/catalog",
      headers: {
        "content-type": "application/json",
      },
    );

    return json.decode(responseGet.body);
  }

  Future getJson() async {
    var json = await getData();
    return json;
  }

  @override
  void initState() {
    getJson().then((result) {
      setState(() {
        jsonData = result;
      });
    });
    super.initState();
  }

  Widget loadLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget loadWidgetWithData() {
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
                  // prefixIcon: Icon(Icons.search),
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ReusableItemCard(
                  isProduct: false,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductListScreen(
                          title: '',
                          jsonFileName: 'data/product_based_on_catalog.json',
                        ),
                      ),
                    );
                  },
                  catalogName: jsonData['catalogs'][index]['type'],
                  imageUrl:
                      'https://external-preview.redd.it/Rmryan2W90zOKh0uuFeLXlJZ5CPCA-hOmnvv2NFPCCQ.jpg?auto=webp&s=e74d779c246115721c0fe14ed9a36b611a8ad11f',
                );
              },
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: jsonData == null ? loadLoadingWidget() : loadWidgetWithData(),
    );
  }
}

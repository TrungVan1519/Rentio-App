import 'package:flutter/material.dart';
import 'package:rentio/components/reusable_item_card.dart';
import 'package:rentio/local_json_getter/sign_in_json_getter.dart';
import 'package:rentio/screens/product_detail_screen.dart';
import 'package:rentio/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:rentio/services/http_executioner.dart';
import 'dart:convert';

class ProductListScreen extends StatefulWidget {
  static String routeName = 'productListScreen';
  final String title;
  final String jsonFileName;
  final String searchedName;

  ProductListScreen({this.title, this.jsonFileName, this.searchedName});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  var jsonData;

  Future getDataBasedOnTitle() async {
    // return await JsonGetter(jsonFileName: widget.jsonFileName).loadData();
    http.Response responseGet = await HttpExecutioner.get(
      requestURL: "$apiURL/api/products/catalog/${widget.title.toLowerCase()}",
      headers: {
        'content-type': 'application/json',
      },
    );

    return json.decode(responseGet.body);
  }

  Future getJsonBasedOnTitle() async {
    var json = await getDataBasedOnTitle();
    return json;
  }

  Future getDataBasedOnProductName() async {
    // return await JsonGetter(jsonFileName: widget.jsonFileName).loadData();
    http.Response responseGet = await HttpExecutioner.get(
      requestURL: "$apiURL/api/products/posts/${widget.searchedName}",
      headers: {
        'content-type': 'application/json',
      },
    );

    return json.decode(responseGet.body);
  }

  Future getJsonBasedOnProductName() async {
    var json = await getDataBasedOnProductName();
    return json;
  }

  @override
  void initState() {
    if (widget.searchedName != null) {
      getJsonBasedOnProductName().then((result) {
        print(result);
        setState(() {
          jsonData = result;
        });
      });
    } else {
      getJsonBasedOnTitle().then((result) {
        setState(() {
          jsonData = result;
        });
      });
    }
    super.initState();
  }

  Widget loadLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget loadWidgetWithData() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ReusableItemCard(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product_id: jsonData['products'][index]['product_id'],
                          productName: jsonData['products'][index]['name'],
                          productAddress: jsonData['products'][index]
                              ['address'],
                          daily_price: jsonData['products'][index]
                              ['daily_price'],
                          weekly_price: jsonData['products'][index]
                              ['weekly_price'],
                          monthly_price: jsonData['products'][index]
                              ['monthly_price'],
                          lender_id: jsonData['products'][index]['user_id'],
                        ),
                      ),
                    );
                  },
                  isProduct: true,
                  productName: jsonData['products'][index]['name'],
                  price: jsonData['products'][index]['daily_price'],
                  imageUrl: 'image/default_product_image.jpg'),
            ),
            childCount: jsonData['products'].length,
          ),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.toString()),
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
      ),
      body: jsonData == null ? loadLoadingWidget() : loadWidgetWithData(),
    );
  }
}

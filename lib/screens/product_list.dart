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
  ProductListScreen({this.title, this.jsonFileName});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  var jsonData;

  Future getInitData() async {
    // return await JsonGetter(jsonFileName: widget.jsonFileName).loadData();
    http.Response responseGet = await HttpExecutioner.get(
      requestURL:
          "http://192.168.2.107:8080/api/products/catalog/${widget.title}",
      headers: {
        'content-type': 'application/json',
      },
    );

    return json.decode(responseGet.body);
  }

  Future getInitJson() async {
    var json = await getInitData();
    return json;
  }

  @override
  void initState() {
    getInitJson().then((result) {
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
                          jsonData: jsonData['products'][index],
                        ),
                      ),
                    );
                  },
                  isProduct: true,
                  productName: jsonData['products'][index]['name'],
                  price: jsonData['products'][index]['daily_price'],
                  imageUrl: 'https://www.w3schools.com/w3css/img_lights.jpg'),
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

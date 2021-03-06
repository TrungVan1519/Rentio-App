import 'package:flutter/material.dart';
import 'package:rentio/components/reusable_item_card.dart';
import 'package:rentio/components/reusable_person_card.dart';
import 'package:rentio/screens/product_detail_screen.dart';
import 'package:rentio/services/http_executioner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rentio/utilities/constants.dart';

class SeeMorePopularProductScreen extends StatefulWidget {
  @override
  _SeeMorePopularProductScreenState createState() =>
      _SeeMorePopularProductScreenState();
}

class _SeeMorePopularProductScreenState
    extends State<SeeMorePopularProductScreen> {
  var jsonData;

  Future getPopularProductData() async {
    http.Response responseGet = await HttpExecutioner.get(
      requestURL: "$apiURL/api/products/popular",
      headers: {
        "content-type": "application/json",
      },
    );

    return await json.decode(responseGet.body);
  }

  Future getPopularProductJson() async {
    // return await JsonGetter(jsonFileName: 'data/popular_product.json')
    //     .loadData();
    var json = await getPopularProductData();
    return json;
  }

  Widget loadLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget popularProductWidget() {
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
  void initState() {
    getPopularProductJson().then((result) {
      setState(() {
        jsonData = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFFF3F3F7),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
        ),
      ),
      body: jsonData == null ? loadLoadingWidget() : popularProductWidget(),
    );
  }
}

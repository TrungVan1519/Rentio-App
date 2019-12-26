import 'package:flutter/material.dart';
import 'package:rentio/components/reusable_item_card.dart';
import 'package:rentio/components/reusable_person_card.dart';
import 'package:rentio/services/http_executioner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      requestURL: "http://192.168.2.107:8080/api/products/popular",
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
                  onPressed: () {},
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

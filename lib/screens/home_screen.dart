import 'package:flutter/material.dart';
import 'package:rentio/screens/product_detail_screen.dart';
import 'package:rentio/screens/see_more_popular_product.dart';
import 'package:rentio/screens/see_more_top_lender.dart';
import 'package:rentio/services/search_engine.dart';
import 'package:rentio/components/reusable_item_card.dart';
import 'package:rentio/components/reusable_person_card.dart';
import 'package:rentio/local_json_getter/sign_in_json_getter.dart';
import 'package:rentio/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:rentio/services/http_executioner.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  static String routeName = 'homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var popularProductData;
  var topLenderData;

  Future getTopLenderData() async {
    http.Response responseGet = await HttpExecutioner.get(
      requestURL: "$apiURL/api/top_lender",
      headers: {
        "content-type": "application/json",
      },
    );
    return await json.decode(responseGet.body);
  }

  Future getTopLenderJson() async {
    // return await JsonGetter(jsonFileName: 'data/top_lender.json').loadData();
    var json = await getTopLenderData();
    return json;
  }

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

  Widget loadWidgetWithData() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverFixedExtentList(
          itemExtent: 100.0,
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding:
                    const EdgeInsets.only(left: 28.0, top: 60.0, bottom: 10.0),
                child: Text(
                  'Sản phẩm phổ biến',
                  style: TextStyle(fontSize: kFontTextSize),
                ),
              ),
            ],
          ),
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ReusableItemCard(
                  isProduct: true,
                  productName: popularProductData['products'][index]['name'],
                  productAddress: popularProductData['products'][index]
                      ['address'],
                  price: popularProductData['products'][index]['daily_price'],
                  imageUrl:
                      'https://external-preview.redd.it/Rmryan2W90zOKh0uuFeLXlJZ5CPCA-hOmnvv2NFPCCQ.jpg?auto=webp&s=e74d779c246115721c0fe14ed9a36b611a8ad11f',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product_id: popularProductData['products'][index]
                              ['product_id'],
                          productName: popularProductData['products'][index]
                              ['name'],
                          productAddress: popularProductData['products'][index]
                              ['address'],
                          daily_price: popularProductData['products'][index]
                              ['daily_price'],
                          weekly_price: popularProductData['products'][index]
                              ['weekly_price'],
                          monthly_price: popularProductData['products'][index]
                              ['monthly_price'],
                          lender_id: popularProductData['products'][index]
                              ['user_id'],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            childCount: popularProductData['products'].length > 4
                ? 4
                : popularProductData['products'].length,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 35.0,
          delegate: SliverChildListDelegate(
            [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 40.0),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeeMorePopularProductScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Xem them',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 65.0,
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding:
                    const EdgeInsets.only(left: 28.0, top: 20.0, bottom: 10.0),
                child: Text(
                  'Top người cho thuê',
                  style: TextStyle(fontSize: kFontTextSize),
                ),
              ),
            ],
          ),
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ReusablePersonCard(
                  onPressed: () {},
                  personName: topLenderData['top_lender'][index]['first_name'] +
                      ' ' +
                      topLenderData['top_lender'][index]['last_name'],
                  personRating: topLenderData['top_lender'][index]
                      ['average_star'],
                  imageUrl:
                      'https://external-preview.redd.it/Rmryan2W90zOKh0uuFeLXlJZ5CPCA-hOmnvv2NFPCCQ.jpg?auto=webp&s=e74d779c246115721c0fe14ed9a36b611a8ad11f',
                ),
              );
            },
            childCount: topLenderData['top_lender'].length > 4
                ? 4
                : topLenderData['top_lender'].length,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 65.0,
          delegate: SliverChildListDelegate(
            [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 40.0),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeeMoreTopLenderScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Xem them',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    // get json data ".then" update states to reload the screen
    getTopLenderJson().then((result) {
      print(result);
      setState(() {
        topLenderData = result;
      });
    });
    getPopularProductJson().then((result) {
      print(result);
      setState(() {
        popularProductData = result;
      });
    });
    super.initState();
  }

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
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: ProductSearch(),
                  );
                },
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
      // jsonData will check if null then render loading idicator, else the widget tree
      body: popularProductData == null
          ? loadLoadingWidget()
          : loadWidgetWithData(),
    );
  }
}

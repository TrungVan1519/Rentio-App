import 'package:flutter/material.dart';
import 'package:rentio/screens/product_detail_screen.dart';
import 'package:rentio/screens/see_more_screen.dart';
import 'package:rentio/services/search_engine.dart';
import 'package:rentio/components/reusable_item_card.dart';
import 'package:rentio/components/reusable_person_card.dart';
import 'package:rentio/local_json_getter/sign_in_json_getter.dart';
import 'package:rentio/utilities/constants.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var popularProductData;
  var topLenderData;

  Future getTopLenderJson() async {
    return await JsonGetter(jsonFileName: 'data/top_lender.json').loadData();
  }

  Future getPopularProductJson() async {
    return await JsonGetter(jsonFileName: 'data/popular_product.json')
        .loadData();
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
          SliverFixedExtentList(
            itemExtent: 100.0,
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 28.0, top: 60.0, bottom: 10.0),
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
                          builder: (context) => ProductDetailScreen(),
                        ),
                      );
                    },
                  ),
                );
              },
              childCount: 4,
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
                              builder: (context) => SeeMoreScreen(
                                type: 'product',
                                jsonData: popularProductData,
                              ),
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
                  padding: const EdgeInsets.only(
                      left: 28.0, top: 20.0, bottom: 10.0),
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
                    personName: topLenderData['lenders'][index]['first_name'] +
                        ' ' +
                        topLenderData['lenders'][index]['last_name'],
                    personRating: topLenderData['lenders'][index]
                        ['average_star'],
                    imageUrl:
                        'https://external-preview.redd.it/Rmryan2W90zOKh0uuFeLXlJZ5CPCA-hOmnvv2NFPCCQ.jpg?auto=webp&s=e74d779c246115721c0fe14ed9a36b611a8ad11f',
                  ),
                );
              },
              childCount: 4,
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
                              builder: (context) => SeeMoreScreen(
                                type: 'lenders',
                                jsonData: topLenderData,
                              ),
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
      ),
    );
  }

  @override
  void initState() {
    // get json data ".then" update states to reload the screen
    getTopLenderJson().then((result) {
      setState(() {
        topLenderData = result;
      });
    });
    getPopularProductJson().then((result) {
      setState(() {
        popularProductData = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // jsonData will check if null then render loading idicator, else the widget tree
      body: popularProductData == null
          ? loadLoadingWidget()
          : loadWidgetWithData(),
    );
  }
}

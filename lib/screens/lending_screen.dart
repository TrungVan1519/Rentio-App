import 'package:flutter/material.dart';
import 'package:rentio/components/reusable_item_card.dart';
import 'package:rentio/local_json_getter/sign_in_json_getter.dart';
import 'package:rentio/utilities/constants.dart';

class LendingScreen extends StatefulWidget {
  @override
  _LendingScreenState createState() => _LendingScreenState();
}

class _LendingScreenState extends State<LendingScreen> {
  var data;
  List<Object> list;

  Future initJsonData() async {
    return await JsonGetter(jsonNameFile: 'data/response_product_in_stock.json')
        .loadData();
  }

  @override
  void initState() {
    super.initState();
    initJsonData().then((result) {
      setState(() {
        data = result;
//        list
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(kGradientColorElement1),
                  Color(kGradientColorElement2)
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                        image: DecorationImage(
                          image: AssetImage('images/default_app_avatar.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'User name',
                        style: TextStyle(
                            fontSize: kFontTextSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        width: 120,
                        child: Text(
                          'Phone number',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        width: 120,
                        child: Text(
                          'Email',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Danh sach san pham cho thue',
                    style: TextStyle(
                      fontSize: kFontTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomScrollView(
                    shrinkWrap: true,
                    slivers: <Widget>[
                      SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => ReusableItemCard(
                            productName: data['products'][index]['name'],
                            price: data['products'][1]['daily_price'],
                            imageUrl:
                                'images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                          ),
                          childCount: 2,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

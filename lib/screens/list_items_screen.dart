import 'package:flutter/material.dart';
import 'package:rentio/components/reusable_alert.dart';
import 'package:rentio/components/reusable_item_card.dart';
import 'package:rentio/components/reusable_loading_card.dart';
import 'package:rentio/global_data/global_user.dart';
import 'package:rentio/local_json_getter/sign_in_json_getter.dart';
import 'package:rentio/screens/product_detail_screen.dart';
import 'package:rentio/services/http_executioner.dart';
import 'package:http/http.dart' as http;

class ListItemsScreen extends StatefulWidget {
  static String routeName = "/ListItemScreen";

  final String title;
  final String jsonFileName;
  final String option;
  ListItemsScreen({this.title, this.jsonFileName, this.option});

  @override
  _ListItemsScreenState createState() => _ListItemsScreenState();
}

class _ListItemsScreenState extends State<ListItemsScreen> {
  var data;

  Future initJsonData() async {
    var data;

    // Cho thue
    if (widget.option == 'lending') {
      http.Response responseGetOrder = await HttpExecutioner.get(
        requestURL:
            'http://192.168.2.107:8080//api/products/order/${GlobalUser.globalUser.userID}/requests',
        headers: {
          "content-type": "application/json",
          'authorization': 'JWT ${GlobalUser.globalUser.id}'
        },
      );
      if (responseGetOrder.statusCode == 200) {
//        List<int> idProductList = await

        http.Response responseGetProduct = await HttpExecutioner.get(
          requestURL: "",
        );

        ReusableAlert(
          context: context,
          title: 'Wait for loading',
          desc: 'Product list is loading',
        ).getAlert();
      } else {
        ReusableAlert(
          context: context,
          title: 'Cannot be loaded',
          desc: 'Product list cannot be loaded',
        ).getAlert();
      }
    }

    // Thue
    if (widget.option == 'renting') {
      http.Response responseGetOrder = await HttpExecutioner.get(
        requestURL:
            'http://192.168.2.107:8080//api/products/order/${GlobalUser.globalUser.userID}/responses',
        headers: {
          "content-type": "application/json",
          'authorization': 'JWT ${GlobalUser.globalUser.id}'
        },
      );
      if (responseGetOrder.statusCode == 200) {
        ReusableAlert(
          context: context,
          title: 'Wait for loading',
          desc: 'Product list is loading',
        ).getAlert();
      } else {
        ReusableAlert(
          context: context,
          title: 'Cannot be loaded',
          desc: 'Product list cannot be loaded',
        ).getAlert();
      }
    }

    return data;
  }

  @override
  void initState() {
    super.initState();

    // Co tac dung chay ngay sau khi build xong cay UI (hay noi cach khac chay ngay
    //    sau khi ham override build chay xong)
//    WidgetsBinding.instance.addPostFrameCallback((_) {
//      initJsonData().then((result) {
//        setState(() {
//          data = result;
//          print(data);
//        });
//      });
//    });

    initJsonData().then((result) {
      setState(() {
        data = result;
        print('data2:$data');
      });
    });
  }

  Widget loadLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget loadWidgetWithData() {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ReusableItemCard(
              isProduct: true,
              productName: data['products'][index]['name'],
              productAddress: 'abc',
              price: data['products'][index]['daily_price'],
              imageUrl: 'https://www.w3schools.com/w3css/img_lights.jpg',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(),
                  ),
                );
              },
            ),
            childCount: data['products'].length,
          ),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: data == null ? loadLoadingWidget() : loadWidgetWithData(),
    );
  }
}

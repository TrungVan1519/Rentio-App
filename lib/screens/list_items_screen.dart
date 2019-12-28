import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:rentio/components/reusable_alert.dart';
import 'package:rentio/components/reusable_item_card.dart';
import 'package:rentio/components/reusable_loading_card.dart';
import 'package:rentio/global_data/global_user.dart';
import 'package:rentio/local_json_getter/sign_in_json_getter.dart';
import 'package:rentio/models/product.dart';
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
  List<Product> productList;

  Future initJsonData() async {
    List<Product> productList = List<Product>();

    // Cho ng khac thue
    if (widget.option == 'lending') {
      http.Response responseGetOrder = await HttpExecutioner.get(
        requestURL:
            'http://172.20.10.5:8080/api/products/order/${GlobalUser.globalUser.userID}/requests',
        headers: {
          "content-type": "application/json",
          'authorization': 'JWT ${GlobalUser.globalUser.id}'
        },
      );

      if (responseGetOrder.statusCode == 200) {
        var orderListData =
            json.decode(responseGetOrder.body)['requested_orders'];

        for (var order in orderListData) {
          http.Response responseGetProduct = await HttpExecutioner.get(
            requestURL:
                'http://172.20.10.5:8080/api/products/posts/${order['product_id']}',
            headers: {
              "content-type": "application/json",
            },
          );

          if (responseGetProduct.statusCode == 200) {
            var productData = json.decode(responseGetProduct.body);

            productList.add(
              Product(
                name: productData['name'],
//                img_vid_url: productData[
//                    'img_vid_url'], //http://192.168.2.107:5000/hue/1
//                img_vid_url:
//                    'http://coderzheaven.com/youtube_flutter/images.zip',
                address: productData['address'],
                daily_price: productData['daily_price'],
              ),
            );
          }
        }
      } else {
        ReusableAlert(
          context: context,
          title: 'Cannot be loaded',
          desc: 'Product list cannot be loaded',
        ).getAlert();
      }
    }

    // Thue cua ng khac
    if (widget.option == 'renting') {
      http.Response responseGetOrder = await HttpExecutioner.get(
        requestURL:
            'http://172.20.10.5:8080/api/products/order/${GlobalUser.globalUser.userID}/responses',
        headers: {
          "content-type": "application/json",
          'authorization': 'JWT ${GlobalUser.globalUser.id}'
        },
      );
      print(responseGetOrder.statusCode);

      if (responseGetOrder.statusCode == 200) {
        var orderListData = json.decode(responseGetOrder.body)['orders'];

        for (var order in orderListData) {
          http.Response responseGetProduct = await HttpExecutioner.get(
            requestURL:
                'http://172.20.10.5:8080/api/products/posts/${order['product_id']}',
            headers: {
              "content-type": "application/json",
            },
          );

          if (responseGetProduct.statusCode == 200) {
            var productData = json.decode(responseGetProduct.body);

            productList.add(
              Product(
                name: productData['name'],
//                img_vid_url: productData[
//                    'img_vid_url'], //http://192.168.2.107:5000/hue/1
//                img_vid_url:
//                    'http://coderzheaven.com/youtube_flutter/images.zip',
                address: productData['address'],
                daily_price: productData['daily_price'],
              ),
            );
          }
        }
      } else {
        ReusableAlert(
          context: context,
          title: 'Cannot be loaded',
          desc: 'Product list cannot be loaded',
        ).getAlert();
      }
    }

    return productList;
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
        productList = result;
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
              productName: productList[index].name,
              productAddress: productList[index].address,
              price: productList[index].daily_price,
              imageUrl: productList[index].img_vid_url == null
                  ? 'https://www.w3schools.com/w3css/img_lights.jpg'
                  : productList[index].img_vid_url,
//              imageFileName: /*productList[index].getImageFileNameFromZipFile()*/,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(),
                  ),
                );
              },
            ),
            childCount: productList.length,
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
      body: productList == null ? loadLoadingWidget() : loadWidgetWithData(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rentio/components/reusable_item_card.dart';
import 'package:rentio/components/reusable_loading_card.dart';
import 'package:rentio/local_json_getter/sign_in_json_getter.dart';

class ListItemsScreen extends StatefulWidget {
  static String routeName = "/ListItemScreen";

  final String title;
  final String jsonFileName;
  ListItemsScreen({this.title, this.jsonFileName});

  @override
  _ListItemsScreenState createState() => _ListItemsScreenState();
}

class _ListItemsScreenState extends State<ListItemsScreen> {
  var data;

  Future initJsonData() async {
    print(data);
    return await JsonGetter(jsonFileName: widget.jsonFileName).loadData();
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
                productName: /*data['products'][index]['name']*/ '123',
                productAddress: 'abc',
                price: /*data['products'][index]['daily_price']*/ 456,
                imageUrl: 'https://www.w3schools.com/w3css/img_lights.jpg'),
            childCount: /*data['products'].length*/ 3,
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

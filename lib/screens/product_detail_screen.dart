import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

final List child = map<Widget>(
  imgList,
  (index, i) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Image.network(i, fit: BoxFit.cover, width: 1000.0),
      ),
    );
  },
).toList();

class ProductDetailScreen extends StatefulWidget {
  static String routeName = 'productDetailScreen';
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFFF3F3F7),
        leading: IconButton(
          onPressed: () {
            //Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          CarouselSlider(
            items: child,
            aspectRatio: 2.0,
            onPageChanged: (index) {
              setState(() {
                current = index;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(
              imgList,
              (index, url) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: current == index
                          ? Color.fromRGBO(0, 0, 0, 0.9)
                          : Color.fromRGBO(0, 0, 0, 0.4)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Swiper(
//         itemHeight: 200.0,
//         itemWidth: MediaQuery.of(context).size.width - 30.0,
//         itemBuilder: (BuildContext context, int index) {
//           return new Image.asset(
//             "images/default_app_avatar.jpg",
//             fit: BoxFit.cover,
//           );
//         },
//         itemCount: 3,
//         pagination: new SwiperPagination(),
//       ),

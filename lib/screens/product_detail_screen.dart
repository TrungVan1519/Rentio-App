import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rentio/components/reusable_gradient_button_card.dart';
import 'package:rentio/utilities/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
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
  void initState() {
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
      body: ListView(
        children: <Widget>[
          CarouselSlider(
            enableInfiniteScroll: false,
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
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(
                                    "https://friendlystock.com/wp-content/uploads/2018/03/4-surprised-pineapple-cartoon-clipart.jpg"),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Nguyen Thanh Tung',
                                style: TextStyle(
                                  fontSize: kFontTextSmallSize,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                    size: 15.0,
                                  ),
                                  Text(
                                    'Thanh Xuan - Ha Noi',
                                    style: TextStyle(
                                      fontSize: kFontLabelSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Tên sản phẩm',
                            style: TextStyle(
                              fontSize: kFontProductTitleSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          RatingBar(
                            allowHalfRating: true,
                            initialRating: 4.5,
                            itemCount: 5,
                            direction: Axis.horizontal,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            itemSize: 20.0,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.orangeAccent,
                            ),
                            onRatingUpdate: null,
                          ),
                        ],
                      ),
                      priceAndDateCard(150000, 'ngày'),
                      priceAndDateCard(150000, 'tuần'),
                      priceAndDateCard(150000, 'tháng'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                RaisedGradientButton(
                  borderRadius: BorderRadius.circular(30.0),
                  width: 125.0,
                  height: 40.0,
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(kGradientColorElement1),
                      Color(kGradientColorElement2),
                    ],
                  ),
                  onPressed: () {
                    onRentButtonPressed(context);
                  },
                  child: Text(
                    'Rent',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: kFontTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onRentButtonPressed(BuildContext context) {
    //valid date: 1999/04/08
    String startDate = '';
    String endDate = '';

    Alert(
      style: AlertStyle(
        titleStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 18.0,
        ),
        //backgroundColor: Colors.green,
        isCloseButton: false,
      ),
      context: context,
      title: "Please select your rental start and end time.",
      content: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Start time: '),
              Text(startDate),
              RaisedButton(
                onPressed: () {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('End time: '),
              Text(endDate),
              RaisedButton(
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "Start Renting!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          onPressed: () {},
          width: 100,
        ),
        DialogButton(
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          onPressed: () => Navigator.pop(context),
          width: 100,
        ),
      ],
    ).show();
  }

  Widget priceAndDateCard(double price, String dateType) {
    int priceInInt = price.toInt();
    return Row(
      children: <Widget>[
        Text(
          '$priceInInt đ/1 $dateType', //Sua cach chuyen bien double -> string
          style: TextStyle(
            fontSize: kFontProductPriceSize,
            fontWeight: FontWeight.bold,
            color: Color(kGradientColorElement1),
          ),
        ),
      ],
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

// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: <Widget>[
//     Column(
//       children: <Widget>[
//         Text(
//           '15.000đ',
//           style: TextStyle(
//             fontSize: kFontProductPriceSize,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           '1 ngày',
//           style: TextStyle(
//             fontSize: kFontLabelSize,
//           ),
//         ),
//       ],
//     ),
//     Column(
//       children: <Widget>[
//         Text(
//           '30.000đ',
//           style: TextStyle(
//             fontSize: kFontProductPriceSize,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           '1 tuần',
//           style: TextStyle(
//             fontSize: kFontLabelSize,
//           ),
//         ),
//       ],
//     ),
//     Column(
//       children: <Widget>[
//         Text(
//           '150.000đ',
//           style: TextStyle(
//             fontSize: kFontProductPriceSize,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           '1 tháng',
//           style: TextStyle(
//             fontSize: kFontLabelSize,
//           ),
//         ),
//       ],
//     ),
//   ],
// ),

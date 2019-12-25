import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rentio/components/reusable_gradient_button_card.dart';
import 'package:rentio/components/reusable_alert.dart';
import 'package:rentio/global_data/global_user.dart';
import 'package:rentio/utilities/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:http/http.dart' as http;
import 'package:rentio/services/http_executioner.dart';
import 'dart:convert';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
];

// map function is used for map a list of function (function is based on your call)
List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

//use the map function to map list of items with function on your call, after the loop it will convert to a list (.toList())
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
  var jsonData;

  ProductDetailScreen({this.jsonData});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int currentImage = 0;
  DateTime dateTime;
  //valid date example: 1999/04/08
  String startDate = 'Pick your date';
  int startDay;
  int startMonth;
  int startYear;
  String endDate = 'Pick your date';
  int endDay;
  int endMonth;
  int endYear;
  int totalPrice = 0;
  int dateDiff;
  DateTime startDateInDateTime;
  DateTime endDateInDateTime;

  @override
  void initState() {
    dateTime = DateTime.now();
    print(widget.jsonData);
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
            // Su dung items: child roi thi tu dong slide duoc anh
            items: child,
            aspectRatio: 2.0,
            onPageChanged: (index) {
              // Dung de thay doi may cai dau '.' o duoi image
              setState(() {
                currentImage = index;
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
                      color: currentImage == index
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
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                //TODO: Sửa lại image của user
                                image:
                                    AssetImage('images/default_app_avatar.jpg'),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                //'Nguyen Thanh Tung',
                                widget.jsonData['products']['name'],
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
                                    //TODO: Tạm fix cứng
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
                      // priceAndDateCard(150000, 'ngày'),
                      // priceAndDateCard(150000, 'tuần'),
                      // priceAndDateCard(150000, 'tháng'),
                      priceAndDateCard(
                          widget.jsonData['products']['daily_price'], 'ngày'),
                      priceAndDateCard(
                          widget.jsonData['products']['weekly_price'], 'tuần'),
                      priceAndDateCard(
                          widget.jsonData['products']['monthly_price'],
                          'tháng'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Start time: ',
                            style: TextStyle(
                              fontSize: kFontProductPriceSize,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showCalendar('start');
                            },
                            child: Text(
                              startDate,
                              style: TextStyle(
                                fontSize: kFontProductPriceSize,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'End time  : ',
                            style: TextStyle(
                              fontSize: kFontProductPriceSize,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showCalendar('end');
                            },
                            child: Text(
                              endDate,
                              style: TextStyle(
                                fontSize: kFontProductPriceSize,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Total price: $totalPrice đ',
                            style: TextStyle(
                              fontSize: kFontProductPriceSize,
                            ),
                          ),
                        ],
                      ),
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

  void calculatePrice() {
    int month = (dateDiff / 30).toInt();
    int week = ((dateDiff % 30) / 7).toInt();
    int day = ((dateDiff % 30) % 7).toInt();
    setState(() {
      totalPrice = month * widget.jsonData['products']['monthly_price'] +
          week * widget.jsonData['products']['weekly_price'] +
          day * widget.jsonData['products']['daily_price'];
    });
  }

  void showCalendar(String dateFrom) async {
    DateTime newDateTime = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 2),
      borderRadius: 2,
    );
    if (newDateTime != null) {
      setState(
        () {
          if (dateFrom == 'start') {
            startDateInDateTime = newDateTime;
            dateTime = newDateTime;
            startDay = newDateTime.day;
            startMonth = newDateTime.month;
            startYear = newDateTime.year;
            startDate = startDay.toString() +
                '/' +
                startMonth.toString() +
                '/' +
                startYear.toString();
          } else {
            endDateInDateTime = newDateTime;
            dateTime = newDateTime;
            endDay = newDateTime.day;
            endMonth = newDateTime.month;
            endYear = newDateTime.year;
            endDate = endDay.toString() +
                '/' +
                endMonth.toString() +
                '/' +
                endYear.toString();
            dateDiff =
                endDateInDateTime.difference(startDateInDateTime).inDays + 2;
            print(dateDiff);
            calculatePrice();
          }
        },
      );
    }
  }

  void onRentButtonPressed(BuildContext context) {
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
      title: "Do you want to start renting now?",
      buttons: [
        DialogButton(
          child: Text(
            "Start Renting!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          onPressed: () async {
            http.Response responsePost = await HttpExecutioner.post(
              requestURL:
                  "http://192.168.2.107:8080/api/products/${GlobalUser.globalUser.id}/order/request",
              headers: {
                "content-type": "application/json",
                "authorization": "JWT ${GlobalUser.globalUser.id}",
              },
              body: {
                "product_id": widget.jsonData['products']['id'],
                "start_date": startYear.toString() +
                    '/' +
                    startMonth.toString() +
                    '/' +
                    startDay.toString(),
                "end_date": endYear.toString() +
                    '/' +
                    endMonth.toString() +
                    '/' +
                    endDay.toString(),
                "lender_national_id":
                    widget.jsonData['products']['national_id'] ?? "",
                "bank_number": widget.jsonData['products']['bank_number'] ?? "",
                "lender_id": widget.jsonData['products']['user_id'],
                "renter_id": GlobalUser.globalUser.id,
              },
              //TODO: Hỏi trung về vụ Global ID là string thay vì int
            );
          },
          width: 80,
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
          width: 80,
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

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:rentio/components/reusable_alert.dart';
import 'package:rentio/components/reusable_gradient_button_card.dart';
import 'package:rentio/components/reusable_loading_card.dart';
import 'package:rentio/local_json_getter/sign_in_json_getter.dart';
import 'package:rentio/screens/lending_screen.dart';
import 'package:rentio/screens/list_items_screen.dart';
import 'package:rentio/screens/updating_account_info_screen.dart';
import 'package:rentio/screens/updating_user_info_screen.dart';
import 'package:rentio/services/noti_listener.dart';
import 'package:rentio/utilities/constants.dart';

class UserScreen extends StatefulWidget {
  final String fullName;
  UserScreen({this.fullName});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  GlobalKey _firstRowKey = GlobalKey();
  GlobalKey _secondRowKey = GlobalKey();
  GlobalKey _sizedBoxKey = GlobalKey();

  double _screenHeight = 0;
  double _firstRowHeight = 0;
  double _secondRowHeight = 0;
  double _sizedBoxHeight = 0;
  double _neededHeight = 0;

  bool isLoading = false;

  double _getSize() {
    _screenHeight = MediaQuery.of(context).size.height;

    RenderBox _firstRow = _firstRowKey.currentContext.findRenderObject();
    _firstRowHeight = _firstRow.size.height;

    RenderBox _secondRow = _secondRowKey.currentContext.findRenderObject();
    _secondRowHeight = _secondRow.size.height;

    _sizedBoxHeight =
        (_sizedBoxKey.currentContext.findRenderObject() as RenderBox)
            .size
            .height;

    return (_screenHeight -
        _firstRowHeight -
        _secondRowHeight -
        _sizedBoxHeight);
  }

  @override
  void initState() {
    super.initState();
    NotiListener.startListening();
    // (?? :)) ??) Chu y phai truyen tham so '_' vao ham '(_)'
    // Co tac dung chay ngay sau khi build xong cay UI (hay noi cach khac chay ngay
    //    sau khi ham override build chay xong)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _neededHeight = _getSize() - 20;
        // > 20 la do Padding Widget dau tien (cai Padding Widget chua Row co
        //    'key: _firstRowKey') gay ra
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: isLoading ? 0 : 1,
        children: <Widget>[
          Container(
            child: Center(
              child: CubeGridLoading(),
            ),
          ),
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Row(
                      key: _firstRowKey,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.teal,
                          ),
                          onPressed: onBackwardPressed,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    key: _secondRowKey,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // > Tang khoang cach cho cac Widgets con trong 1 Row
                    children: <Widget>[
                      Container(
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                          ),
                        ),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0),
                            ),
                            side: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                          color: Colors.white,
                          onPressed: onLendNowPressed,
                          child: Text(
                            'Lend now',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: kFontLabelSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        child: GestureDetector(
                          onTap: onChangingInfoPressed,
                          child: Icon(Icons.build),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(
                            key: _sizedBoxKey,
                            height: 70,
                          ),
                          Container(
                            height: _neededHeight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(kGradientColorElement1),
                                  Color(kGradientColorElement2)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        // > Khong su dung duoc 'contraints: BoxContraints.expand(),' vi
                        //    'BoxConstraints forces an infinite height' tuc la ta chi co
                        //    the su dung thuoc tinh 'contraints: BoxContraints.expand(),'
                        //    cho Container Widget la con truc tiep cua Scaffold Widget
                        // > Hon nua ta chi can de Container Widget nay full width man
                        //    hinh de tao dieu kien cho 'mainAxisAlignment: MainAxisAlignment.center,'
                        //    cua Column Widget o duoi hoat dong nen ta su dung cach nay:
                        //    'width: MediaQuery.of(context).size.width,'
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 150.0,
                              height: 150.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage(
                                      'images/default_app_avatar.jpg'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Text(
                                widget.fullName,
                                style: TextStyle(
                                  fontSize: kFontTextSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            RaisedButton(
                              color: Color(kGradientColorElement1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              onPressed: onLendingItemsPressed,
                              child: Text('Danh sach ta cho ng khac thue'),
                            ),
                            RaisedButton(
                              color: Color(kGradientColorElement1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              onPressed: onRentingItemsPressed,
                              child: Text('Danh sach ta thue cua ng khac'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: RaisedGradientButton(
                                height: 50.0,
                                width: 150.0,
                                borderRadius: BorderRadius.circular(30.0),
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(kGradientColorElement1),
                                    Color(kGradientColorElement2),
                                  ],
                                ),
                                onPressed: onSignOutPressed,
                                child: Text(
                                  'Sign out',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: kFontTextSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  void onBackwardPressed() {
    Navigator.pop(context, false);
  }

  void onLendNowPressed() async {
    setState(() {
      isLoading = true;
    });

    final data =
        await JsonGetter(jsonFileName: 'data/response_product_in_stock.json')
            .loadData();

    if (data != null) {
      isLoading = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LendingScreen(data: data)),
      );
    } else {
      ReusableAlert(
        context: context,
        title: 'Internet problems',
        desc: 'Your internet has problem',
      ).getAlert();
    }

    setState(() {
      isLoading = false;
    });
  }

  void onLendingItemsPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListItemsScreen(
          title: 'Danh sach ta cho ng khac thue',
          jsonFileName: 'data/response_product_in_stock.json',
        ),
      ),
    );
  }

  void onRentingItemsPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListItemsScreen(
          title: 'Danh sach ta thue cua ng khac',
          jsonFileName: 'data/response_product_in_stock.json',
        ),
      ),
    );
  }

  void onChangingInfoPressed() {
    List<DialogButtonInfoModel> list = [
      DialogButtonInfoModel(
          contentOption: 'My info',
          color: Color(kGradientColorElement1),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UpdatingUserInfoScreen()),
            );
          }),
      DialogButtonInfoModel(
          contentOption: 'Account info',
          color: Color(kGradientColorElement2),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UpdatingAccountInfoScreen()),
            );
          }),
      DialogButtonInfoModel(
          contentOption: 'Cancel',
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          }),
    ];

    ReusableAlert(
      context: context,
      title: 'What do you want to update?',
      list: list,
    ).getUserOption();
  }

  void onSignOutPressed() {
    Navigator.pop(context, false);
  }
}

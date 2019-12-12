import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentio/components/reusable_item_card.dart';
import 'package:rentio/utilities/constants.dart';

class LendingScreen extends StatefulWidget {
  final data;
  LendingScreen({this.data});

  @override
  _LendingScreenState createState() => _LendingScreenState();
}

class _LendingScreenState extends State<LendingScreen> {
  GlobalKey _rowKey = GlobalKey();
  GlobalKey _firstContainerKey = GlobalKey();
  GlobalKey _secondContainerKey = GlobalKey();

  double _screenHeight = 0;
  double _rowHeight = 0;
  double _firstContainerHeight = 0;
  double _secondContainerHeight = 0;
  double _neededHeight = 0;

  var data;

  double _getSize() {
    _rowHeight =
        (_rowKey.currentContext.findRenderObject() as RenderBox).size.height;
    print('rowHeight $_rowHeight');

    _screenHeight = MediaQuery.of(context).size.height;

    RenderBox _firstContainer =
        _firstContainerKey.currentContext.findRenderObject();
    _firstContainerHeight = _firstContainer.size.height;

    RenderBox _secondContainer =
        _secondContainerKey.currentContext.findRenderObject();
    _secondContainerHeight = _secondContainer.size.height;

    print(
        'Hieu ${_screenHeight - _firstContainerHeight - _secondContainerHeight}');

    return (_screenHeight - _firstContainerHeight - _secondContainerHeight);
  }

  @override
  void initState() {
    super.initState();
    data = widget.data;

    // Co tac dung chay ngay sau khi build xong cay UI (hay noi cach khac chay ngay
    //    sau khi ham override build chay xong)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
//        _rowHeight = (_rowKey.currentContext.findRenderObject() as RenderBox)
//            .size
//            .height;

        _neededHeight = _getSize();
        print('neededHeight $_neededHeight');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                key: _firstContainerKey,
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
                              image:
                                  AssetImage('images/default_app_avatar.jpg'),
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
                              color: Colors.white,
                            ),
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
                key: _secondContainerKey,
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height * 0.3 -
                    _rowHeight,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      'List of items that being lent',
                      style: TextStyle(
                        fontSize: kFontTextSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade900,
                      ),
                    ),
                    CustomScrollView(
                      shrinkWrap: true,
                      slivers: <Widget>[
                        SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => ReusableItemCard(
                                isProduct: true,
                                productName: data['products'][index]['name'],
                                price: data['products'][index]['daily_price'],
                                imageUrl:
                                    'https://www.w3schools.com/w3css/img_lights.jpg'),
                            childCount: data['products'].length,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Colors.greenAccent,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        // > Phai su dung thuoc tinh 'mainAxisSize: MainAxisSize.min,'
                        //    va set value = min thi moi su dung duoc Flexible
                        //    boi neu khong mac dinh thuoc tinh nay = max tuc la Row se
                        //    keo dai hang ngang den vo cung ma Flexible thi chi bao boc
                        //    dung du cac child cua no
                        children: <Widget>[
                          Text(
                            'Add',
                            style: TextStyle(
                              fontSize: kFontTextSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          Icon(
                            FontAwesomeIcons.plus,
                            size: 30.0,
                            color: Colors.green,
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.redAccent,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Remove',
                            style: TextStyle(
                              fontSize: kFontTextSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          Icon(
                            FontAwesomeIcons.minus,
                            size: 30.0,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Row(
              key: _rowKey,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: onBackwardPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onBackwardPressed() {
    Navigator.pop(context, false);
  }
}

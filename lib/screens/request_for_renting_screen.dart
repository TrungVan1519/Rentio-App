import 'package:flutter/material.dart';

class RequestForRentingScreen extends StatefulWidget {
  @override
  _RequestForRentingScreenState createState() =>
      _RequestForRentingScreenState();
}

class _RequestForRentingScreenState extends State<RequestForRentingScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          elevation: 3.0,
          margin: EdgeInsets.all(5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: <Widget>[
              Text('Order ID: 123456789'),
              Text('Order date: 25/12/2019'),
              Text('Status: Product is wanted by Alex'),
            ],
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Card(
          elevation: 3.0,
          margin: EdgeInsets.all(5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: <Widget>[
              Text('Renter\'s infomation'),
              Text('Alex Anderson'),
              Text('0913698421'),
              Text('Thanh Xuan - Ha Noi'),
            ],
          ),
        ),
        SizedBox(
          height: 25.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              onPressed: () {},
              child: Text('Decline'),
            ),
            RaisedButton(
              onPressed: () {},
              child: Text(
                'Accept!',
                style: TextStyle(
                    color: Color(0xFF43C6AC), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Image(
                    image: NetworkImage(
                        'https://images-na.ssl-images-amazon.com/images/I/81D%2BXXEnHBL._SY550_.jpg'),
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  'Bla bla, this is a really long text!!!Bla bla, this is a really long text!!!Bla bla, this is a really long text!!!Bla bla, this is a really long text!!!',
                ),
              ),
            ],
          ),
          Divider(
            height: 1.0,
            color: Colors.black26,
          ),
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Image(
                    image: NetworkImage(
                        'https://images-na.ssl-images-amazon.com/images/I/81D%2BXXEnHBL._SY550_.jpg'),
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  'Bla bla, this is a really long text!!!Bla bla, this is a really long text!!!Bla bla, this is a really long text!!!Bla bla, this is a really long text!!!',
                ),
              ),
            ],
          ),
          Divider(
            height: 1.0,
            color: Colors.black26,
          ),
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Image(
                    image: NetworkImage(
                        'https://images-na.ssl-images-amazon.com/images/I/81D%2BXXEnHBL._SY550_.jpg'),
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  'Bla bla, this is a really long text!!!Bla bla, this is a really long text!!!Bla bla, this is a really long text!!!Bla bla, this is a really long text!!!',
                ),
              ),
            ],
          ),
          Divider(
            height: 1.0,
            color: Colors.black26,
          ),
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Image(
                    image: NetworkImage(
                        'https://images-na.ssl-images-amazon.com/images/I/81D%2BXXEnHBL._SY550_.jpg'),
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  'Bla bla, this is a really long text!!!Bla bla, this is a really long text!!!Bla bla, this is a really long text!!!Bla bla, this is a really long text!!!',
                ),
              ),
            ],
          ),
          Divider(
            height: 1.0,
            color: Colors.black26,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyTestWidget extends StatefulWidget {
  @override
  _MyTestWidgetState createState() => _MyTestWidgetState();
}

class _MyTestWidgetState extends State<MyTestWidget> {
  List<String> myList = ['1', '2', 'three', '4'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton(
          child: Text('Push me!'),
          onPressed: () {
            setState(() {
              myList.add('newText');
            });
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: myList.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(myList[index]);
            },
          ),
        ),
      ],
    );
  }
}

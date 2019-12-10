import 'package:flutter/material.dart';

class ReusablePersonCard extends StatelessWidget {
  final String personName;
  final double personRating;
  final String imageUrl;

  ReusablePersonCard({this.personName, this.personRating, this.imageUrl});

  Widget getImage() {
    //Check whether network image or asset image
    if (imageUrl.contains('http')) {
      return Flexible(
        child: Image.network(imageUrl.toString()),
      );
    }
    return Flexible(
      child: Image.asset(imageUrl.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Card(
        elevation: 5.0,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: Color(0xFFC0C0C0),
            ),
          ),
          child: Column(
            children: <Widget>[
              getImage(),
              Text(personName.toString()),
              Text(personRating.toString() + '/5.0'),
            ],
          ),
        ),
      ),
    );
  }
}

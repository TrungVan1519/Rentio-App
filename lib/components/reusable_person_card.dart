import 'package:flutter/material.dart';
import 'package:rentio/services/stringManipulator.dart';

class ReusablePersonCard extends StatelessWidget {
  final String personName;
  final int personRating;
  final String imageUrl;
  final Function onPressed;

  ReusablePersonCard(
      {this.personName, this.personRating, this.imageUrl, this.onPressed});

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
      onTap: onPressed,
      title: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: <Widget>[
            getImage(),
            Text(StringManipulator.changeFirstLetterUpperCase(
                personName.toString())),
            //Tam thoi nhan gia tri rating la int roi convert ra double
            Text(personRating.toDouble().toString() + '/5.0'),
          ],
        ),
      ),
    );
  }
}

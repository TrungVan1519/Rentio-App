import 'package:flutter/material.dart';

class ReusableItemCard extends StatelessWidget {
  ReusableItemCard(
      {this.productName, this.productAddress, this.price, this.imageUrl});

  final String productName;
  final String productAddress;
  final int price;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Color(0xFF222222),
        ),
      ),
      height: 135.0,
      width: 135.0,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Image.network(imageUrl),
          ),
          Text(productName),
          Text(productAddress),
          Text(price.toString()),
        ],
      ),
    );
  }
}

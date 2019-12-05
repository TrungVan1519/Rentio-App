import 'package:flutter/material.dart';

class ReusableItemCard extends StatelessWidget {
  ReusableItemCard(
      {this.productName, this.productAddress, this.price, this.imageUrl});

  final String productName;
  final String productAddress;
  final double price;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
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
              Flexible(
                child: Image.network(imageUrl),
              ),
              Text(productName),
              Text(productAddress),
              Text(price.toString()),
            ],
          ),
        ),
      ),
    );
  }
}

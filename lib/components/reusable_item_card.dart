import 'package:flutter/material.dart';

class ReusableItemCard extends StatelessWidget {
  ReusableItemCard(
      {this.productName,
      this.productAddress,
      this.price,
      this.imageUrl,
      this.onPressed});

  final String productName;
  final String productAddress;
  final double price;
  final String imageUrl;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
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
              Text(productName.toString()),
              Text(productAddress.toString()),
              Text(price.toString()),
            ],
          ),
        ),
      ),
    );
  }
}

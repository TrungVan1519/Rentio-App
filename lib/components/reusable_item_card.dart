import 'package:flutter/material.dart';

//Stateless Widget to layout item card such as product card and catalog card
class ReusableItemCard extends StatelessWidget {
  ReusableItemCard(
      {@required this.isProduct,
      this.catalogName,
      this.productName,
      this.productAddress,
      this.price,
      this.imageUrl,
      this.onPressed});

  final String productName;
  final String productAddress;
  final double price;
  final String imageUrl;
  final Function onPressed;
  final bool isProduct;
  final String catalogName;

  @override
  Widget build(BuildContext context) {
    return isProduct ? getProductCard() : getCatalogCard();
  }

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

  Widget getProductCard() {
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
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              getImage(),
              Text(productName.toString()),
              Text(productAddress.toString()),
              Text(price.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCatalogCard() {
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
              getImage(),
              Text(catalogName.toString()),
            ],
          ),
        ),
      ),
    );
  }
}

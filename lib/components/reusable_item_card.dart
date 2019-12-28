import 'package:flutter/material.dart';
import 'package:rentio/services/stringManipulator.dart';

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
//        child: FittedBox(
        child: Image.network(
          imageUrl.toString(),
          //fit: BoxFit.cover,
        ),
//        ),
      );
    }
    return Flexible(
      child: Image.asset(imageUrl.toString()),
    );
  }

  Widget getAddress() {
    if (productAddress.toString() != null) {
      return Text(productAddress.toString());
    }
    return null;
  }

  Widget getName() {
    if (productName.toString() != null) {
      return Text(
          StringManipulator.changeFirstLetterUpperCase(productName.toString()));
    }
    return null;
  }

  Widget getPrice() {
    if (price.toString() != null) {
      return Text(price.toString());
    }
    return null;
  }

  Widget getProductCard() {
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
            getName(),
            getAddress(),
            getPrice(),
          ],
        ),
      ),
    );
  }

  Widget getCatalogCard() {
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
            Text(catalogName.toString()),
          ],
        ),
      ),
    );
  }
}

import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rentio/models/product.dart';
import 'package:rentio/services/zip_extractor.dart';
import 'package:rentio/services/stringManipulator.dart';

//Stateless Widget to layout item card such as product card and catalog card

//class ReusableItemCard extends StatefulWidget {
//  final String productName;
//  final String productAddress;
//  final double price;
//  final String imageUrl;
//  final Function onPressed;
//  final bool isProduct;
//  final String catalogName;
//  final Product product;
//
//  ReusableItemCard(
//      {@required this.isProduct,
//      this.catalogName,
//      this.productName,
//      this.productAddress,
//      this.price,
//      this.imageUrl,
//      this.product,
//      this.onPressed});
//
//  @override
//  _ReusableItemCardState createState() => _ReusableItemCardState();
//}
//
//class _ReusableItemCardState extends State<ReusableItemCard> {
//  bool downloading = false;
//
//  @override
//  void initState() {
//    super.initState();
//
//    setState(() {
//      downloading = true;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    if (downloading == true) {
//      return progress();
//    } else {
//      return widget.isProduct ? getProductCard() : getCatalogCard();
//    }
//  }
//
//  Widget progress() {
//    return Center(
//      child: GestureDetector(
//        child: CircularProgressIndicator(),
//        onTap: () {
//          setState(() {
//            downloading = false;
//          });
//        },
//      ),
//    );
//  }
//
//  Widget getProductCard() {
//    return ListTile(
//      onTap: widget.onPressed,
//      title: Card(
//        elevation: 5.0,
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
//        ),
//        child: Column(
//          children: <Widget>[
//            getImage(),
//            getName(),
//            getAddress(),
//            getPrice(),
//          ],
//        ),
//      ),
//    );
//  }
//
//  Widget getCatalogCard() {
//    return ListTile(
//      onTap: widget.onPressed,
//      title: Card(
//        elevation: 5.0,
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
//        ),
//        child: Column(
//          children: <Widget>[
//            getImage(),
//            Text(widget.catalogName.toString()),
//          ],
//        ),
//      ),
//    );
//  }
//
//  Widget getImage() {
////    Phan nay la dung de lay anh tu network ma trong TH nay thi lay anh tu File zip
////        do ZipExtractor lay ra
////    // Su dung anh thong qua internet khi ten anh tu file zip bi loi
////    if (imageUrl.contains('http')) {
////      return Flexible(
//////        child: FittedBox(
////        child: Image.network(
////          imageUrl.toString(),
////          //fit: BoxFit.cover,
////        ),
//////        ),
////      );
////    }
////    // Su dung anh tu file zip giai nen ve
////    return Flexible(
//////      child: Image.asset(imageUrl.toString()),
////      child: Image.file(File(imageFileName)),
////    );
//    return FutureBuilder(
//      builder: (context, snapShot) {
//        if (snapShot.hasData) return Image.file(File(snapShot.data));
//        return CircularProgressIndicator();
//      },
//      future: widget.product.getImageFileNameFromZipFile(),
//    );
//
////    if (imageFileName == null) {
////      return Flexible(
////        child: Image.network('https://www.w3schools.com/w3css/img_lights.jpg'),
////      );
////    }
////
////    return Flexible(
////      child: Image.file(
////        File('$dir/$imageFileName'),
////      ),
////    );
//  }
//
//  Widget getAddress() {
//    if (widget.productAddress.toString() != null) {
//      return Text(widget.productAddress.toString());
//    }
//    return null;
//  }
//
//  Widget getName() {
//    if (widget.productName.toString() != null) {
//      return Text(widget.productName.toString());
//    }
//    return null;
//  }
//
//  Widget getPrice() {
//    if (widget.price.toString() != null) {
//      return Text(widget.price.toString());
//    }
//    return null;
//  }
//}

class ReusableItemCard extends StatelessWidget {
  bool downloading = false;

  final String productName;
  final String productAddress;
  final double price;
  final String imageUrl;
  final Function onPressed;
  final bool isProduct;
  final String catalogName;

  ReusableItemCard(
      {@required this.isProduct,
      this.catalogName,
      this.productName,
      this.productAddress,
      this.price,
      this.imageUrl, // cai nay khong dung nua, nhung chua cmt vi may screen khac dang dung
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return isProduct ? getProductCard() : getCatalogCard();
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

  Widget getImage() {
//    Phan nay la dung de lay anh tu network ma trong TH nay thi lay anh tu File zip
//        do ZipExtractor lay ra
//    // Su dung anh thong qua internet khi ten anh tu file zip bi loi
    return Image.asset('images/sign_in.jpg');

//    if (imageUrl.contains('http')) {
//      return Flexible(
////        child: FittedBox(
//        child: Image.network(
//          imageUrl.toString(),
//          //fit: BoxFit.cover,
//        ),
////        ),
//      );
//    }
//    // Su dung anh tu file zip giai nen ve
//    return Flexible(
//      child: Image.asset(imageUrl.toString()),
//    );

//    ZipExtractor zipExtractor = ZipExtractor(zipPath: imageUrl);
//    zipExtractor.downloadZip();
//    String imageFileName;
////    String imageFileName = zipExtractor.images[0];
//    print('imageFileName:: ${zipExtractor.images.length}');

//    if (imageFileName == null) {
//      return Flexible(
//        child: Image.network('https://www.w3schools.com/w3css/img_lights.jpg'),
//      );
//    }
//
//    return Flexible(
//      child: Image.file(
//        File(imageFileName),
//      ),
//    );
  }

  Widget getAddress() {
    if (productAddress.toString() != null) {
      return Text(productAddress.toString());
    }
    return null;
  }

  Widget getName() {
    if (productName.toString() != null) {
      return Text(productName.toString());
    }
    return null;
  }

  Widget getPrice() {
    if (price.toString() != null) {
      return Text(price.toString());
    }
    return null;
  }
}

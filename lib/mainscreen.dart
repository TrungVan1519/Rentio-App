import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rentio/services/zip_extractor.dart';

class ReusableItemCard extends StatefulWidget {
  @override
  _ReusableItemCardState createState() => _ReusableItemCardState();
}

class _ReusableItemCardState extends State<ReusableItemCard> {
  final ZipExtractor zipExtractor = ZipExtractor(
      zipPath: 'http://coderzheaven.com/youtube_flutter/images.zip');
  var downloading = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      downloading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test zip extracted'),
        actions: <Widget>[
          downloading ? progress() : Container(),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              zipExtractor.downloadZip().then((onValue) {
                setState(() {
                  downloading = true;
                });
              });
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            getProductCard(),
          ],
        ),
      ),
    );
  }

  Widget progress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget getProductCard() {
    return Container(
      child: getImage(),
    );
  }

  Widget getImage() {
//    String imageFileName;
////    zipExtractor.downloadZip().then((value) {
////      setState(() {
////        downloading = true;
////        imageFileName = zipExtractor.images[0];
////        print('zipExtractor.images[0]:: ${zipExtractor.images[0]}');
////      });
////    });
////
////    zipExtractor.downloadZip().then((onValue) {
////      setState(() {
////        downloading = true;
////      });
////    });
//
//    if (imageFileName == null) {
//      return Flexible(
//        child: Image.network('https://www.w3schools.com/w3css/img_lights.jpg'),
//      );
//    }

//    return Flexible(
//      child: Image.file(
//        File(zipExtractor.images[0]),
//      ),
//    );
    return Expanded(
      child: ListView.builder(
        itemCount: zipExtractor.images.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.file(
            File(zipExtractor.images[index]),
            fit: BoxFit.fitWidth,
          );
        },
      ),
    );
  }
}

//class _MainState extends State<Main> {

//  buildList() {
//    return Expanded(
//      child: ListView.builder(
//        itemCount: zipExtractor.images.length,
//        itemBuilder: (BuildContext context, int index) {
//          return Image.file(
//            File(zipExtractor.images[index]),
//            fit: BoxFit.fitWidth,
//          );
//        },
//      ),
//    );
//  }
//
//

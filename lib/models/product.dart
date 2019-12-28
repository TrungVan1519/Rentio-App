import 'package:flutter/cupertino.dart';
import 'package:rentio/services/zip_extractor.dart';

class Product {
  int id;
  int userId;
  String name;
  String img_vid_url;
  bool status;
  String address;
  double daily_price;
  double weekly_price;
  double monthly_price;

  Product(
      {this.id,
      this.userId,
      @required this.name,
      this.img_vid_url,
      this.status,
      @required this.address,
      @required this.daily_price,
      this.weekly_price,
      this.monthly_price});

  // TODO: Khong can su dung them prop imageFileName vi ham nay tra ve luon
  Future<String> getImageFileNameFromZipFile() async {
    ZipExtractor zipExtractor = ZipExtractor(zipPath: img_vid_url);
    await zipExtractor.downloadZip();

    return zipExtractor.images[0].toString();
  }

//  void getImageFileNameFromZipFile() async {
//    ZipExtractor zipExtractor = ZipExtractor(zipPath: img_vid_url);
//    await zipExtractor.downloadZip();
//    print('images[0]: ${zipExtractor.images[0]}');
//    this.abc = zipExtractor.images[0];
//  }
//
//  Future<String> getABC() async {
//    ZipExtractor zipExtractor = ZipExtractor(zipPath: img_vid_url);
//    await zipExtractor.downloadZip();
//    print('image.length:: ${zipExtractor.images.length}');
//    print('images[0]: ${zipExtractor.images[0]}');
//    return zipExtractor.images[0];
//  }
}

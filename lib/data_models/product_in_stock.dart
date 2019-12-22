class ProductInStock {
  int id;
  String name;
  bool status;
  double daily_price;
  double weekly_price;
  double monthy_price;
  List<Product_Image_Video> list_img_vid;
  int user_id;

  ProductInStock(
      {this.id,
      this.name,
      this.status,
      this.daily_price,
      this.weekly_price,
      this.monthy_price,
      this.list_img_vid,
      this.user_id});
}

class Product_Image_Video {
  String img_vid_url;
}

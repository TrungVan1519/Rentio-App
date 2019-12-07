class ProductInStock {
  int id;
  String name;
  bool status;
  double daily_price, weekly_price, monthy_price;
  String img_vid;
  int user_id;

  ProductInStock(
      {this.id,
      this.name,
      this.status,
      this.daily_price,
      this.weekly_price,
      this.monthy_price,
      this.img_vid,
      this.user_id});
}

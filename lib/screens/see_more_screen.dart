import 'package:flutter/material.dart';
import 'package:rentio/components/reusable_item_card.dart';
import 'package:rentio/components/reusable_person_card.dart';

class SeeMoreScreen extends StatefulWidget {
  //type: products or lenders
  final String type;
  final jsonData;

  SeeMoreScreen({@required this.type, this.jsonData});

  @override
  _SeeMoreScreenState createState() => _SeeMoreScreenState();
}

class _SeeMoreScreenState extends State<SeeMoreScreen> {
  Widget popularProductWidget() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFFF3F3F7),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ReusableItemCard(
                    onPressed: () {},
                    isProduct: true,
                    productName: widget.jsonData['product_products'][index]
                        ['name'],
                    price: widget.jsonData['product_products'][index]
                        ['daily_price'],
                    imageUrl: 'https://www.w3schools.com/w3css/img_lights.jpg'),
              ),
              childCount: widget.jsonData['product_products'].length,
            ),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          ),
        ],
      ),
    );
  }

  Widget topLenderWidget() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFFF3F3F7),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ReusablePersonCard(
                    personName: widget.jsonData['top_lender'][index]
                            ['first_name'] +
                        ' ' +
                        widget.jsonData['top_lender'][index]['last_name'],
                    personRating: widget.jsonData['top_lender'][index]
                        ['average_star'],
                    imageUrl:
                        'https://external-preview.redd.it/Rmryan2W90zOKh0uuFeLXlJZ5CPCA-hOmnvv2NFPCCQ.jpg?auto=webp&s=e74d779c246115721c0fe14ed9a36b611a8ad11f',
                  ),
                );
              },
              childCount: widget.jsonData['top_lender'].length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.type == 'product'
        ? popularProductWidget()
        : topLenderWidget();
  }
}

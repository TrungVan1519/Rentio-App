import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rentio/components/reusable_item_card.dart';
import 'package:rentio/local_json_getter/sign_in_json_getter.dart';

class CategoryScreen extends StatefulWidget {
  static String routeName = 'categoryScreen';
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var jsonData;

  Future getJson() async {
    return await JsonGetter(jsonFileName: 'data/catalog.json').loadData();
  }

  @override
  void initState() {
    getJson().then((result) {
      print('hiosadiosancsndovndsvndsvnsdoivnsdivnisodnvoisdnvsdiv' +
          result['catalogs'][0]['type']);
      setState(() {
        jsonData = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ReusableItemCard(
                  isProduct: false,
                  catalogName: jsonData['catalogs'][index]['type'],
                  imageUrl:
                      'https://external-preview.redd.it/Rmryan2W90zOKh0uuFeLXlJZ5CPCA-hOmnvv2NFPCCQ.jpg?auto=webp&s=e74d779c246115721c0fe14ed9a36b611a8ad11f',
                );
              },
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}

// child: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//         ),
//         itemCount: 5,
//         itemBuilder: (context, index) {
//           //print(jsonData);
//           while (jsonData == null) {
//             Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           return ReusableItemCard(
//             productName: jsonData['catalogs'][index]['type'],
//             imageUrl:
//                 'https://external-preview.redd.it/Rmryan2W90zOKh0uuFeLXlJZ5CPCA-hOmnvv2NFPCCQ.jpg?auto=webp&s=e74d779c246115721c0fe14ed9a36b611a8ad11f',
//           );
//         },
//       ),

// FutureBuilder(
//         future: DefaultAssetBundle.of(context).loadString('data/catalog.json'),
//         builder: (context, snapshot) {
//           var jsonData = jsonDecode(snapshot.data.toString());
//           print(jsonData);

//           return ListView.builder(
//             itemBuilder: (context, index) {
//               return ReusableItemCard(
//                 productName: jsonData[index]['type'],
//                 imageUrl:
//                     'https://external-preview.redd.it/Rmryan2W90zOKh0uuFeLXlJZ5CPCA-hOmnvv2NFPCCQ.jpg?auto=webp&s=e74d779c246115721c0fe14ed9a36b611a8ad11f',
//               );
//             },
//             itemCount: jsonData == null ? 0 : jsonData.length,
//           );
//         },
//       ),

import 'package:flutter/material.dart';
import 'package:rentio/components/reusable_person_card.dart';
import 'package:rentio/services/http_executioner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rentio/utilities/constants.dart';

class SeeMoreTopLenderScreen extends StatefulWidget {
  @override
  _SeeMoreTopLenderScreenState createState() => _SeeMoreTopLenderScreenState();
}

class _SeeMoreTopLenderScreenState extends State<SeeMoreTopLenderScreen> {
  var jsonData;

  Future getTopLenderData() async {
    http.Response responseGet = await HttpExecutioner.get(
      requestURL: "$apiURL/api/top_lender",
      headers: {
        "content-type": "application/json",
      },
    );
    return await json.decode(responseGet.body);
  }

  Future getTopLenderJson() async {
    // return await JsonGetter(jsonFileName: 'data/top_lender.json').loadData();
    var json = await getTopLenderData();
    return json;
  }

  Widget loadLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget topLenderWidget() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ReusablePersonCard(
                  personName: jsonData['top_lender'][index]['first_name'] +
                      ' ' +
                      jsonData['top_lender'][index]['last_name'],
                  personRating: jsonData['top_lender'][index]['average_star'],
                  imageUrl:
                      'https://external-preview.redd.it/Rmryan2W90zOKh0uuFeLXlJZ5CPCA-hOmnvv2NFPCCQ.jpg?auto=webp&s=e74d779c246115721c0fe14ed9a36b611a8ad11f',
                ),
              );
            },
            childCount: jsonData['top_lender'].length,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    getTopLenderJson().then((result) {
      setState(() {
        jsonData = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: jsonData == null ? loadLoadingWidget() : topLenderWidget(),
    );
  }
}

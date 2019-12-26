import 'package:flutter/material.dart';
import 'package:rentio/screens/product_list.dart';
import 'package:rentio/services/stringManipulator.dart';
import 'package:rentio/utilities/constants.dart';
import '../data_models/product_in_stock.dart';
import '../data_models/product_in_stock.dart';

class ProductSearch extends SearchDelegate<ProductInStock> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? []
        : productInStockList
            .where((a) => a.name.toLowerCase().contains(query))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        title: FlatButton(
          color: Color(transparent),
          child: Text(suggestionList[index].name),
          onPressed: () {
            query = suggestionList[index].name;
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductListScreen(
                    title: StringManipulator.changeFirstLetterUpperCase(query),
                    searchedName: query,
                  ),
                ));
          },
        ),
      ),
    );
  }
}

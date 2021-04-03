import 'package:classicarchive/search/bloc/search_bloc.dart';
import 'package:classicarchive/search/search_detail_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

import 'models/item_models.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState () => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  SearchBar searchBar;
  List<ItemResult> resultSet = [];
  bool currentlySearching = false;

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text("Classic Archive Item Search"),
      actions: [searchBar.getSearchAction(context)],
    );
  }

  void _searchItems(String searchQuery) {
    setState(() {
      currentlySearching = true;
    });
    searchBloc.searchItems(searchQuery);
  }

  @override
  void initState() {
    super.initState();
    searchBloc.itemResult.listen((result) {
      setState(() {
        currentlySearching = false;
        resultSet.clear();
        result.forEach((item) {
          resultSet.add(ItemResult(item: item));
        });
      });
    });

    searchBar = SearchBar(
      inBar: true,
      setState: setState,
      onSubmitted: _searchItems,
      buildDefaultAppBar: buildAppBar
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: searchBar.build(context),
      body: Center(
        child: resultSet.length > 0 ?
        SingleChildScrollView(
          child: Column(
            children: [
              ...resultSet
            ],
          )
        ) : currentlySearching ?
        CircularProgressIndicator() : Text("Click the magnifying glass to search!"),
      )
    );
  }
}

class ItemResult extends StatelessWidget {
  final Item item;

  ItemResult({@required this.item});

  void _showResultDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) { 
        return ResultDetailDialog(itemResult: item); 
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        child: InkWell(
          onTap: () {
            _showResultDialog(context);
          },
          child: Row(
            children: [
              Image.network(item.imgUrl),
              Text(
                item.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0
                ),
              )
            ],
          ),
      )),
    );
  }
}
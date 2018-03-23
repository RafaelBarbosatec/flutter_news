import 'package:flutter/material.dart';

class SearchResultPage extends StatefulWidget{

  final String query;

  SearchResultPage(this.query);

  @override
  State<StatefulWidget> createState() {
   return new _SearchResultState();
  }

}

class _SearchResultState extends State<SearchResultPage>{

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Search"),
      ),
      body: new Container(
        child: new Center(
          child: new Text(widget.query),
        ),
      ),
    );
    
  }

}
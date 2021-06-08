import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/pages/search/search_page.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController editingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      margin: const EdgeInsets.only(),
      child: new Material(
        borderRadius: const BorderRadius.all(const Radius.circular(25.0)),
        elevation: 2.0,
        child: new Container(
          height: 45.0,
          margin: new EdgeInsets.only(left: 16.0, right: 16.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                maxLines: 1,
                decoration: new InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).accentColor,
                  ),
                  hintText: Cubes.getString("hint_busca"),
                  border: InputBorder.none,
                ),
                onSubmitted: (query) => onSubmitted(query, context),
                controller: editingController,
              ))
            ],
          ),
        ),
      ),
    );
  }

  void onSubmitted(String query, BuildContext context) {
    if (query.isEmpty) return;
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (BuildContext context) {
        return SearchPage(query);
      }),
    );
  }
}

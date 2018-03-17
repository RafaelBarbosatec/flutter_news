import 'package:flutter/material.dart';

class ContentNewsPage extends StatefulWidget{

  final state = new _ContentNewsPageState();

  @override
  _ContentNewsPageState createState() => state;

}

class _ContentNewsPageState extends State<ContentNewsPage>{

  var current_category = '';

  List _news = new List();

  bool carregando = false;

  @override
  void initState() {
    _news.add("oi");
    _news.add("oi");
    _news.add("oi");
    _news.add("oi");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print(current_category);

    return new Container(
      child:new Column(
        children: <Widget>[
          _getListViewWidget()
        ],
      )
    );

  }

  Widget _getListViewWidget(){

    ListView listView = new ListView.builder(
        itemCount: _news.length,
        itemBuilder: (context, index){

          //final Map notice = _news[index];

          return _getListItemWidget(_news[index]);
        });

    RefreshIndicator refreshIndicator = new RefreshIndicator(
        onRefresh: onRefresh,
        child: listView
    );

    return new Flexible(
        child: refreshIndicator
    );

  }

  onRefresh() async{

  }

  Widget _getListItemWidget(notice){

    return new Text(notice);
  }

  loadCategory(category){
    print(category);
    setState((){
      current_category = category;
      _news.add(current_category);
      }
    );
  }

}
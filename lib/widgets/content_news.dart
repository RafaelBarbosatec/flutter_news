import 'dart:async';

import 'package:flutter/material.dart';

import 'package:FlutterNews/domain/notice/notice.dart';
import '../conection/api.dart';

class ContentNewsPage extends StatefulWidget{

  var errorConection = false;

  final state = new _ContentNewsPageState();

  @override
  _ContentNewsPageState createState() => state;

}

class _ContentNewsPageState extends State<ContentNewsPage> with TickerProviderStateMixin{

  var current_category = 'geral';
  List _news = new List();
  List _categorys = new List();
  List _category_english = new List();
  var carregando = false;
  var repository = new NewsApi();
  var page = 0;
  var pages = 1;
  var category_selected = 0;

  @override
  void initState() {

    _categorys.add("Geral");
    _categorys.add("Esporte");
    _categorys.add("Tecnologia");
    _categorys.add("Entretenimento");
    _categorys.add("Saúde");
    _categorys.add("Negócios");

    _category_english.add("geral");
    _category_english.add("sports");
    _category_english.add("technology");
    _category_english.add("entertainment");
    _category_english.add("health");
    _category_english.add("business");

    loadCategory(current_category,page);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return new Container(
      padding: EdgeInsets.only(top: 2.0),
      child: new Stack(
        children: <Widget>[
          widget.errorConection ? _buildConnectionError(): _getListViewWidget(),
          _getListCategory(),
        ],
      )
    );

  }

  Widget _buildConnectionError(){

    return new Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 8.0,
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(
              Icons.cloud_off,
              size: 100.0,
              color: Colors.blue,
            ),
            new Text(
              "Erro de conexão",
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: new RaisedButton(
                onPressed: (){
                  loadCategory(current_category,page);
                },
                child: new Text("TENTAR NOVAMENTE"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );

  }

  Widget _getListViewWidget(){

    ListView listView = new ListView.builder(
        itemCount: _news.length,
        padding: new EdgeInsets.only(top: 5.0),
        itemBuilder: (context, index){

          //final Map notice = _news[index];
          //print(index);
//
          if(index >= _news.length -1 && !carregando){
            loadCategory(current_category, page);
          }
        print(index);
        if(index == 0){
          return Container(
            margin: EdgeInsets.only(top: 50.0),
            child: _news[index],
          );
        }else
          return _news[index];
        }
    );

    RefreshIndicator refreshIndicator = new RefreshIndicator(
        onRefresh: myRefresh,
        child: listView
    );

    return new Stack(
      children: <Widget>[
        refreshIndicator,
        _getProgress()
      ],
    );

  }

  Widget _getProgress(){

    if(carregando){
      return new Container(
        child: new Center(
          child: new CircularProgressIndicator(),
        ),
      );
    }else{
      return new Container();
    }

  }

  Widget _getListCategory(){

    ListView listCategory = new ListView.builder(
        itemCount: _categorys.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){


          return _buildCategoryItem(index);
        }
    );

    return new Container(
      height: 50.0,
      child: listCategory,
      color: Colors.grey[200].withAlpha(200),
    );

  }

  Widget _buildCategoryItem(index){

    return new InkWell(
      onTap: (){
        onTabCategory(index);
        print("click");
      },
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: new Material(
              elevation: 2.0,
              color: category_selected == index ? Colors.blue[800]:Colors.blue[500],
              borderRadius: const BorderRadius.all(const Radius.circular(25.0)),
              child:  new Container(
                padding: new EdgeInsets.only(left: 12.0,top: 7.0,bottom: 7.0,right: 12.0),
                child: new Text(_categorys[index],
                  style: new TextStyle(
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );

  }

  onTabCategory(index){

    if(!carregando) {

      setState(() {
        category_selected = index;
        page = 0;
      });

      loadCategory(_category_english[index], page);

    }

  }

  Future<Null> myRefresh() async{

    await loadCategory(current_category,page);

    return null;
  }

  loadCategory(category,page) async{

    if(page < pages-1 || page == 0) {

//      setState((){
//
//        current_category = category;
//
//        if(page == 0) {
//          _news.clear();
//        }
//
//        carregando = true;
//
//      });

      Map result = await repository.loadNews(category, page.toString());

      if(result != null) {

        widget.errorConection = false;

        setState(() {
          pages = result['data']['pages'];
          this.page = page + 1;
          result['data']['news'].forEach((item) {
            var notice = new Notice(
                item['url_img'] == null ? '' : item['url_img'],
                item['tittle'] == null ? '' : item['tittle'],
                item['date'] == null ? '' : item['date'],
                item['description'] == null ? '' : item['description'],
                item['category'] == null ? '' : item['category'],
                item['link'] == null ? '' : item['link'],
                item['origin'] == null ? '' : item['origin'],
            );
            _news.add(notice);

          });

          carregando = false;
        }

        );
      }else{

        widget.errorConection = true;

        setState((){
          carregando = false;
        });

      }

    }
  }

  @override
  void dispose() {
    super.dispose();
  }

}
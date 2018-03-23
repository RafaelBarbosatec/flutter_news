import 'package:flutter/material.dart';
import 'notice.dart';
import '../conection/api.dart';

class ContentNewsPage extends StatefulWidget{

  final vsync;

  ContentNewsPage(this.vsync);

  final state = new _ContentNewsPageState();

  @override
  _ContentNewsPageState createState() => state;

}

class _ContentNewsPageState extends State<ContentNewsPage>{

  var current_category = 'geral';
  List _news = new List();
  var carregando = false;
  var repository = new NewsApi();
  var page = 0;
  var pages = 1;

  @override
  void initState() {

    loadCategory(current_category,page);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //print(current_category);

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
          //print(index);

          if(index >= _news.length -4 && !carregando){
            loadCategory(current_category, page);
          }

          return _news[index];
        }
        );

    RefreshIndicator refreshIndicator = new RefreshIndicator(
        onRefresh: onRefresh,
        child: listView
    );

    return new Flexible(
        child: new Stack(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Container(
                  color: Colors.pink,
                  height: 50.0,
                ),
                new Expanded(
                    child: refreshIndicator
                )
              ],
            ),
            _getProgress()
          ],
        )
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

  onRefresh() async{
    loadCategory(current_category,page);
  }

  loadCategory(category,page) async{

    if(page < pages-1 || page == 0) {

      setState((){

        current_category = category;

        if(page == 0) {
          _news.clear();
        }

        carregando = true;

      });

      print(page);

      Map result = await repository.loadNews(category, page.toString());

      setState(() {
        pages = result['data']['pages'];
        this.page = page + 1;
        result['data']['news'].forEach((item) {
          var notice = new Notice(
              item['url_img'] == null ? '' : item['url_img'],
              item['tittle'] == null ? '' : item['tittle'],
              item['date'] == null ? '' : item['date'],
              item['description'] == null ? '' : item['description'],
              new AnimationController(
                duration: new Duration(milliseconds: 300),
                vsync: widget.vsync,
              )
          );
          _news.add(notice);
          notice.animationController.forward();
        });

        carregando = false;
      }

      );

    }
  }

  @override
  void dispose() {
    for (Notice n in _news)
      n.animationController.dispose();
    super.dispose();
  }

}
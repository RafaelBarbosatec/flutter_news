import 'package:flutter/material.dart';
import 'notice.dart';
import '../conection/api.dart';

class ContentNewsPage extends StatefulWidget{

  final state = new _ContentNewsPageState();

  @override
  _ContentNewsPageState createState() => state;

}

class _ContentNewsPageState extends State<ContentNewsPage> with TickerProviderStateMixin{

  var current_category = '';
  List _news = new List();
  bool carregando = false;
  var repository = new NewsApi();

  @override
  void initState() {

    loadCategory(current_category);

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
            refreshIndicator,
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
    loadCategory(current_category);
  }

  loadCategory(category) async{

    setState((){

      current_category = category;
      _news.clear();
      carregando = true;
    });
    Map result = await repository.loadNews('br', category);

    setState((){


      result['articles'].forEach((item){

        var notice = new Notice(
            item['urlToImage'] == null ? '':item['urlToImage'],
            item['title'] == null ? '':item['title'],
            item['publishedAt'] == null ? '':item['publishedAt'],
            item['description'] == null ? '':item['description'],
            new AnimationController(
              duration: new Duration(milliseconds: 600),
              vsync: this,
            )
        );
        _news.add(notice);
        notice.animationController.forward();

      });

      carregando = false;

      }
    );
  }

  @override
  void dispose() {
    for (Notice n in _news)
      n.animationController.dispose();
    super.dispose();
  }

}
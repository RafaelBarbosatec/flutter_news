import 'dart:async';

import 'package:FlutterNews/conection/api.dart';
import 'package:FlutterNews/pages/news/news_bloc.dart';
import 'package:FlutterNews/util/bloc_provider.dart';
import 'package:FlutterNews/widgets/erro_conection.dart';
import 'package:flutter/material.dart';
import 'package:FlutterNews/domain/notice/notice.dart';

class ContentNewsPage extends StatefulWidget{


  static Widget create(){
    return BlocProvider<NewsBloc>(
      bloc: NewsBloc(),
      child: ContentNewsPage(),
    );
  }

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

  NewsBloc bloc;

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

    //loadCategory(current_category,page);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(bloc == null) {

      bloc = BlocProvider.of<NewsBloc>(context);
      confBlocView(bloc);

    }

    return new Container(
      padding: EdgeInsets.only(top: 2.0),
      child: new Stack(
        children: <Widget>[
          _getListViewWidget(),
          _buildConnectionError(),
          _getProgress(),
          _getListCategory(),
        ],
      )
    );

  }

  Widget _buildConnectionError(){

    return StreamBuilder(
        stream: bloc.error,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot snapshot){

          if(snapshot.data) {
            return ErroConection(tryAgain:(){
              bloc.load(false);
            });
          }else{
            return Container();
          }

        }
    );

  }

  Widget _getListViewWidget(){

    return Container(
      child: StreamBuilder(
        stream: bloc.noticies,
        initialData: List<Notice>(),
        builder: (BuildContext context, AsyncSnapshot snapshot){

          var news = snapshot.data;

          ListView listView = new ListView.builder(
              itemCount: news.length,
              padding: new EdgeInsets.only(top: 5.0),
              itemBuilder: (context, index){

                if(index + 3 >= news.length){
                  bloc.load(true);
                }

                if(index == 0){
                  return Container(
                    margin: EdgeInsets.only(top: 50.0),
                    child: news[index],
                  );
                }else{
                  return news[index];
                }
              }
          );

          return RefreshIndicator(
              onRefresh: myRefresh,
              child: listView
          );

        }
      ),
    );

  }

  Widget _getProgress(){

    return Center(
      child: StreamBuilder(
          stream: bloc.progress,
          initialData: false,
          builder: (BuildContext context, AsyncSnapshot snapshot){

            if(snapshot.data){
              return new CircularProgressIndicator();
            }else{
              return new Container();
            }

          }
      ),
    );

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

    bloc.load(false);

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

  void confBlocView(NewsBloc bloc) {
    bloc.anim.listen((show){

      if(show){
        //animationController.forward();
      }

    });

    bloc.load(false);
  }

}
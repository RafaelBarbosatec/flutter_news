import 'dart:async';

import 'package:FlutterNews/conection/api.dart';
import 'package:FlutterNews/pages/news/news_bloc.dart';
import 'package:FlutterNews/util/bloc_provider.dart';
import 'package:FlutterNews/widgets/custom_tab.dart';
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

  List _categorys = new List<String>();
  NewsBloc bloc;

  @override
  void initState() {

    _categorys.add("Geral");
    _categorys.add("Esporte");
    _categorys.add("Tecnologia");
    _categorys.add("Entretenimento");
    _categorys.add("Saúde");
    _categorys.add("Negócios");

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

    return CustomTab(
      itens: _categorys,
      tabSelected: (index){
        bloc.setCategoryPosition(index);
      },
    );

  }

  Future<Null> myRefresh() async{

    bloc.load(false);

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
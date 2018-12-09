import 'dart:async';

import 'package:FlutterNews/localization/MyLocalizations.dart';
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

  final state = new _ContentNewsPageState();

  @override
  _ContentNewsPageState createState() => state;

}

class _ContentNewsPageState extends State<ContentNewsPage> with TickerProviderStateMixin{

  AnimationController animationController;
  List _categorys = new List<String>();
  MyLocalizations strl;
  NewsBloc bloc;

  @override
  void initState() {

    animationController = new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 350)
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    strl = MyLocalizations.of(context);

    _categorys.add(strl.trans("cat_geral"));
    _categorys.add(strl.trans("cat_esporte"));
    _categorys.add(strl.trans("cat_tecnologia"));
    _categorys.add(strl.trans("cat_entretenimento"));
    _categorys.add(strl.trans("cat_saude"));
    _categorys.add(strl.trans("cat_negocios"));

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

          return FadeTransition(
            opacity: animationController,
            child: RefreshIndicator(
                onRefresh: myRefresh,
                child: listView
            ),
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
    animationController.dispose();
    super.dispose();
  }

  void confBlocView(NewsBloc bloc) {
    bloc.anim.listen((show){

      if(show){
        animationController.forward(from: 0.0);
      }

    });

    bloc.load(false);
  }

}
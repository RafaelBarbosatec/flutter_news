import 'dart:async';
import 'package:FlutterNews/injection/injector.dart';
import 'package:FlutterNews/pages/news/news_bloc.dart';
import 'package:FlutterNews/util/bloc_provider.dart';
import 'package:FlutterNews/widgets/custom_tab.dart';
import 'package:FlutterNews/widgets/erro_conection.dart';
import 'package:flutter/material.dart';
import 'package:FlutterNews/domain/notice/notice.dart';

class ContentNewsPage extends StatefulWidget{

  static Widget create(){
    return BlocProvider<NewsBloc>(
      bloc: NewsBloc(Injector().repository.getNoticeRepository()),
      child: ContentNewsPage(),
    );
  }

  final state = new _ContentNewsPageState();

  @override
  _ContentNewsPageState createState() => state;

}

class _ContentNewsPageState extends State<ContentNewsPage> with TickerProviderStateMixin{

  AnimationController animationController;
  AnimationController animationTraslateController;
  Animation<Offset> animationSlideUp;
  List _categorys = new List<String>();
  NewsBloc bloc;

  @override
  void initState() {

    animationController = new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 600)
    );
    animationTraslateController = new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 600)
    );

    animationSlideUp = new Tween(
        begin: Offset(0.0,5.0)
        , end: Offset(0.0,0.0)
    ).animate(
        CurvedAnimation(
            parent: animationTraslateController,
            curve: Curves.decelerate
        )
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(bloc == null) {

      bloc = BlocProvider.of<NewsBloc>(context);
      confBlocView(bloc);

      _categorys.clear();
      _categorys.add(bloc.getString("cat_geral"));
      _categorys.add(bloc.getString("cat_esporte"));
      _categorys.add(bloc.getString("cat_tecnologia"));
      _categorys.add(bloc.getString("cat_entretenimento"));
      _categorys.add(bloc.getString("cat_saude"));
      _categorys.add(bloc.getString("cat_negocios"));

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
        stream: bloc.streams.error,
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
        stream: bloc.streams.noticies,
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

          return SlideTransition(
            position: animationSlideUp,
            child: FadeTransition(
              opacity: animationController,
              child: RefreshIndicator(
                  onRefresh: myRefresh,
                  child: listView
              ),
            ),
          );

        }
      ),
    );

  }

  Widget _getProgress(){

    return Center(
      child: StreamBuilder(
          stream: bloc.streams.progress,
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
        bloc.streams.setCategoryPosition(index);
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
    bloc.streams.anim.listen((show){

      if(show){
        animationController.forward(from: 0.0);
        animationTraslateController.forward(from: 0.0);
      }

    });

    bloc.load(false);
  }

}
import 'package:FlutterNews/pages/featured/featured_view.dart';
import 'package:FlutterNews/pages/home/home_bloc.dart';
import 'package:FlutterNews/pages/home/home_streams.dart';
import 'package:FlutterNews/pages/info/info.dart';
import 'package:FlutterNews/pages/news/news_view.dart';
import 'package:FlutterNews/widgets/bottom_navigation.dart';
import 'package:FlutterNews/widgets/search.dart';
import 'package:bsev/bsev.dart';
import 'package:flutter/material.dart';

class HomeView extends BlocStatelessView<HomeBloc,HomeStreams> {

  @override
  void eventReceiver(EventsBase event) {
  }

  @override
  Widget buildView(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: Colors.grey[200],
        child:  new Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Container(
              child: new SearchWidget(),
            ) ,
            new Expanded(
                child: _getContent()
            )
          ],
        ),
      ),
      bottomNavigationBar: new BottomNavigation((index){
        streams.tabPosition.set(index);
      }), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _getContent(){
    return StreamBuilder(
        stream: streams.tabPosition.get,
        initialData: 0,
        builder:  (BuildContext context, AsyncSnapshot snapshot){

          var position = snapshot.hasData ? snapshot.data:0;

          switch(position){
            case 0:return FeaturedView().create();break;
            case 1: return NewsView().create();break;
            case 2: return Info();
          }

        }
    );
  }

}
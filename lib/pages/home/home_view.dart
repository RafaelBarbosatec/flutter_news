import 'package:FlutterNews/pages/featured/featured_view.dart';
import 'package:FlutterNews/pages/home/home_bloc.dart';
import 'package:FlutterNews/pages/home/home_communication.dart';
import 'package:FlutterNews/pages/info/info.dart';
import 'package:FlutterNews/pages/news/news_view.dart';
import 'package:FlutterNews/widgets/bottom_navigation.dart';
import 'package:FlutterNews/widgets/search.dart';
import 'package:bsev/bsev.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Bsev<HomeBloc, HomeCommunication>(
      builder: (context, communication) {
        return Scaffold(
          body: Container(
            color: Colors.grey[200],
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: SearchWidget(),
                  ),
                  Expanded(child: _getContent(communication))
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigation((index) {
            communication.tabPosition.set(index);
          }), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }

  Widget _getContent(HomeCommunication streams) {
    return StreamListener<int>(
        stream: streams.tabPosition,
        builder: (BuildContext context, snapshot) {
          switch (snapshot.data) {
            case 0:
              return FeaturedView();
              break;
            case 1:
              return NewsView();
              break;
            case 2:
              return Info();
            default:
              return Container();
          }
        });
  }
}

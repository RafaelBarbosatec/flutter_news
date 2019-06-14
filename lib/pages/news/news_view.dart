import 'dart:async';
import 'package:FlutterNews/pages/news/news_bloc.dart';
import 'package:FlutterNews/pages/news/news_events.dart';
import 'package:FlutterNews/pages/news/news_streams.dart';
import 'package:FlutterNews/repository/notice_repository/model/notice.dart';
import 'package:FlutterNews/widgets/AnimatedContent.dart';
import 'package:FlutterNews/widgets/custom_tab.dart';
import 'package:FlutterNews/widgets/erro_conection.dart';
import 'package:flutter/material.dart';
import 'package:bsev/bsev.dart';

class NewsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Bsev<NewsBloc,NewsStreams>(
      builder: (context,dispatcher,streams){

        return new Container(
            padding: EdgeInsets.only(top: 2.0),
            child: new Stack(
              children: <Widget>[
                _getListViewWidget(streams,dispatcher),
                _buildConnectionError(streams,dispatcher),
                _getProgress(streams),
                _getListCategory(streams,dispatcher),
              ],
            )
        );

      },
    );
  }

  Widget _buildConnectionError(NewsStreams streams,dispatcher) {
    return StreamBuilder(
        stream: streams.errorConection.get,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return ErroConection(tryAgain: () {
              dispatcher(LoadNews()..data = false);
            });
          } else {
            return Container();
          }
        });
  }

  Widget _getListViewWidget(NewsStreams streams,dispatcher) {
    return Container(
      child: StreamBuilder(
          stream: streams.noticies.get,
          initialData: List<Notice>(),
          builder: (_, AsyncSnapshot snapshot) {

            if(snapshot.hasData){

              List news = snapshot.data;

              ListView listView = new ListView.builder(
                  itemCount: news.length,
                  padding: new EdgeInsets.only(top: 5.0),
                  itemBuilder: (context, index) {

                    if (index == 0) {

                      return Container(
                        margin: EdgeInsets.only(top: 50.0),
                        child: news[index],
                      );

                    } else {

                      if (index + 1 >= news.length) {
                        dispatcher(LoadMoreNews());
                      }

                      return news[index];
                    }
                  });

              return AnimatedContent(
                show: news.length > 0,
                child: RefreshIndicator(onRefresh: (){
                  return myRefresh(dispatcher);
                }, child: listView),
              );

            }else{

              return Container();

            }

          }
      ),
    );
  }

  Widget _getProgress(NewsStreams streams) {
    return Center(
      child: StreamBuilder(
          stream: streams.progress.get,
          initialData: false,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data) {
              return new CircularProgressIndicator();
            } else {
              return new Container();
            }
          }),
    );
  }

  Widget _getListCategory(NewsStreams streams,dispatcher) {
    return StreamBuilder(
      stream: streams.categoriesName.get,
      builder: (_,snapshot){

        if(snapshot.hasData){
          List<String> list = snapshot.data;
          return AnimatedOpacity(
            opacity: 1,
            duration: Duration(milliseconds: 300),
            child: CustomTab(
              itens: list,
              tabSelected: (index) {
                dispatcher(ClickCategory()..data = index);
              },
            ),
          );
        }else{
          return AnimatedOpacity(
            opacity: 0,
            duration: Duration(milliseconds: 300),
          );
        }

      },
    );

  }

  Future<Null> myRefresh(dispatcher) async {
    dispatcher(LoadNews());
  }
}
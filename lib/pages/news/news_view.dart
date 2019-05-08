import 'dart:async';
import 'package:FlutterNews/pages/news/news_bloc.dart';
import 'package:FlutterNews/pages/news/news_events.dart';
import 'package:FlutterNews/pages/news/news_streams.dart';
import 'package:FlutterNews/widgets/AnimatedContent.dart';
import 'package:FlutterNews/widgets/custom_tab.dart';
import 'package:FlutterNews/widgets/erro_conection.dart';
import 'package:flutter/material.dart';
import 'package:FlutterNews/domain/notice/notice.dart';
import 'package:bsev/bsev.dart';

class NewsView extends BlocStatelessView<NewsBloc,NewsStreams,NewsEvents> {

  @override
  Widget buildView(BuildContext context) {

    return new Container(
        padding: EdgeInsets.only(top: 2.0),
        child: new Stack(
          children: <Widget>[
            _getListViewWidget(),
            _buildConnectionError(),
            _getProgress(),
            _getListCategory(),
          ],
        ));
  }

  Widget _buildConnectionError() {
    return StreamBuilder(
        stream: streams.error,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data) {
            return ErroConection(tryAgain: () {
              dispatch(LoadNews()..data = false);
            });
          } else {
            return Container();
          }
        });
  }

  Widget _getListViewWidget() {
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
                        dispatch(LoadMoreNews());
                      }

                      return news[index];
                    }
                  });

              return AnimatedContent(
                show: news.length > 0,
                child: RefreshIndicator(onRefresh: myRefresh, child: listView),
              );

            }else{

              return Container();

            }

          }
          ),
    );
  }

  Widget _getProgress() {
    return Center(
      child: StreamBuilder(
          stream: streams.progress,
          initialData: false,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data) {
              return new CircularProgressIndicator();
            } else {
              return new Container();
            }
          }),
    );
  }

  Widget _getListCategory() {
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
                dispatch(ClickCategory()..data = index);
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

  Future<Null> myRefresh() async {
    dispatch(LoadNews());
  }

  @override
  void eventReceiver(EventsBase event) {

  }

}

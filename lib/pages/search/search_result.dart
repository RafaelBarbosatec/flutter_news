import 'package:FlutterNews/pages/search/search_events.dart';
import 'package:FlutterNews/pages/search/search_result_bloc.dart';
import 'package:FlutterNews/pages/search/search_streams.dart';
import 'package:FlutterNews/repository/notice_repository/model/notice.dart';
import 'package:FlutterNews/support/util/StringsLocation.dart';
import 'package:FlutterNews/widgets/AnimatedContent.dart';
import 'package:FlutterNews/widgets/erro_conection.dart';
import 'package:bsev/bsev.dart';
import 'package:flutter/material.dart';

class SearchView extends BlocStatelessView<SearchBloc,SearchStreams> {

  final String query;

  SearchView(this.query);

  @override
  Widget buildView(BuildContext context, SearchStreams streams) {

    dispatch(LoadSearch()..data = query);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(query),
      ),
      body: Stack(
        children: <Widget>[
          _getListViewWidget(streams),
          _getProgress(streams),
          _getEmpty(streams),
          _buildConnectionError(streams)
        ],
      ),
    );
  }

  Widget _getListViewWidget(SearchStreams streams) {
    return StreamBuilder(
        initialData: List<Notice>(),
        stream: streams.noticies.get,
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          if(snapshot.hasData){
            List news = snapshot.data;

            var listView = ListView.builder(
                  itemCount: news.length,
                  padding: new EdgeInsets.only(top: 5.0),
                  itemBuilder: (context, index) {
                    return news[index];
                  }
                );

            return AnimatedContent(
              show: news.length > 0,
              child: listView,
            );

          }else{
            return Container();
          }

        });
  }

  Widget _getProgress(SearchStreams streams) {
    return StreamBuilder(
        stream: streams.progress.get,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return new Container(
              child: new Center(
                child: new CircularProgressIndicator(),
              ),
            );
          } else {
            return new Container();
          }
        });
  }

  Widget _getEmpty(SearchStreams streams) {
    return StreamBuilder(
        stream: streams.empty.get,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return Container(
              child: new Center(
                child: new Text(getString("erro_busca")),
              ),
            );
          } else {
            return Container();
          }
        });
  }

  Widget _buildConnectionError(SearchStreams streams) {
    return StreamBuilder(
        stream: streams.error.get,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return ErroConection(tryAgain: () {
              dispatch(LoadSearch()..data = query);
            });
          } else {
            return Container();
          }
        });
  }

  @override
  void eventReceiver(EventsBase event) {
  }
}

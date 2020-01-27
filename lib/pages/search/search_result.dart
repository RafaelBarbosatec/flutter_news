import 'package:FlutterNews/pages/search/search_events.dart';
import 'package:FlutterNews/pages/search/search_result_bloc.dart';
import 'package:FlutterNews/pages/search/search_streams.dart';
import 'package:FlutterNews/repository/notice_repository/model/notice.dart';
import 'package:FlutterNews/support/util/StringsLocation.dart';
import 'package:FlutterNews/widgets/AnimatedContent.dart';
import 'package:FlutterNews/widgets/erro_conection.dart';
import 'package:bsev/bsev.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  final String query;

  SearchView(this.query);

  @override
  Widget build(BuildContext context) {
    return Bsev<SearchBloc, SearchStreams>(
      dataToBloc: query,
      builder: (context, dispatcher, streams) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(query),
          ),
          body: Stack(
            children: <Widget>[
              _getListViewWidget(streams),
              _getProgress(streams),
              _getEmpty(streams),
              _buildConnectionError(streams, dispatcher)
            ],
          ),
        );
      },
    );
  }

  Widget _getListViewWidget(SearchStreams streams) {
    return StreamListener<List<Notice>>(
        stream: streams.noticies.get,
        builder: (BuildContext context, snapshot) {
          List news = snapshot.data;

          var listView = ListView.builder(
              itemCount: news.length,
              padding: new EdgeInsets.only(top: 5.0),
              itemBuilder: (context, index) {
                return news[index];
              });

          return AnimatedContent(
            show: news.length > 0,
            child: listView,
          );
        });
  }

  Widget _getProgress(SearchStreams streams) {
    return StreamListener<bool>(
        stream: streams.progress.get,
        builder: (BuildContext context, snapshot) {
          if (snapshot.data) {
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
    return StreamListener<bool>(
        stream: streams.empty.get,
        builder: (BuildContext context, snapshot) {
          if (snapshot.data) {
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

  Widget _buildConnectionError(SearchStreams streams, dispatcher) {
    return StreamListener<bool>(
        stream: streams.error.get,
        builder: (BuildContext context, snapshot) {
          if (snapshot.data) {
            return ErroConection(tryAgain: () {
              dispatcher(LoadSearch()..query = query);
            });
          } else {
            return Container();
          }
        });
  }
}

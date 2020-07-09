import 'package:FlutterNews/pages/search/search_communication.dart';
import 'package:FlutterNews/pages/search/search_events.dart';
import 'package:FlutterNews/pages/search/search_result_bloc.dart';
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
    return BsevBuilder<SearchBloc, SearchCommunication>(
      dataToBloc: query,
      builder: (context, communication) {
        return Scaffold(
          appBar: AppBar(
            title: Text(query),
          ),
          body: Stack(
            children: <Widget>[
              _getListViewWidget(communication),
              _getProgress(communication),
              _getEmpty(communication),
              _buildConnectionError(communication)
            ],
          ),
        );
      },
    );
  }

  Widget _getListViewWidget(SearchCommunication streams) {
    return StreamListener<List<Notice>>(
        stream: streams.noticies,
        builder: (BuildContext context, snapshot) {
          List news = snapshot.data;
          return AnimatedContent(
            show: news.length > 0,
            child: ListView.builder(
              itemCount: news.length,
              padding: const EdgeInsets.only(top: 5.0),
              itemBuilder: (context, index) {
                return news[index];
              },
            ),
          );
        });
  }

  Widget _getProgress(SearchCommunication streams) {
    return streams.progress.builder<bool>((value) {
      return value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox.shrink();
    });
  }

  Widget _getEmpty(SearchCommunication streams) {
    return streams.empty.builder<bool>((value) {
      return value
          ? Center(
              child: Text(getString("erro_busca")),
            )
          : SizedBox.shrink();
    });
  }

  Widget _buildConnectionError(SearchCommunication communication) {
    return communication.error.builder((value) {
      return value
          ? ErroConection(tryAgain: () {
              communication.dispatcher(LoadSearch()..query = query);
            })
          : SizedBox.shrink();
    });
  }
}

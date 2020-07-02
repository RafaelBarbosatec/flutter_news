import 'dart:async';

import 'package:FlutterNews/pages/news/news_bloc.dart';
import 'package:FlutterNews/pages/news/news_communication.dart';
import 'package:FlutterNews/pages/news/news_events.dart';
import 'package:FlutterNews/repository/notice_repository/model/notice.dart';
import 'package:FlutterNews/widgets/AnimatedContent.dart';
import 'package:FlutterNews/widgets/custom_tab.dart';
import 'package:FlutterNews/widgets/erro_conection.dart';
import 'package:bsev/bsev.dart';
import 'package:flutter/material.dart';

class NewsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Bsev<NewsBloc, NewsCommunication>(
      builder: (context, communication) {
        return new Container(
            padding: EdgeInsets.only(top: 2.0),
            child: new Stack(
              children: <Widget>[
                _getListViewWidget(communication),
                _buildConnectionError(communication),
                _getProgress(communication),
                _getListCategory(communication),
              ],
            ));
      },
    );
  }

  Widget _getListViewWidget(NewsCommunication communication) {
    return Container(
      child: StreamListener<List<Notice>>(
          stream: communication.noticies,
          builder: (_, snapshot) {
            List news = snapshot.data;

            return AnimatedContent(
              show: news.length > 0,
              child: RefreshIndicator(
                onRefresh: () {
                  return myRefresh(communication.dispatcher);
                },
                child: ListView.builder(
                  itemCount: news.length,
                  padding: new EdgeInsets.only(top: 5.0),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        margin: const EdgeInsets.only(top: 50.0),
                        child: news[index],
                      );
                    } else {
                      if (index + 1 >= news.length) {
                        communication.dispatcher(LoadMoreNews());
                      }
                      return news[index];
                    }
                  },
                ),
              ),
            );
          }),
    );
  }

  Widget _buildConnectionError(NewsCommunication communication) {
    return communication.errorConection.builder<bool>((value) {
      return value
          ? ErroConection(tryAgain: () {
              communication.dispatcher(LoadNews());
            })
          : SizedBox.shrink();
    });
  }

  Widget _getProgress(NewsCommunication streams) {
    return streams.progress.builder<bool>((value) {
      return value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container();
    });
  }

  Widget _getListCategory(NewsCommunication communication) {
    return communication.categoriesName.builder<List<String>>((value) {
      return CustomTab(
        itens: value,
        tabSelected: (index) {
          communication.dispatcher(ClickCategory()..position = index);
        },
      );
    });
  }

  Future<Null> myRefresh(dispatcher) async {
    dispatcher(LoadNews());
  }
}

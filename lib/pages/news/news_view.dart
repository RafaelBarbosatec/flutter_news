import 'dart:async';

import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/pages/news/news_cube.dart';
import 'package:flutter_news/pages/news/widgets/notice_widget.dart';
import 'package:flutter_news/repository/notice_repository/model/notice.dart';
import 'package:flutter_news/widgets/AnimatedContent.dart';
import 'package:flutter_news/widgets/custom_tab.dart';
import 'package:flutter_news/widgets/erro_conection.dart';

class NewsView extends CubeWidget<NewsCube> {
  @override
  Widget buildView(BuildContext context, NewsCube cube) {
    return new Container(
      padding: EdgeInsets.only(top: 2.0),
      child: new Stack(
        children: <Widget>[
          _getListViewWidget(cube),
          _buildConnectionError(cube),
          _getProgress(cube),
          _getListCategory(cube),
        ],
      ),
    );
  }

  Widget _getListViewWidget(NewsCube cube) {
    return cube.noticeList.build<List<Notice>>((value) {
      return AnimatedContent(
        show: value.length > 0,
        child: RefreshIndicator(
          onRefresh: () {
            return myRefresh(cube);
          },
          child: ListView.builder(
            itemCount: value.length,
            padding: new EdgeInsets.only(top: 5.0),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  child: NoticeWidget(
                    item: value[index],
                  ),
                );
              } else {
                if (index + 1 >= value.length && !cube.lastPage) {
                  cube.load(true);
                }
                return NoticeWidget(
                  item: value[index],
                );
              }
            },
          ),
        ),
      );
    });
  }

  Widget _buildConnectionError(NewsCube cube) {
    return cube.errorConnection.build<bool>((value) {
      return value
          ? ErroConection(tryAgain: () {
              cube.load(false);
            })
          : SizedBox.shrink();
    });
  }

  Widget _getProgress(NewsCube cube) {
    return cube.progress.build<bool>(
      (value) {
        return value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container();
      },
      animate: true,
    );
  }

  Widget _getListCategory(NewsCube cube) {
    return cube.categoriesName.build<List<String>>((value) {
      return CustomTab(
        itens: value,
        tabSelected: (index) {
          cube.categoryClick(index);
        },
      );
    });
  }

  Future<Null> myRefresh(NewsCube cube) async {
    cube.load(false);
  }
}

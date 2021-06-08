import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/pages/news/widgets/notice_widget.dart';
import 'package:flutter_news/pages/search/search_cube.dart';
import 'package:flutter_news/repository/notice/model/notice.dart';
import 'package:flutter_news/widgets/animated_content.dart';
import 'package:flutter_news/widgets/error_connection.dart';

class SearchPage extends CubeWidget<SearchCube> {
  final String query;

  SearchPage(this.query);

  @override
  get arguments => query;

  @override
  Widget buildView(BuildContext context, SearchCube cube) {
    return Scaffold(
      appBar: AppBar(
        title: Text(query),
      ),
      body: Stack(
        children: <Widget>[
          _getListViewWidget(cube),
          _getProgress(cube),
          _getEmpty(cube),
          _buildConnectionError(cube),
        ],
      ),
    );
  }

  Widget _getListViewWidget(SearchCube cube) {
    return cube.noticeList.build<List<Notice>>((value) {
      return AnimatedContent(
        show: value.length > 0,
        child: ListView.builder(
          itemCount: value.length,
          padding: const EdgeInsets.only(top: 5.0),
          itemBuilder: (context, index) {
            return NoticeWidget(
              item: value[index],
            );
          },
        ),
      );
    });
  }

  Widget _getProgress(SearchCube cube) {
    return cube.progress.build<bool>(
      (value) {
        return value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox.shrink();
      },
      animate: true,
    );
  }

  Widget _getEmpty(SearchCube cube) {
    return cube.empty.build<bool>((value) {
      return value
          ? Center(
              child: Text(Cubes.getString("erro_busca")),
            )
          : SizedBox.shrink();
    });
  }

  Widget _buildConnectionError(SearchCube cube) {
    return cube.error.build<bool>((value) {
      return value
          ? ErrorConnection(tryAgain: () {
              cube.search(query);
            })
          : SizedBox.shrink();
    });
  }
}

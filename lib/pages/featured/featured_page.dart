import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/pages/featured/featured_cube.dart';
import 'package:flutter_news/repository/notice/model/notice.dart';
import 'package:flutter_news/widgets/error_connection.dart';
import 'package:flutter_news/widgets/page_transform/intro_page_item.dart';
import 'package:flutter_news/widgets/page_transform/page_transformer.dart';

class FeaturedPage extends CubeWidget<FeaturedCube> {
  @override
  Widget buildView(BuildContext context, FeaturedCube cube) {
    return Stack(
      children: <Widget>[
        Stack(
          children: <Widget>[
            _buildFeatured(cube),
            _getProgress(cube),
          ],
        ),
        _buildErrorConnection(cube)
      ],
    );
  }

  Widget _getProgress(FeaturedCube cube) {
    return cube.progress.build<bool>((value) {
      return value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox.shrink();
    });
  }

  Widget _buildFeatured(FeaturedCube cube) {
    return Container(
      child: cube.noticeList.build<List<Notice>>(
        (value) {
          if (value.isEmpty) return Container();
          return PageTransformer(
            pageViewBuilder: (context, visibilityResolver) {
              return PageView.builder(
                controller: new PageController(viewportFraction: 0.9),
                itemCount: value.length,
                itemBuilder: (context, index) {
                  final pageVisibility =
                      visibilityResolver?.resolvePageVisibility(index) ??
                          PageVisibility(visibleFraction: 1, pagePosition: 0.0);

                  return HighlightWidget(
                    item: value[index],
                    pageVisibility: pageVisibility,
                  );
                },
              );
            },
          );
        },
        animate: true,
      ),
    );
  }

  Widget _buildErrorConnection(FeaturedCube cube) {
    return cube.errorConnection.build<bool>((value) {
      return value
          ? ErrorConnection(tryAgain: () {
              cube.load();
            })
          : SizedBox.shrink();
    });
  }
}

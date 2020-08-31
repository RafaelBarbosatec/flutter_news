import 'package:FlutterNews/pages/featured/featured_cube.dart';
import 'package:FlutterNews/repository/notice_repository/model/notice.dart';
import 'package:FlutterNews/widgets/erro_conection.dart';
import 'package:FlutterNews/widgets/pageTransform/intro_page_item.dart';
import 'package:FlutterNews/widgets/pageTransform/page_transformer.dart';
import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';

class FeaturedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CubeBuilder<FeaturedCube>(builder: (context, cube) {
      return Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[_buildFeatured(cube), _getProgress(cube)],
          ),
          _buildErrorConnection(cube)
        ],
      );
    });
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
              return new PageView.builder(
                controller: new PageController(viewportFraction: 0.9),
                itemCount: value.length,
                itemBuilder: (context, index) {
                  final item = IntroNews.fromNotice(value[index]);
                  final pageVisibility =
                      visibilityResolver.resolvePageVisibility(index);
                  return new IntroNewsItem(
                    item: item,
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
          ? ErroConection(tryAgain: () {
              cube.load();
            })
          : SizedBox.shrink();
    });
  }
}

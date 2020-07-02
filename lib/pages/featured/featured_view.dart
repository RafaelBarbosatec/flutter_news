import 'package:FlutterNews/pages/featured/featured_bloc.dart';
import 'package:FlutterNews/pages/featured/featured_communication.dart';
import 'package:FlutterNews/pages/featured/featured_events.dart';
import 'package:FlutterNews/repository/notice_repository/model/notice.dart';
import 'package:FlutterNews/widgets/erro_conection.dart';
import 'package:FlutterNews/widgets/pageTransform/intro_page_item.dart';
import 'package:FlutterNews/widgets/pageTransform/page_transformer.dart';
import 'package:bsev/bsev.dart';
import 'package:flutter/material.dart';

class FeaturedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Bsev<FeaturedBloc, FeaturedCommunication>(
        builder: (context, communication) {
      return Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[
              _buildFeatured(communication),
              _getProgress(communication)
            ],
          ),
          _buildErrorConnection(communication)
        ],
      );
    });
  }

  Widget _getProgress(FeaturedCommunication streams) {
    return streams.progress.builder((value) {
      return value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox.shrink();
    });
  }

  _buildFeatured(FeaturedCommunication streams) {
    return Container(
      child: StreamListener<List<Notice>>(
        stream: streams.noticies,
        builder: (BuildContext context, snapshot) {
          List _list = snapshot.data;

          if (_list.isEmpty) return SizedBox.shrink();

          return PageTransformer(
            pageViewBuilder: (context, visibilityResolver) {
              return new PageView.builder(
                controller: new PageController(viewportFraction: 0.9),
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  final item = IntroNews.fromNotice(_list[index]);
                  final pageVisibility =
                      visibilityResolver.resolvePageVisibility(index);
                  return new IntroNewsItem(
                      item: item, pageVisibility: pageVisibility);
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildErrorConnection(FeaturedCommunication communication) {
    return communication.errorConnection.builder((value) {
      return value
          ? ErroConection(tryAgain: () {
              communication.dispatcher(LoadFeatured());
            })
          : SizedBox.shrink();
    });
  }
}

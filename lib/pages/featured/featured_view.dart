import 'package:FlutterNews/pages/featured/featured_bloc.dart';
import 'package:FlutterNews/pages/featured/featured_events.dart';
import 'package:FlutterNews/pages/featured/featured_streams.dart';
import 'package:FlutterNews/repository/notice_repository/model/notice.dart';
import 'package:FlutterNews/widgets/erro_conection.dart';
import 'package:FlutterNews/widgets/pageTransform/intro_page_item.dart';
import 'package:FlutterNews/widgets/pageTransform/page_transformer.dart';
import 'package:bsev/bsev.dart';
import 'package:flutter/material.dart';

class FeaturedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Bsev<FeaturedBloc, FeaturedStreams>(
        builder: (context, dispatcher, streams) {
      return Stack(
        children: <Widget>[
          new Stack(
            children: <Widget>[
              new Container(
                child: _buildFeatureds(streams),
              ),
              _getProgress(streams)
            ],
          ),
          _buildErrorConnection(streams, dispatcher)
        ],
      );
    });
  }

  Widget _getProgress(FeaturedStreams streams) {
    return StreamListener<bool>(
        stream: streams.progress.get,
        builder: (BuildContext context, snapshot) {
          if (snapshot.data) {
            return Center(
              child: new CircularProgressIndicator(),
            );
          } else {
            return new Container();
          }
        });
  }

  _buildFeatureds(FeaturedStreams streams) {
    return StreamListener<List<Notice>>(
        stream: streams.noticies.get,
        builder: (BuildContext context, snapshot) {
          List _list = snapshot.data;

          Widget fearured =
              PageTransformer(pageViewBuilder: (context, visibilityResolver) {
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
          });

          return AnimatedOpacity(
            opacity: _list.length > 0 ? 1 : 0,
            duration: Duration(milliseconds: 300),
            child: fearured,
          );
        });
  }

  Widget _buildErrorConnection(FeaturedStreams streams, dispatcher) {
    return StreamListener<bool>(
        stream: streams.errorConnection.get,
        builder: (BuildContext context, snapshot) {
          if (snapshot.data) {
            return ErroConection(tryAgain: () {
              dispatcher(LoadFeatured());
            });
          } else {
            return Container();
          }
        });
  }
}

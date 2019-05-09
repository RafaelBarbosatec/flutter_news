import 'package:FlutterNews/domain/notice/notice.dart';
import 'package:FlutterNews/pages/featured/featured_events.dart';
import 'package:FlutterNews/pages/featured/featured_bloc.dart';
import 'package:FlutterNews/pages/featured/featured_streams.dart';
import 'package:FlutterNews/widgets/erro_conection.dart';
import 'package:FlutterNews/widgets/pageTransform/intro_page_item.dart';
import 'package:FlutterNews/widgets/pageTransform/page_transformer.dart';
import 'package:bsev/bloc_view.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class FeaturedView extends BlocStatelessView<FeaturedBloc,FeaturedStreams,FeaturedEvents> {

  @override
  Widget buildView(BuildContext context) {

    return Stack(
      children: <Widget>[
        new Stack(
          children: <Widget>[
            new Container(
              child: _buildFeatureds(),
            ),
            _getProgress()
          ],
        ),
        _buildErrorConnection()
      ],
    );
  }

  Widget _getProgress() {

    return StreamBuilder(
        initialData: false,
        stream: streams.progress.get,
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
        }
        );
  }

  _buildFeatureds() {

    return StreamBuilder(
        initialData: List<Notice>(),
        stream: streams.noticies.get,
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          List _destaque = snapshot.data;
          var length = snapshot.hasData ? _destaque.length : 0;

          Widget fearured = PageTransformer(
              pageViewBuilder: (context, visibilityResolver) {
                return new PageView.builder(
                  controller: new PageController(viewportFraction: 0.9),
                  itemCount: length,
                  itemBuilder: (context, index) {
                    final item = IntroNews.fromNotice(_destaque[index]);
                    final pageVisibility =
                    visibilityResolver.resolvePageVisibility(index);
                    return new IntroNewsItem(
                        item: item, pageVisibility: pageVisibility);
                  },
                );
              });

          return AnimatedOpacity(
              opacity: length > 0 ? 1 : 0,
              duration: Duration(milliseconds: 300),
              child: fearured,
          );

        });
  }

  Widget _buildErrorConnection() {
    return StreamBuilder(
        stream: streams.errorConnection.get,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return ErroConection(tryAgain: () {
              dispatch(LoadFeatured());
            });
          } else {
            return Container();
          }
        });
  }

  @override
  void eventReceiver(FeaturedEvents event) {

  }

}

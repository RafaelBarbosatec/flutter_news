import 'package:FlutterNews/domain/notice/notice.dart';
import 'package:FlutterNews/injection/injector.dart';
import 'package:FlutterNews/pages/datail/detail.dart';
import 'package:FlutterNews/pages/featured/FeaturedEvents.dart';
import 'package:FlutterNews/pages/featured/featured_bloc.dart';
import 'package:FlutterNews/util/FadeInRoute.dart';
import 'package:FlutterNews/util/bloc_provider.dart';
import 'package:FlutterNews/widgets/erro_conection.dart';
import 'package:FlutterNews/widgets/pageTransform/intro_page_item.dart';
import 'package:FlutterNews/widgets/pageTransform/page_transformer.dart';
import 'package:flutter/material.dart';

class ContentFeaturedPage extends StatefulWidget {
  static Widget create() {
    return BlocProvider<FeaturedBloc>(
      bloc: FeaturedBloc(Injector().repository.getNoticeRepository()),
      child: ContentFeaturedPage(),
    );
  }

  final state = new _ContentFeaturedState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }
}

class _ContentFeaturedState extends State<ContentFeaturedPage>
    with TickerProviderStateMixin
    implements BlocView<FeaturedEvents> {
  AnimationController animationController;

  FeaturedBloc bloc;

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 350));
  }

  @override
  Widget build(BuildContext context) {
    if (bloc == null) {
      bloc = BlocProvider.of<FeaturedBloc>(context);
      bloc.registerView(this);
      bloc.dispatch(LoadFeatured());
    }

    return Stack(
      children: <Widget>[
        new GestureDetector(
          child: new Stack(
            children: <Widget>[
              new FadeTransition(
                opacity: animationController,
                child: new Container(
                  child: _buildFeatureds(bloc),
                ),
              ),
              _getProgress(bloc)
            ],
          ),
          onTap: () {
            bloc.clickShowDetail();
          },
        ),
        StreamBuilder(
            stream: bloc.streams.error,
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data) {
                return ErroConection(tryAgain: () {
                  bloc.dispatch(LoadFeatured());
                });
              } else {
                return Container();
              }
            })
      ],
    );
  }

  Widget _getProgress(FeaturedBloc bloc) {
    return StreamBuilder(
        initialData: false,
        stream: bloc.streams.progress,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  _buildFeatureds(FeaturedBloc bloc) {
    return StreamBuilder(
        initialData: List<Notice>(),
        stream: bloc.streams.noticies,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var _destaque = snapshot.data;

          return new PageTransformer(
              pageViewBuilder: (context, visibilityResolver) {
            return new PageView.builder(
              controller: new PageController(viewportFraction: 0.9),
              itemCount: _destaque.length,
              onPageChanged: (position) {
                bloc.streams.noticeSelected(_destaque[position]);
              },
              itemBuilder: (context, index) {
                final item = IntroNews.fromNotice(_destaque[index]);
                final pageVisibility =
                    visibilityResolver.resolvePageVisibility(index);
                return new IntroNewsItem(
                    item: item, pageVisibility: pageVisibility);
              },
            );
          });
        });
  }

  @override
  void eventViewReceiver(FeaturedEvents event) {
    if (event is InitAnimation) {
      animationController.forward();
    }

    if (event is OpenDetail) {
      Notice notice = event.data;
      Navigator.of(context).push(FadeInRoute(
          widget: DetailPage(
              notice.img,
              notice.title,
              notice.date,
              notice.description,
              notice.category,
              notice.link,
              notice.origin)));
    }
  }
}

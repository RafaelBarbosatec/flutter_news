import 'package:FlutterNews/pages/featured/featured_bloc.dart';
import 'package:FlutterNews/pages/featured/featured_streams.dart';
import 'package:FlutterNews/pages/home/home_bloc.dart';
import 'package:FlutterNews/pages/home/home_streams.dart';
import 'package:FlutterNews/pages/news/news_bloc.dart';
import 'package:FlutterNews/pages/news/news_streams.dart';
import 'package:FlutterNews/pages/search/search_result_bloc.dart';
import 'package:FlutterNews/pages/search/search_streams.dart';
import 'package:FlutterNews/repository/notice_repository/notice_repository.dart';
import 'package:FlutterNews/support/conection/api.dart';
import 'package:bsev/bsev.dart';
import 'package:bsev/flavors.dart';

initDependencies() {
  injectRepository();
  injectBlocs();
}

injectBlocs() {
  registerBloc<NewsBloc, NewsStreams>(
      (i) => NewsBloc(i.get()), () => NewsStreams());

  registerBloc<FeaturedBloc, FeaturedStreams>(
      (i) => FeaturedBloc(i.get()), () => FeaturedStreams());

  registerBloc<HomeBloc, HomeStreams>((i) => HomeBloc(), () => HomeStreams());

  registerBloc<SearchBloc, SearchStreams>(
      (i) => SearchBloc(i.get()), () => SearchStreams());
}

injectRepository() {
  registerSingletonDependency((i) {
    Api _api;
    switch (Flavors().getFlavor()) {
      case Flavor.PROD:
        _api = Api("http://104.131.18.84");
        break;
      case Flavor.HML:
        _api = Api("");
        break;
      case Flavor.DEBUG:
        _api = Api("");
        break;
    }
    return _api;
  });

  registerDependency<NoticeRepository>((i) => NoticeRepositoryImpl(i.get()));
}

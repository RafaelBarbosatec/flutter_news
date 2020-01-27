import 'package:FlutterNews/pages/featured/featured_bloc.dart';
import 'package:FlutterNews/pages/featured/featured_streams.dart';
import 'package:FlutterNews/pages/home/home_bloc.dart';
import 'package:FlutterNews/pages/home/home_streams.dart';
import 'package:FlutterNews/pages/news/news_bloc.dart';
import 'package:FlutterNews/pages/news/news_streams.dart';
import 'package:FlutterNews/pages/search/search_result_bloc.dart';
import 'package:FlutterNews/pages/search/search_streams.dart';
import 'package:bsev/bsev.dart';
import 'package:bsev/flavors.dart';

import '../../repository/notice_repository/notice_repository.dart';
import '../conection/api.dart';

initDependencies() {
  injectRepository();
  injectBlocs();
}

injectBlocs() {
  registerBlocFactory<NewsBloc, NewsStreams>(
      (i) => NewsBloc(i.getDependency()), () => NewsStreams());

  registerBlocFactory<FeaturedBloc, FeaturedStreams>(
      (i) => FeaturedBloc(i.getDependency()), () => FeaturedStreams());

  registerBlocFactory<HomeBloc, HomeStreams>(
      (i) => HomeBloc(), () => HomeStreams());

  registerBlocFactory<SearchBloc, SearchStreams>(
      (i) => SearchBloc(i.getDependency()), () => SearchStreams());
}

injectRepository() {
  registerSingleton((i) {
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

  registerDependency<NoticeRepository>(
      (i) => NoticeRepositoryImpl(i.getDependency()));
}

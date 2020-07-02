import 'package:FlutterNews/pages/featured/featured_bloc.dart';
import 'package:FlutterNews/pages/featured/featured_communication.dart';
import 'package:FlutterNews/pages/home/home_bloc.dart';
import 'package:FlutterNews/pages/home/home_communication.dart';
import 'package:FlutterNews/pages/news/news_bloc.dart';
import 'package:FlutterNews/pages/news/news_communication.dart';
import 'package:FlutterNews/pages/search/search_communication.dart';
import 'package:FlutterNews/pages/search/search_result_bloc.dart';
import 'package:FlutterNews/repository/notice_repository/notice_repository.dart';
import 'package:FlutterNews/support/conection/api.dart';
import 'package:bsev/bsev.dart';
import 'package:bsev/flavors.dart';

initDependencies() {
  injectRepository();
  injectBlocs();
}

injectBlocs() {
  registerBloc<NewsBloc, NewsCommunication>(
    (i) => NewsBloc(i.get()),
    () => NewsCommunication(),
  );

  registerBloc<FeaturedBloc, FeaturedCommunication>(
    (i) => FeaturedBloc(i.get()),
    () => FeaturedCommunication(),
  );

  registerBloc<HomeBloc, HomeCommunication>(
    (i) => HomeBloc(),
    () => HomeCommunication(),
  );

  registerBloc<SearchBloc, SearchCommunication>(
    (i) => SearchBloc(i.get()),
    () => SearchCommunication(),
  );
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

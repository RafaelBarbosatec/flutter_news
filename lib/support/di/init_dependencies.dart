import 'package:FlutterNews/pages/featured/featured_cube.dart';
import 'package:FlutterNews/pages/home/home_cube.dart';
import 'package:FlutterNews/pages/news/news_bloc.dart';
import 'package:FlutterNews/pages/search/search_result_bloc.dart';
import 'package:FlutterNews/repository/notice_repository/notice_repository.dart';
import 'package:FlutterNews/support/conection/api.dart';
import 'package:cubes/cubes.dart';

initDependencies() {
  injectRepository();
  injectCubes();
}

injectCubes() {
  registerCube((i) => NewsCube(i.get()));
  registerCube((i) => FeaturedCube(i.get()));
  registerCube((i) => HomeCube());
  registerCube((i) => SearchCube(i.get()));
}

injectRepository() {
  registerSingletonDependency((i) {
    return Api("http://104.131.18.84");
  });

  registerDependency<NoticeRepository>((i) => NoticeRepositoryImpl(i.get()));
}

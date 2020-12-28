import 'package:FlutterNews/pages/featured/featured_cube.dart';
import 'package:FlutterNews/pages/home/home_cube.dart';
import 'package:FlutterNews/pages/news/news_cube.dart';
import 'package:FlutterNews/pages/search/search_cube.dart';
import 'package:FlutterNews/repository/notice_repository/notice_repository.dart';
import 'package:FlutterNews/support/conection/api.dart';
import 'package:cubes/cubes.dart';

initDependencies() {
  injectRepository();
  injectCubes();
}

injectCubes() {
  Cubes.registerDependency((i) => NewsCube(i.getDependency()));
  Cubes.registerDependency((i) => FeaturedCube(i.getDependency()));
  Cubes.registerDependency((i) => HomeCube());
  Cubes.registerDependency((i) => SearchCube(i.getDependency()));
}

injectRepository() {
  Cubes.registerDependency(
    (i) => Api("http://104.131.18.84"),
    isSingleton: true,
  );

  Cubes.registerDependency<NoticeRepository>((i) => NoticeRepositoryImpl(i.getDependency()));
}

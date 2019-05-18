
import 'package:FlutterNews/pages/featured/featured_bloc.dart';
import 'package:FlutterNews/pages/featured/featured_streams.dart';
import 'package:FlutterNews/pages/home/home_bloc.dart';
import 'package:FlutterNews/pages/home/home_streams.dart';
import 'package:FlutterNews/pages/news/news_bloc.dart';
import 'package:FlutterNews/pages/news/news_streams.dart';
import 'package:bsev/bsev.dart';

injectBloc(Injector injector){

  injector.registerDependency((i)=>NewsBloc(i.getDependency()));
  injector.registerDependency((i)=>NewsStreams());

  injector.registerDependency((i)=>FeaturedBloc(i.getDependency()));
  injector.registerDependency((i)=>FeaturedStreams());

  injector.registerDependency((i)=>HomeBloc());
  injector.registerDependency((i)=>HomeStreams());

}

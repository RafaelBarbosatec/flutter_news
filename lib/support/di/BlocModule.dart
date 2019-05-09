
import 'package:FlutterNews/pages/featured/featured_bloc.dart';
import 'package:FlutterNews/pages/news/news_bloc.dart';
import 'package:simple_injector/module_injector.dart';

class BlocModule extends ModuleInjector{

  BlocModule(){
    add(NewsBloc, newsBlocCreate);
    add(FeaturedBloc, featuredBlocCreate);
  }

  NewsBloc newsBlocCreate(){
    return NewsBloc(
      inject()
    );
  }

  FeaturedBloc featuredBlocCreate(){
    return FeaturedBloc(
      inject()
    );
  }

}
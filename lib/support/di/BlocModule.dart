
import 'package:FlutterNews/pages/news/news_bloc.dart';
import 'package:simple_injector/module_injector.dart';

class BlocModule extends ModuleInjector{

  BlocModule(){
    add(NewsBloc, newsBlocCreate);
  }

  NewsBloc newsBlocCreate(){
    return NewsBloc(
      inject()
    );
  }

}
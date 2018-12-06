
import 'dart:async';

import 'package:FlutterNews/util/bloc_provider.dart';
import 'package:FlutterNews/pages/featured/content_featured.dart';
import 'package:FlutterNews/pages/news/content_news.dart';
import 'package:flutter/material.dart';

class HomeBloc implements BlocBase{

  StreamController<int> tabPositionController = StreamController<int>();
  StreamController<Widget> screenController = StreamController<Widget>();

  Function(int) get selectTab => tabPositionController.sink.add;
  Stream<int> get tabPosition => tabPositionController.stream;

  Function(Widget) get addWidget => screenController.sink.add;
  Stream<Widget> get widgetSelected => screenController.stream;

  HomeBloc(){
    selectTab(0);
    addWidget(ContentFeaturedPage());

    tabPosition.listen((position){

      switch(position){
        case 0: addWidget(ContentFeaturedPage());break;
        case 1: addWidget(ContentNewsPage());break;
        default:
          {
            addWidget(Container());
//            content = new Info(new AnimationController(
//                vsync: this,
//                duration: new Duration(milliseconds: 500)
//            ));
//            (content as Info).animationController.forward();
          }
      }

    });
  }

  @override
  void dispose() {
    tabPositionController.close();
    screenController.close();
  }

}
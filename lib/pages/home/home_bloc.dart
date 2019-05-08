
import 'dart:async';

import 'package:FlutterNews/pages/home/home_streams.dart';
import 'package:FlutterNews/pages/info/info.dart';
import 'package:FlutterNews/util/bloc_provider.dart';
import 'package:FlutterNews/pages/featured/content_featured.dart';
import 'package:FlutterNews/pages/news/news_view.dart';
import 'package:flutter/material.dart';

class HomeBloc extends BlocBase<HomeStreams,EventsBase>{

  HomeBloc(){
    streams = HomeStreams();
  }

  @override
  void eventReceiver(EventsBase event) {
    // TODO: implement eventReceiver
  }

}
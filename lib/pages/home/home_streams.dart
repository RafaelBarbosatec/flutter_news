import 'dart:async';

import 'package:FlutterNews/util/bloc_provider.dart';
import 'package:flutter/widgets.dart';

class HomeStreams implements StreamsBase{

  StreamController<int> _tabPositionController = StreamController<int>();
  Function(int) get selectTab => _tabPositionController.sink.add;
  Stream<int> get tabPosition => _tabPositionController.stream;

  StreamController<Widget> _screenController = StreamController<Widget>();
  Function(Widget) get addWidget => _screenController.sink.add;
  Stream<Widget> get widgetSelected => _screenController.stream;

  @override
  void dispose() {
    _tabPositionController.close();
    _screenController.close();
  }


}
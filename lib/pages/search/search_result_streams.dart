import 'dart:async';

import 'package:FlutterNews/domain/notice/notice.dart';
import 'package:FlutterNews/util/bloc_provider.dart';

class SearchResultStreams implements StreamsBase{

  StreamController<bool> _progressController = StreamController<bool>();
  Function(bool) get visibleProgress => _progressController.sink.add;
  Stream<bool> get progress => _progressController.stream;

  StreamController<bool> _errorController = StreamController<bool>();
  Function(bool) get visibleError => _errorController.sink.add;
  Stream<bool> get error => _errorController.stream;

  StreamController<bool> _emptyController = StreamController<bool>();
  Function(bool) get visibleEmpty => _emptyController.sink.add;
  Stream<bool> get empty => _emptyController.stream;

  StreamController<bool> _animController = StreamController<bool>();
  Function(bool) get changeAnim => _animController.sink.add;
  Stream<bool> get anim => _animController.stream;

  StreamController<List<Notice>> _noticeController = StreamController<List<Notice>>();
  Function(List<Notice>) get addnoticies => _noticeController.sink.add;
  Stream<List<Notice>> get noticies => _noticeController.stream;

  @override
  void dispose() {
    _progressController.close();
    _errorController.close();
    _emptyController.close();
    _animController.close();
    _noticeController.close();
  }

}
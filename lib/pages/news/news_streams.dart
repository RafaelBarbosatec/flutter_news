import 'dart:async';

import 'package:FlutterNews/domain/notice/notice.dart';
import 'package:bsev/bsev.dart';

class NewsStreams implements StreamsBase{

  StreamController<bool> _progressController = StreamController<bool>();
  Function(bool) get visibleProgress => _progressController.sink.add;
  Stream<bool> get progress => _progressController.stream;

  StreamController<bool> _errorController = StreamController<bool>();
  Function(bool) get visibleError => _errorController.sink.add;
  Stream<bool> get error => _errorController.stream;

  StreamController<bool> _animController = StreamController<bool>();
  Function(bool) get changeAnim => _animController.sink.add;
  Stream<bool> get anim => _animController.stream;

  BehaviorSubjectCreate<List<Notice>> noticies = BehaviorSubjectCreate();
//  StreamController<List<Notice>> _noticeController = StreamController<List<Notice>>();
//  Function(List<Notice>) get addnoticies => _noticeController.sink.add;
//  Stream<List<Notice>> get noticies => _noticeController.stream;

  StreamController<int> _categoryController = StreamController<int>();
  Function(int) get setCategoryPosition => _categoryController.sink.add;
  Stream<int> get categoryPosition => _categoryController.stream;

  BehaviorSubjectCreate<List<String>> categoriesName = BehaviorSubjectCreate();

  @override
  void dispose() {
    _progressController.close();
    _errorController.close();
    _animController.close();
    noticies.close();
    _categoryController.close();
    categoriesName.close();
  }

}
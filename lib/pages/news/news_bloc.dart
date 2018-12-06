
import 'dart:async';

import 'package:FlutterNews/domain/notice/notice.dart';
import 'package:FlutterNews/domain/notice/notice_repository.dart';
import 'package:FlutterNews/injection/injector.dart';
import 'package:FlutterNews/util/bloc_provider.dart';

class NewsBloc implements BlocBase{

  NoticeRepository repository;

  StreamController<bool> _progressController = StreamController<bool>();
  StreamController<bool> _errorController = StreamController<bool>();
  StreamController<bool> _animController = StreamController<bool>();
  StreamController<List<Notice>> _noticeController = StreamController<List<Notice>>();
  StreamController<int> _categoryController = StreamController<int>();

  Function(List<Notice>) get addnoticies => _noticeController.sink.add;
  Function(bool) get visibleError => _errorController.sink.add;
  Function(bool) get changeAnim => _animController.sink.add;
  Function(bool) get visibleProgress => _progressController.sink.add;
  Function(int) get setCategoryPosition => _categoryController.sink.add;

  Stream<bool> get error => _errorController.stream;
  Stream<bool> get progress => _progressController.stream;
  Stream<bool> get anim => _animController.stream;
  Stream<List<Notice>> get noticies => _noticeController.stream;
  Stream<int> get categoryPosition => _categoryController.stream;

  int _page = 0;
  int _currentCategory = 0;
  List<String> _categories = List();

  NewsBloc(){

    repository = new Injector().repository.getNoticeRepository();

    _categories.add("geral");
    _categories.add("sports");
    _categories.add("technology");
    _categories.add("entertainment");
    _categories.add("health");
    _categories.add("business");

    categoryPosition.listen((category){
      _currentCategory = category;
      load(false);
    });

  }

  load(bool isMore){

    if(isMore){
      _page++;
    }else{
      _page = 0;
    }

    String category = _categories[_currentCategory];

    repository.loadNews(category, _page)
        .then((news) => showNews(news))
        .catchError((onError) => showImplError(onError));
  }

  @override
  void dispose() {
    _progressController.close();
    _errorController.close();
    _animController.close();
    _noticeController.close();
    _categoryController.close();
  }

  showNews(List<Notice> news) {}

  showImplError(onError) {}

}
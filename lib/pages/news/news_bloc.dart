
import 'dart:async';

import 'package:FlutterNews/conection/api.dart';
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
  List<Notice> _newsInner = List();
  bool _carregando = false;

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
      cleanList();
      load(false);
    });

  }

  load(bool isMore){

    if(!_carregando){

      if(isMore){
        _page++;
      }else{
        _page = 0;
      }

      visibleError(false);
      
      if(isMore || _newsInner.length == 0){
        visibleProgress(true);
      }

      String category = _categories[_currentCategory];

      _carregando = true;

      repository.loadNews(category, _page)
          .then((news) => showNews(news,isMore))
          .catchError((onError) => showImplError(onError));

    }

  }

  @override
  void dispose() {
    _progressController.close();
    _errorController.close();
    _animController.close();
    _noticeController.close();
    _categoryController.close();
  }

  showNews(List<Notice> news,bool isMore) {

    visibleProgress(false);
    if(isMore){
      _newsInner.addAll(news);
      addnoticies(_newsInner);
    }else{
      _newsInner = news;
      addnoticies(news);
      changeAnim(true);
    }

    _carregando = false;

  }

  showImplError(onError) {
    print(onError);
    if(onError is FetchDataException){
      print("codigo: ${onError.code()}");
    }
    visibleError(true);
    visibleProgress(false);

    _carregando = false;
  }

  void cleanList() {
    _newsInner = List();
    addnoticies(_newsInner);
  }

}

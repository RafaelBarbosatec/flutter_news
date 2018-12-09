

import 'dart:async';

import 'package:FlutterNews/conection/api.dart';
import 'package:FlutterNews/domain/notice/notice.dart';
import 'package:FlutterNews/domain/notice/notice_repository.dart';
import 'package:FlutterNews/injection/injector.dart';
import 'package:FlutterNews/util/bloc_provider.dart';

class SearchResultBloc implements BlocBase{

  NoticeRepository repository;

  StreamController<bool> _progressController = StreamController<bool>();
  StreamController<bool> _errorController = StreamController<bool>();
  StreamController<bool> _emptyController = StreamController<bool>();
  StreamController<bool> _animController = StreamController<bool>();
  StreamController<List<Notice>> _noticeController = StreamController<List<Notice>>();

  Function(List<Notice>) get addnoticies => _noticeController.sink.add;
  Function(bool) get visibleError => _errorController.sink.add;
  Function(bool) get changeAnim => _animController.sink.add;
  Function(bool) get visibleProgress => _progressController.sink.add;
  Function(bool) get visibleEmpty => _emptyController.sink.add;

  Stream<bool> get error => _errorController.stream;
  Stream<bool> get progress => _progressController.stream;
  Stream<bool> get anim => _animController.stream;
  Stream<List<Notice>> get noticies => _noticeController.stream;
  Stream<bool> get empty => _emptyController.stream;

  SearchResultBloc(){
    repository = new Injector().repository.getNoticeRepository();
  }

  load(String query){

    visibleProgress(true);
    visibleError(false);

    repository.loadSearch(query)
        .then((news) => showNews(news))
        .catchError((onError) => showImplError(onError));

  }

  showNews(List<Notice> news) {

    visibleProgress(false);

    if(news.length > 0) {
      addnoticies(news);
      changeAnim(true);
      visibleEmpty(false);
    }else{
      visibleEmpty(true);
    }
  }

  showImplError(onError) {

    print(onError);
    if(onError is FetchDataException){
      print("codigo: ${onError.code()}");
    }
    visibleError(true);
    visibleProgress(false);

  }

  @override
  void dispose() {
    _progressController.close();
    _errorController.close();
    _animController.close();
    _noticeController.close();
    _emptyController.close();
  }

}
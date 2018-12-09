import 'dart:async';

import 'package:FlutterNews/conection/api.dart';
import 'package:FlutterNews/domain/notice/notice.dart';
import 'package:FlutterNews/domain/notice/notice_repository.dart';
import 'package:FlutterNews/injection/injector.dart';
import 'package:FlutterNews/util/bloc_provider.dart';

class FeaturedBloc implements BlocBase{

  NoticeRepository repository;

  StreamController<bool> _progressController = StreamController<bool>();
  StreamController<bool> _errorController = StreamController<bool>();
  StreamController<bool> _animController = StreamController<bool>();
  StreamController<List<Notice>> _noticeController = StreamController<List<Notice>>();
  StreamController<Notice> _showDetailController = StreamController<Notice>();
  StreamController<Notice> _noticeSelectedController = StreamController<Notice>();

  Function(List<Notice>) get addnoticies => _noticeController.sink.add;
  Function(bool) get visibleError => _errorController.sink.add;
  Function(bool) get changeAnim => _animController.sink.add;
  Function(bool) get visibleProgress => _progressController.sink.add;
  Function(Notice) get showDetail => _showDetailController.sink.add;
  Function(Notice) get noticeSelected => _noticeSelectedController.sink.add;


  Stream<bool> get error => _errorController.stream;
  Stream<bool> get progress => _progressController.stream;
  Stream<bool> get anim => _animController.stream;
  Stream<List<Notice>> get noticies => _noticeController.stream;
  Stream<Notice> get detail => _showDetailController.stream;

  Notice nSelected;

  FeaturedBloc(){
    repository = new Injector().repository.getNoticeRepository();

    _noticeSelectedController.stream.listen((notice){
      nSelected = notice;
      print(notice.title);
    });
  }

  load(){

    visibleProgress(true);
    visibleError(false);

    repository.loadNewsRecent()
        .then((news) => showNews(news))
        .catchError((onError) => showImplError(onError));

  }

  clickShowDetail(){
    if(nSelected != null){
      showDetail(nSelected);
    }
  }

  showNews(List<Notice> news) {
    nSelected = news[0];
    visibleProgress(false);
    addnoticies(news);
    changeAnim(true);
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
    _noticeController.close();
    _animController.close();
    _showDetailController.close();
    _noticeSelectedController.close();
  }

}
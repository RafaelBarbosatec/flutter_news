
import 'package:FlutterNews/conection/api.dart';
import 'package:FlutterNews/domain/notice/notice.dart';
import 'package:FlutterNews/domain/notice/notice_repository.dart';
import 'package:FlutterNews/pages/news/news_events.dart';
import 'package:FlutterNews/pages/news/news_streams.dart';
import 'package:FlutterNews/util/bloc_provider.dart';

class NewsBloc extends BlocBase<NewsStreams,NewsEvents>{

  final NoticeRepository repository;

  int _page = 0;
  int _currentCategory = 0;
  List<String> _categories = List();
  List<Notice> _newsInner = List();
  bool _carregando = false;

  NewsBloc(this.repository){

    streams = NewsStreams();

    _categories.add("geral");
    _categories.add("sports");
    _categories.add("technology");
    _categories.add("entertainment");
    _categories.add("health");
    _categories.add("business");

    streams.categoryPosition.listen((category){
      _currentCategory = category;
      cleanList();
      _load(false);
    });

  }

  @override
  void eventReceiver(event) {
    if(event is LoadNews){
      _load(event.data);
    }
  }

  _load(bool isMore){

    if(!_carregando){

      if(isMore){
        _page++;
      }else{
        _page = 0;
      }

      streams.visibleError(false);
      
      if(isMore || _newsInner.length == 0){
        streams.visibleProgress(true);
      }

      String category = _categories[_currentCategory];

      _carregando = true;

      repository.loadNews(category, _page)
          .then((news) => _showNews(news,isMore))
          .catchError(_showImplError);

    }

  }

  _showNews(List<Notice> news,bool isMore) {

    streams.visibleProgress(false);
    if(isMore){
      _newsInner.addAll(news);
      streams.addnoticies(_newsInner);
    }else{
      _newsInner = news;
      streams.addnoticies(news);
      dispathToView(InitAnimation());
    }
    _carregando = false;

  }

  _showImplError(onError) {
    print(onError);
    if(onError is FetchDataException){
      print("codigo: ${onError.code()}");
    }
    streams.visibleError(true);
    streams.visibleProgress(false);
    _carregando = false;
  }

  void cleanList() {
    _newsInner = List();
    streams.addnoticies(_newsInner);
  }

}


import 'package:FlutterNews/conection/api.dart';
import 'package:FlutterNews/domain/notice/notice.dart';
import 'package:FlutterNews/domain/notice/notice_repository.dart';
import 'package:FlutterNews/injection/injector.dart';
import 'package:FlutterNews/pages/search/search_events.dart';
import 'package:FlutterNews/pages/search/search_result_streams.dart';
import 'package:FlutterNews/util/bloc_provider.dart';

class SearchResultBloc extends BlocBase<SearchResultStreams,SearchEvents>{

  final NoticeRepository repository;

  SearchResultBloc(this.repository){
    streams = SearchResultStreams();
  }

  @override
  void eventReceiver(SearchEvents event) {
    if(event is LoadSearch){
      _load(event.data);
    }
  }

  _load(String query){

    streams.visibleProgress(true);
    streams.visibleError(false);

    repository.loadSearch(query)
        .then((news) => _showNews(news))
        .catchError(_showImplError);

  }

  _showNews(List<Notice> news) {

    streams.visibleProgress(false);
    if(news.length > 0) {
      streams.addnoticies(news);
      dispathToView(InitAnimation());
      streams.visibleEmpty(false);
    }else{
      streams.visibleEmpty(true);
    }
  }

  _showImplError(onError) {

    print(onError);
    if(onError is FetchDataException){
      print("codigo: ${onError.code()}");
    }
    streams.visibleError(true);
    streams.visibleProgress(false);

  }

}
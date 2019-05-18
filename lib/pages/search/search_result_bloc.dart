
import 'package:FlutterNews/pages/search/search_events.dart';
import 'package:FlutterNews/pages/search/search_streams.dart';
import 'package:FlutterNews/repository/notice_repository/model/notice.dart';
import 'package:FlutterNews/repository/notice_repository/notice_repository.dart';
import 'package:FlutterNews/support/conection/api.dart';
import 'package:bsev/bsev.dart';

class SearchBloc extends BlocBase<SearchStreams,SearchEvents>{

  final NoticeRepository repository;

  SearchBloc(this.repository);

  @override
  void initView() {
  }

  @override
  void eventReceiver(SearchEvents event) {
    if(event is LoadSearch){
      _load(event.data);
    }
  }

  _load(String query){

    if(streams.noticies.value != null){
      return;
    }

    streams.progress.set(true);
    streams.error.set(false);

    repository.loadSearch(query)
        .then((news) => _showNews(news))
        .catchError(_showImplError);

  }

  _showNews(List<Notice> news) {

    streams..progress.set(false);
    if(news.length > 0) {
      streams.noticies.set(news);
      dispatchView(InitAnimation());
      streams.empty.set(false);
    }else{
      streams.empty.set(true);
    }
  }

  _showImplError(onError) {

    print(onError);
    if(onError is FetchDataException){
      print("codigo: ${onError.code()}");
    }
    streams.error.set(true);
    streams.progress.set(false);

  }

}
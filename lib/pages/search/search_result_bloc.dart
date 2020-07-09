import 'package:FlutterNews/pages/search/search_communication.dart';
import 'package:FlutterNews/pages/search/search_events.dart';
import 'package:FlutterNews/repository/notice_repository/model/notice.dart';
import 'package:FlutterNews/repository/notice_repository/notice_repository.dart';
import 'package:FlutterNews/support/conection/api.dart';
import 'package:bsev/bsev.dart';

class SearchBloc extends Bloc<SearchCommunication> {
  final NoticeRepository repository;

  SearchBloc(this.repository);

  @override
  void init() {
    _load(data);
  }

  @override
  void eventReceiver(EventsBase event) {
    if (event is LoadSearch) {
      _load(event.query);
    }
  }

  _load(String query) {
    communication.progress.set(true);
    communication.error.set(false);

    repository
        .loadSearch(query)
        .then((news) => _showNews(news))
        .catchError(_showImplError);
  }

  _showNews(List<Notice> news) {
    communication..progress.set(false);
    if (news.length > 0) {
      communication.noticies.set(news);
      communication.empty.set(false);
    } else {
      communication.empty.set(true);
    }
  }

  _showImplError(onError) {
    print(onError);
    if (onError is FetchDataException) {
      print("codigo: ${onError.code()}");
    }
    communication.error.set(true);
    communication.progress.set(false);
  }
}

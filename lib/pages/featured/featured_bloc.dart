import 'package:FlutterNews/pages/featured/featured_communication.dart';
import 'package:FlutterNews/pages/featured/featured_events.dart';
import 'package:FlutterNews/repository/notice_repository/model/notice.dart';
import 'package:FlutterNews/repository/notice_repository/notice_repository.dart';
import 'package:FlutterNews/support/conection/api.dart';
import 'package:bsev/bsev.dart';

class FeaturedBloc extends Bloc<FeaturedCommunication> {
  final NoticeRepository repository;

  FeaturedBloc(this.repository);

  @override
  void init() {
    _load();
  }

  @override
  void eventReceiver(EventsBase event) {
    if (event is LoadFeatured) {
      _load();
    }
  }

  _load() {
    communication.progress.set(true);
    communication.errorConnection.set(false);

    repository
        .loadNewsRecent()
        .then((news) => _showNews(news))
        .catchError(_showImplError);
  }

  _showNews(List<Notice> news) {
    communication.progress.set(false);
    communication.noticies.set(news);
  }

  _showImplError(onError) {
    if (onError is FetchDataException) {
      print("codigo: ${onError.code()}");
    }
    communication.errorConnection.set(true);
    communication.progress.set(false);
  }
}

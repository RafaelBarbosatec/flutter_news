import 'package:FlutterNews/pages/featured/featured_events.dart';
import 'package:FlutterNews/pages/featured/featured_streams.dart';
import 'package:FlutterNews/repository/notice_repository/model/notice.dart';
import 'package:FlutterNews/repository/notice_repository/notice_repository.dart';
import 'package:FlutterNews/support/conection/api.dart';
import 'package:bsev/bsev.dart';

class FeaturedBloc extends BlocBase<FeaturedStreams> {
  final NoticeRepository repository;

  FeaturedBloc(this.repository);

  @override
  void initView() {
    _load();
  }

  @override
  void eventReceiver(EventsBase event) {
    if (event is LoadFeatured) {
      _load();
    }
  }

  _load() {
    streams.progress.set(true);
    streams.errorConnection.set(false);

    repository
        .loadNewsRecent()
        .then((news) => _showNews(news))
        .catchError(_showImplError);
  }

  _showNews(List<Notice> news) {
    streams.progress.set(false);
    streams.noticies.set(news);
  }

  _showImplError(onError) {
    if (onError is FetchDataException) {
      print("codigo: ${onError.code()}");
    }
    streams.errorConnection.set(true);
    streams.progress.set(false);
  }
}

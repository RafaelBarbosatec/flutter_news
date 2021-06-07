import 'package:cubes/cubes.dart';
import 'package:flutter_news/repository/notice_repository/model/notice.dart';
import 'package:flutter_news/repository/notice_repository/notice_repository.dart';

class FeaturedCube extends Cube {
  FeaturedCube(this.repository);

  final NoticeRepository repository;

  final progress = false.obsValue;
  final errorConnection = false.obsValue;
  final noticeList = <Notice>[].obsValue;

  @override
  void onReady(Object? arguments) {
    load();
    super.onReady(arguments);
  }

  void load() {
    progress.update(true);
    errorConnection.update(false);

    repository
        .loadNewsRecent()
        .then((news) => _showNews(news))
        .catchError(_showImplError);
  }

  void _showNews(List<Notice> news) {
    progress.update(false);
    noticeList.addAll(news);
  }

  void _showImplError(onError) {
    errorConnection.update(true);
    progress.update(false);
  }
}

import 'package:cubes/cubes.dart';
import 'package:flutter_news/repository/notice_repository/model/notice.dart';
import 'package:flutter_news/repository/notice_repository/notice_repository.dart';
import 'package:flutter_news/support/conection/api.dart';

class SearchCube extends Cube {
  final NoticeRepository repository;

  SearchCube(this.repository);

  final progress = ObservableValue<bool>(value: false);
  final error = ObservableValue<bool>(value: false);
  final empty = ObservableValue<bool>(value: false);
  final noticeList = ObservableList<Notice>(value: []);

  @override
  void onReady(Object? arguments) {
    search(arguments);
    super.onReady(arguments);
  }

  void search(Object? query) {
    progress.update(true);
    error.update(false);

    if (query != null && query is String) {
      repository
          .loadSearch(query)
          .then((news) => _showNews(news))
          .catchError(_showImplError);
    }
  }

  _showNews(List<Notice> news) {
    progress.update(false);
    if (news.length > 0) {
      noticeList.addAll(news);
      empty.update(false);
    } else {
      empty.update(true);
    }
  }

  _showImplError(onError) {
    print(onError);
    if (onError is FetchDataException) {
      print("codigo: ${onError.code()}");
    }
    error.update(true);
    progress.update(false);
  }
}

import 'package:flutter_news/repository/notice_repository/model/notice.dart';
import 'package:flutter_news/support/conection/api.dart';

abstract class NoticeRepository {
  Future<List<Notice>> loadNews(String category, int page);
  Future<List<Notice>> loadNewsRecent();
  Future<List<Notice>> loadSearch(String query);
}

class NoticeRepositoryImpl implements NoticeRepository {
  final Api _api;

  NoticeRepositoryImpl(this._api);

  Future<List<Notice>> loadNews(String category, int page) async {
    final Map result = await _api.get("/notice/news/$category/$page");
    if (result['op'] == false) return [];
    return result['data']['news']
        .map<Notice>((notice) => new Notice.fromMap(notice))
        .toList();
  }

  Future<List<Notice>> loadNewsRecent() async {
    final Map result = await _api.get("/notice/news/recent");
    if (result['op'] == false) return [];
    return result['data']
        .map<Notice>((notice) => new Notice.fromMap(notice))
        .toList();
  }

  Future<List<Notice>> loadSearch(String query) async {
    final Map result = await _api.get("/notice/search/$query");

    if (result['op'] == false) return [];
    return result['data']
        .map<Notice>((notice) => new Notice.fromMap(notice))
        .toList();
  }
}

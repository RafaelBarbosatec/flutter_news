
import 'package:FlutterNews/conection/api.dart';
import 'package:FlutterNews/domain/notice/notice.dart';

abstract class NoticeRepository{
  Future<List<Notice>> loadNews(String category, int page);
  Future<List<Notice>> loadNewsRecent();
  Future<List<Notice>> loadSearch(String query);
}
class NoticeRepositoryImpl implements NoticeRepository{

  final Api _api;

  NoticeRepositoryImpl(this._api);

  Future<List<Notice>> loadNews(String category, int page) async {
    final Map result = await _api.get("/notice/news/$category/$page");
    return result['data']['news'].map<Notice>( (notice) => new Notice.fromMap(notice)).toList();
  }

  Future<List<Notice>> loadNewsRecent() async {
    final Map result = await _api.get("/notice/news/recent");
    return result['data'].map<Notice>( (notice) => new Notice.fromMap(notice)).toList();
  }

  Future<List<Notice>> loadSearch(String query) async {

    final Map result = await _api.get("/notice/search/$query");

    if(result['op']){
      return result['data'].map<Notice>( (notice) => new Notice.fromMap(notice)).toList();
    }else{
      return List();
    }
  }

}


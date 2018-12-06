

import 'package:FlutterNews/conectionv2/api.dart';
import 'package:FlutterNews/domain/notice/notice.dart';

class NoticeRepository{

  final api = Api("http://104.131.18.84");
  final bool prod;

  NoticeRepository(this.prod);

  Future<List<Notice>> loadNews(String category, String page) async {

    return prod ? _server(category,page) : _local();

  }

  Future<List<Notice>> _server(String category, String page) async{

    final List news = await api.get("/notice/news/$category/$page");

    return news.map( (notice) => new Notice.fromMap(notice)).toList();

  }

  List<Notice> _local() {
    return new List();
  }

}


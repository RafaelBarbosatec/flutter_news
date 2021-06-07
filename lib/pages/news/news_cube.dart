import 'package:cubes/cubes.dart';
import 'package:flutter_news/repository/notice_repository/model/notice.dart';
import 'package:flutter_news/repository/notice_repository/notice_repository.dart';

class NewsCube extends Cube {
  final NoticeRepository repository;

  int _page = 0;
  int _currentCategory = 0;
  bool lastPage = false;
  List<String> _categories = [
    'geral',
    'sports',
    'technology',
    'entertainment',
    'health',
    'business'
  ];

  NewsCube(this.repository) {
    categoriesName.add(Cubes.getString("cat_geral"));
    categoriesName.add(Cubes.getString("cat_esporte"));
    categoriesName.add(Cubes.getString("cat_tecnologia"));
    categoriesName.add(Cubes.getString("cat_entretenimento"));
    categoriesName.add(Cubes.getString("cat_saude"));
    categoriesName.add(Cubes.getString("cat_negocios"));
  }

  final errorConnection = false.obsValue;
  final progress = false.obsValue;
  final noticeList = <Notice>[].obsValue;
  final categoriesName = <String>[].obsValue;

  @override
  void onReady(Object? arguments) {
    load(false);
    super.onReady(arguments);
  }

  void categoryClick(int position) {
    _currentCategory = position;
    load(false);
  }

  void load(bool isMore) {
    if (progress.value) return;

    if (isMore) {
      _page++;
    } else {
      lastPage = false;
      noticeList.clear();
      _page = 0;
    }

    errorConnection.update(false);

    progress.update(true);

    String category = _categories[_currentCategory];

    repository
        .loadNews(category, _page)
        .then((news) => _showNews(news, isMore))
        .catchError(_showImplError);
  }

  _showNews(List<Notice> news, bool isMore) {
    progress.update(false);

    if (isMore) {
      lastPage = news.isEmpty;
      noticeList.addAll(news);
    } else {
      noticeList.update(news);
    }
  }

  _showImplError(onError) {
    errorConnection.update(true);
    progress.update(false);
  }
}

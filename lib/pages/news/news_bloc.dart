import 'package:FlutterNews/repository/notice_repository/model/notice.dart';
import 'package:FlutterNews/repository/notice_repository/notice_repository.dart';
import 'package:FlutterNews/support/conection/api.dart';
import 'package:cubes/cubes.dart';

class NewsCube extends Cube {
  final NoticeRepository repository;

  int _page = 0;
  int _currentCategory = 0;
  List<String> _categories = [
    'geral',
    'sports',
    'technology',
    'entertainment',
    'health',
    'business'
  ];

  NewsCube(this.repository) {
    categoriesName.add(getString("cat_geral"));
    categoriesName.add(getString("cat_esporte"));
    categoriesName.add(getString("cat_tecnologia"));
    categoriesName.add(getString("cat_entretenimento"));
    categoriesName.add(getString("cat_saude"));
    categoriesName.add(getString("cat_negocios"));
  }

  final errorConection = ObservableValue<bool>(value: false);
  final progress = ObservableValue<bool>(value: false);
  final noticies = ObservableList<Notice>(value: []);
  final categoriesName = ObservableList<String>(value: []);

  @override
  void ready() {
    load(false);
    super.ready();
  }

  void categoryClick(int position) {
    _currentCategory = position;
    load(false);
  }

  void load(bool isMore) {
    if (!progress.value) {
      if (isMore) {
        _page++;
      } else {
        noticies.value = [];
        noticies.notify();
        _page = 0;
      }

      errorConection.value = false;

      progress.value = true;

      String category = _categories[_currentCategory];

      repository
          .loadNews(category, _page)
          .then((news) => _showNews(news, isMore))
          .catchError(_showImplError);
    }
  }

  _showNews(List<Notice> news, bool isMore) {
    progress.value = false;

    if (isMore) {
      noticies.addAll(news);
    } else {
      noticies.value = news;
    }
  }

  _showImplError(onError) {
    if (onError is FetchDataException) {
      print("codigo: ${onError.code()}");
    }
    errorConection.value = true;
    progress.value = false;
  }
}

//Classe que controla os repositorios disponíveis no projeto
import 'package:FlutterNews/conection/api.dart';
import 'package:FlutterNews/domain/notice/notice_repository.dart';

abstract class Repository{
  NoticeRepository getNoticeRepository();
}

class RepositoryImpl implements Repository {

  final Api _api;

  RepositoryImpl(this._api);

  NoticeRepository getNoticeRepository(){
    return NoticeRepositoryImpl(_api);
  }

}
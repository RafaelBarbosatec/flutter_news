//Classe que controla os repositorios disponíveis no projeto
import 'package:FlutterNews/conection/api.dart';
import 'package:FlutterNews/domain/notice/notice_repository.dart';

abstract class Repository{
  NoticeRepository getNoticeRepository();
}

class RepositoryImpl implements Repository {

  final bool _prod;

  Api _api = Api("http://104.131.18.84");

  RepositoryImpl(this._prod);

  NoticeRepository getNoticeRepository(){
    return NoticeRepositoryImpl(_prod,_api);
  }

}
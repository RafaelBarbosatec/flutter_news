//Classe que controla os repositorios disponíveis no projeto
import 'package:FlutterNews/domain/notice/notice_repository.dart';

class Repository {

  final bool _prod;

  Repository(this._prod);

  NoticeRepository getNoticeRepository(){
    return new NoticeRepository(_prod);
  }

}
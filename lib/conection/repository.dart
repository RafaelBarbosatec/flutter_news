//Classe que controla os repositorios disponíveis no projeto
import 'package:FlutterNews/domain/notice/notice_repository.dart';

abstract class Repository{
  NoticeRepository getNoticeRepository();
}
class RepositoryImpl implements Repository {

  final bool _prod;

  RepositoryImpl(this._prod);

  NoticeRepository getNoticeRepository(){
    return NoticeRepositoryImpl(_prod);
  }

}
import 'package:FlutterNews/conection/api.dart';
import 'package:FlutterNews/repository/notice_repository/notice_repository.dart';
import 'package:simple_injector/module_injector.dart';
import 'package:simple_injector/simple_injector.dart';

class RepositoryModule extends ModuleInjector{

  RepositoryModule(){
    add(NoticeRepository, noticeRepositoryCreate);
    add(Api, apiCreate, isSingleton: true);
  }

  Api apiCreate(){
    Api _api;
    switch(flavor) {
      case Flavor.PROD: _api = Api("http://104.131.18.84");break;
      case Flavor.HOMOLOG: _api = Api("");break;
      case Flavor.DEBUG: _api = Api("");break;
    }
    return _api;
  }

  NoticeRepository noticeRepositoryCreate(){
    return NoticeRepositoryImpl(
      inject()
    );
  }

}
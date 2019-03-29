import 'package:FlutterNews/conection/api.dart';
import 'package:FlutterNews/conection/repository.dart';

enum Flavor {
  HOMOLOG,
  PRO
}

/// Simple DI
class Injector {
  static final Injector _singleton = new Injector._internal();
  static Flavor _flavor;
  Api _api;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  Repository get repository {
    Api api = getApi();
    return RepositoryImpl(api);
  }

  Api getApi() {

    if(_api == null){
      switch(_flavor) {
        case Flavor.PRO: _api = Api("http://104.131.18.84");break;
        case Flavor.HOMOLOG: _api = Api("");break;
      }
    }

    return _api;
  }
}
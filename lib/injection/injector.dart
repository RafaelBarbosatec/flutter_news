import 'package:FlutterNews/conectionv2/repository.dart';

enum Flavor {
  MOCK,
  PRO
}

/// Simple DI
class Injector {
  static final Injector _singleton = new Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  Repository get repository {
    switch(_flavor) {
      case Flavor.MOCK: return new Repository(false);
      default: // Flavor.PRO:
        return new Repository(true);
    }
  }
}
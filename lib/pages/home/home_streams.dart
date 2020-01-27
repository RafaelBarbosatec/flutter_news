import 'package:bsev/bsev.dart';

class HomeStreams extends StreamsBase {
  BehaviorSubjectCreate<int> tabPosition = BehaviorSubjectCreate(initValue: 0);

  @override
  void dispose() {
    tabPosition.close();
  }
}

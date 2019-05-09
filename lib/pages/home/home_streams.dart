
import 'package:bsev/bsev.dart';

class HomeStreams implements StreamsBase{

  BehaviorSubjectCreate<int> tabPosition = BehaviorSubjectCreate();

  @override
  void dispose() {
    tabPosition.close();
  }


}
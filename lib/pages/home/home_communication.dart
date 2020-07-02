import 'package:bsev/bsev.dart';

class HomeCommunication extends CommunicationBase {
  BehaviorSubjectCreate<int> tabPosition = BehaviorSubjectCreate(initValue: 0);

  @override
  void dispose() {
    tabPosition.close();
    super.dispose();
  }
}

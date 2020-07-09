import 'package:FlutterNews/repository/notice_repository/model/notice.dart';
import 'package:bsev/bsev.dart';

class SearchCommunication extends Communication {
  BehaviorSubjectCreate<bool> progress =
      BehaviorSubjectCreate(initValue: false);

  BehaviorSubjectCreate<bool> error = BehaviorSubjectCreate(initValue: false);

  BehaviorSubjectCreate<bool> empty = BehaviorSubjectCreate(initValue: false);

  BehaviorSubjectCreate<List<Notice>> noticies =
      BehaviorSubjectCreate(initValue: List());

  @override
  void dispose() {
    progress.close();
    error.close();
    empty.close();
    noticies.close();
    super.dispose();
  }
}

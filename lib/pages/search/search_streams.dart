
import 'package:FlutterNews/repository/notice_repository/model/notice.dart';
import 'package:bsev/bsev.dart';

class SearchStreams implements StreamsBase{

  BehaviorSubjectCreate<bool> progress = BehaviorSubjectCreate();

  BehaviorSubjectCreate<bool> error = BehaviorSubjectCreate();

  BehaviorSubjectCreate<bool> empty = BehaviorSubjectCreate();

  BehaviorSubjectCreate<List<Notice>> noticies = BehaviorSubjectCreate();

  @override
  void dispose() {
    progress.close();
    error.close();
    empty.close();
    noticies.close();
  }

}

import 'package:FlutterNews/domain/notice/notice.dart';
import 'package:bsev/bsev.dart';

class NewsStreams implements StreamsBase{

  BehaviorSubjectCreate<bool> errorConection = BehaviorSubjectCreate();
  BehaviorSubjectCreate<bool> progress = BehaviorSubjectCreate();
  BehaviorSubjectCreate<List<Notice>> noticies = BehaviorSubjectCreate();
  BehaviorSubjectCreate<List<String>> categoriesName = BehaviorSubjectCreate();

  @override
  void dispose() {
    progress.close();
    errorConection.close();
    noticies.close();
    categoriesName.close();
  }

}
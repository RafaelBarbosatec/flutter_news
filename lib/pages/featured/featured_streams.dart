
import 'package:FlutterNews/domain/notice/notice.dart';
import 'package:bsev/bsev.dart';

class FeaturedStreams implements StreamsBase{

  BehaviorSubjectCreate<bool> progress = BehaviorSubjectCreate();
  BehaviorSubjectCreate<bool> errorConnection = BehaviorSubjectCreate();
  BehaviorSubjectCreate<List<Notice>> noticies = BehaviorSubjectCreate();

  @override
  void dispose() {
    progress.close();
    errorConnection.close();
    noticies.close();
  }

}
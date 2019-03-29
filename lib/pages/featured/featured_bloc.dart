
import 'package:FlutterNews/conection/api.dart';
import 'package:FlutterNews/domain/notice/notice.dart';
import 'package:FlutterNews/domain/notice/notice_repository.dart';
import 'package:FlutterNews/pages/featured/FeaturedEvents.dart';
import 'package:FlutterNews/pages/featured/featured_streams.dart';
import 'package:FlutterNews/util/bloc_provider.dart';

class FeaturedBloc extends BlocBase<FeaturedStreams,FeaturedEvents>{

  final NoticeRepository repository;

  Notice nSelected;

  FeaturedBloc(this.repository){

    streams = FeaturedStreams();

    streams.getNoticeSelected.listen((notice){
      nSelected = notice;
      print(notice.title);
    });
  }

  @override
  void eventReceiver(FeaturedEvents event) {
    if(event is LoadFeatured){
      _load();
    }
  }

  _load(){

    streams.visibleProgress(true);
    streams.visibleError(false);

    repository.loadNewsRecent()
        .then((news) => _showNews(news))
        .catchError(_showImplError);

  }

  clickShowDetail(){
    if(nSelected != null){
      dispathToView(OpenDetail()..data = nSelected);
    }
  }

  _showNews(List<Notice> news) {
    nSelected = news[0];
    streams.visibleProgress(false);
    streams.addnoticies(news);
    dispathToView(InitAnimation());
  }

  _showImplError(onError) {

    print(onError);
    if(onError is FetchDataException){
      print("codigo: ${onError.code()}");
    }
    streams.visibleError(true);
    streams.visibleProgress(false);

  }

}
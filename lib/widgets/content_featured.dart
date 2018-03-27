import 'package:flutter/material.dart';
import 'pageTransform/page_transformer.dart';
import 'pageTransform/intro_page_item.dart';
import '../conection/api.dart';
import 'detail.dart';

class ContentFeaturedPage extends StatefulWidget{

  final vsync;

  ContentFeaturedPage(this.vsync);

  final state = new _ContentFeaturedState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

}

class _ContentFeaturedState extends State<ContentFeaturedPage>{

  List _destaque = new List();
  AnimationController animationController;
  NewsApi repositoty = new NewsApi();

  var carregando = false;

  var positionFeatured = 0;

  var _context;

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: widget.vsync,
        duration: new Duration(milliseconds: 300)
    );

    loadNewsRecent();

  }
  @override
  Widget build(BuildContext context) {

    _context = context;

    return new GestureDetector(
      child: new Stack(
        children: <Widget>[
          new FadeTransition(
            opacity: animationController,
            child: new Container(
              child: new PageTransformer(
                  pageViewBuilder: (context,visibilityResolver){
                    return new PageView.builder(
                      controller: new PageController(viewportFraction: 0.9),
                      itemCount: _destaque.length,
                      onPageChanged: (position){
                        setState((){
                          positionFeatured = position;
                        });
                      },
                      itemBuilder:(context,index){
                        final item = _destaque[index];
                        final pageVisibility = visibilityResolver.resolvePageVisibility(index);
                        return new IntroNewsItem(item: item,pageVisibility: pageVisibility);
                      },
                    );
                  }
              ),
            ),
          ),
          _getProgress()
        ],
      ),
      onTap: onTabFeatured,
    );

  }

  onTabFeatured(){

    IntroNews notice = _destaque[positionFeatured];

    Navigator.of(_context).push(
        new MaterialPageRoute(builder: (BuildContext context) {
          return new DetailPage(notice.imageUrl,notice.title,notice.date,notice.description,notice.category,notice.link,notice.origin);
        }
        )
    );

  }

  Widget _getProgress(){

    if(carregando){
      return new Container(
        child: new Center(
          child: new CircularProgressIndicator(),
        ),
      );
    }else{
      return new Container();
    }

  }

  void loadNewsRecent() async{

    setState((){
      _destaque.clear();
      carregando = true;
    });

    Map result = await repositoty.loadNewsRecent();

    setState(() {

      result['data'].forEach((item){

        var destaque = new IntroNews(
            item['tittle'],
            item['category'],
            item['url_img'],
            item['description'],
            item['date'],
            item['link'],
            item['origin']
        );

        _destaque.add(destaque);

      });

      carregando = false;

      animationController.forward();

    });

  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

}


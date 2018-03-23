import 'package:flutter/material.dart';
import 'pageTransform/page_transformer.dart';
import 'pageTransform/intro_page_item.dart';
import '../conection/api.dart';

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

    return new Stack(
      children: <Widget>[
        new FadeTransition(
          opacity: animationController,
          child: new Container(
            child: new PageTransformer(
                pageViewBuilder: (context,visibilityResolver){
                  return new PageView.builder(
                      controller: new PageController(viewportFraction: 0.9),
                      itemCount: _destaque.length,
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
            item['url_img']
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


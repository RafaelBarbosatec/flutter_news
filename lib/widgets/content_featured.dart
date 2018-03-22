import 'package:flutter/material.dart';
import 'pageTransform/page_transformer.dart';
import 'pageTransform/intro_page_item.dart';

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

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: widget.vsync,
        duration: new Duration(milliseconds: 300)
    );

    _destaque.add(new IntroNews("tirulo","categoria","/uploads/news/3abd7dd558a91afd4bcf482077ebc3df.jpg"));
    _destaque.add(new IntroNews("tirulo","categoria","/uploads/news/37c3980e7c4a144085177492ca52229b.jpg"));
    _destaque.add(new IntroNews("tirulo","categoria","/uploads/news/197b6dbaaa0b4c9e99c815a40ffc2b7e.jpg"));
    _destaque.add(new IntroNews("tirulo","categoria",""));

    animationController.forward();

  }
  @override
  Widget build(BuildContext context) {



    return new FadeTransition(
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
                  }
              );
            }
        ),
      ),
    );


  }

}
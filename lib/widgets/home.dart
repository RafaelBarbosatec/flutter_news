import 'package:flutter/material.dart';
import 'bottom_navigation.dart';
import 'content_news.dart';
import 'content_featured.dart';

class HomePage extends StatefulWidget {

  var _current_tab = 0;

  @override
  _HomePageState createState() => new _HomePageState();

}

class _HomePageState extends State<HomePage> {

  var isFeatured = true;
  var content_news;
  var content_featured;

  @override
  Widget build(BuildContext context) {

    content_news = new ContentNewsPage();
    content_featured = new ContentFeaturedPage();

    return new Scaffold(
      appBar: new AppBar(),
      body: isFeatured ? content_featured : content_news,
      bottomNavigationBar: new BottomNavigation(onTabNavigationBottom), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  onTabNavigationBottom(index){


    if(index != widget._current_tab) {

        setState((){
            if(index == 0) {
              isFeatured = true;
            }else{
              isFeatured = false;
            }
          }
        );

      widget._current_tab = index;

      /*if(!isFeatured) {

        var cat = 'geral';
        switch (widget._current_tab) {
          case 0:
            cat = 'geral';
            break;
          case 1:
            cat = 'technology';
            break;
          case 2:
            cat = 'sports';
            break;
          case 3:
            cat = 'entertainment';
            break;
        }
        content_news.state.loadCategory(cat, 0);

      }*/

    }

  }
}
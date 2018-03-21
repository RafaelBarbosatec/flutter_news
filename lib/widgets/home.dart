import 'package:flutter/material.dart';
import 'bottom_navigation.dart';
import 'content_news.dart';

class HomePage extends StatefulWidget {

  var _current_tab = 0;

  @override
  _HomePageState createState() => new _HomePageState();

}

class _HomePageState extends State<HomePage> {

  var content = new ContentNewsPage();

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: content,
      bottomNavigationBar: new BottomNavigation(onTabNavigationBottom), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  onTabNavigationBottom(index){


    if(index != widget._current_tab) {

      widget._current_tab = index;

      var cat = 'geral';
      switch(widget._current_tab){
        case 0: cat = 'geral';break;
        case 1: cat = 'technology';break;
        case 2: cat = 'sports';break;
        case 3: cat = 'entertainment';break;
      }
      content.state.loadCategory(cat,0);

    }

  }
}
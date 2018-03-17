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
      print( widget._current_tab);

      content.state.loadCategory("artes:${widget._current_tab}");

    }

  }
}
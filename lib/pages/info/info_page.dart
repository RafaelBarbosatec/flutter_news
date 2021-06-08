import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 500),
    );

    CurvedAnimation curve = CurvedAnimation(
      parent: animationController,
      curve: Curves.decelerate,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(curve);

    super.initState();

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new ScaleTransition(
      scale: animation,
      child: new Container(
        margin: new EdgeInsets.all(30.0),
        child: new Center(
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _getTittle(),
              _getContent(Cubes.getString("text_info")),
              _getContentSecond(
                  "Framework", "flutter.io", "https://flutter.io/"),
              _getContentSecond("Repository", "flutter_news",
                  "https://github.com/RafaelBarbosatec/flutter_news"),
              _getContentSecond("Developer", "RafaelBarbosaTec",
                  "http://rafaelbarbosatec.github.io/"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTittle() {
    return Center(
      child: new Text(
        "flutter_news",
        style: new TextStyle(
            fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 25.0),
      ),
    );
  }

  Widget _getContent(String text) {
    return new Container(
      margin: new EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: new Text(
        text,
        textAlign: TextAlign.center,
//        style: new TextStyle( color: Colors.grey[700]),
      ),
    );
  }

  Widget _getContentSecond(tittle, tittleLink, link) {
    return new Container(
      margin: new EdgeInsets.only(top: 10.0),
      child: new Column(
        children: <Widget>[
          new Text(tittle),
          new GestureDetector(
            child: new Text(
              tittleLink,
              style: new TextStyle(color: Colors.blue),
            ),
            onTap: () {
              _launchURL(link);
            },
          )
        ],
      ),
    );
  }

  _launchURL(url) async {
    await launch(url);
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Info extends StatelessWidget{

  Info(this.animationController);

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {

    return new ScaleTransition(
      scale: animationController,
      child: new Container(
          margin: new EdgeInsets.all(30.0),
          child: new Center(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _getTittle(),
                _getContent(),
                _getContentSecond("Framework","flutter.io","https://flutter.io/"),
                _getContentSecond("Repository","flutter_news","https://github.com/RafaelBarbosatec/flutter_news"),
                _getContentSecond("Developer","RafaelBarbosaTec","http://rafaelbarbosatec.github.io/"),

              ],
            ),
          ),
        ),
    );

  }

   Widget _getTittle() {
    return new Text("FlutterNews",
    style: new TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.blue,
        fontSize: 25.0),
        );
   }

  Widget _getContent() {
    
    return new Container(
      margin: new EdgeInsets.only(top: 20.0,bottom: 10.0),
      child: new Text("Aplicação desenvolvida sem fins lucrativos com o objetivo de explorar o potencial do framework Flutter.",
      textAlign: TextAlign.center,
        style: new TextStyle( color: Colors.grey[700]),
      ),
    );
  }

  Widget _getContentSecond(tittle,tittleLink,link) {

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
            onTap: (){
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
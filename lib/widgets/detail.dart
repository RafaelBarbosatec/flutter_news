import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget{

  var _img;
  var _tittle;
  var _date;
  var _description;

  DetailPage(this._img,this._tittle,this._date,this._description);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_tittle),
      ),
      body: new Container(
        child: new ListView(
          children: <Widget>[
            _getImageNetwork(_img),
            _getBody(_tittle,_date,_description)
          ],
        ),
      ),
    );
  }

  Widget _getImageNetwork(url){

    try{

      return new Image.network(url,fit: BoxFit.cover,height: 250.0,);

    }catch(e){
      return new Container(
        height: 250.0,
        color: Colors.grey,
      );
    }

  }

  Widget _getBody(tittle,date,description){

    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getTittle(tittle),
          _getDate(date),
          _getDescription(description)
        ],
      ),
    );
  }

  _getTittle(tittle) {
    return new Text(tittle,
    style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0),
    );
  }

  _getDate(date) {
    return new Text(date,
      style: new TextStyle(
          fontSize: 10.0,
          color: Colors.grey
      ),
    );
  }

  _getDescription(description) {
    return new Container(
      margin: new  EdgeInsets.only(top: 10.0),
      child: new Text(description),
    );
  }

}
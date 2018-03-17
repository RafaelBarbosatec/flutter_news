import 'package:flutter/material.dart';

class Notice extends StatelessWidget{

  var _img;
  var _tittle;
  var _date;
  var _description;

  Notice(this._img,this._tittle,this._date,this._description);


  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTapUp,
      child: new Container(
        margin: const EdgeInsets.only(top: 5.0),
        child: new Card(
          child: _getListTile(),
        ),
      ),
    );
  }

  Widget _getListTile(){

    return new Padding(
      padding: const EdgeInsets.all(10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getImgWidget(_img),
          _getColumText(_tittle,_date,_description)
        ],

      ),
    );

  }

  _handleTapUp(){

    print(_description);

  }

  Widget _getColumText(tittle,date, description){

    return new Expanded(
        child: new Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: <Widget>[
            _getTittleWidget(_tittle),
            _getDateWidget(_date),
            _getDescriptionWidget(_description)],
        )
    );
  }


  Widget _getImgWidget(String url){

    return new Container(
      width: 80.0,
      height: 80.0,
      margin: new EdgeInsets.only(right: 15.0),
      child: new Material(
        elevation: 4.0,
        borderRadius: new BorderRadius.circular(8.0),
        child: _getImageNetwork(url),
      ),
    );
  }

  Widget _getImageNetwork(url){

    try{
      return new Image.network(url);

    }catch(e){
      return new Text("EMPTY");
    }

  }

  Text _getTittleWidget(String curencyName){
    return new Text(
      curencyName,
      style: new TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _getDescriptionWidget(String description){
    return new Container(
      margin: new EdgeInsets.only(top: 5.0),
      child: new Text(description,maxLines: 3,),
    );
  }

  Widget _getDateWidget(String date){
    return new Text(date,
    style: new TextStyle(color: Colors.grey),);
  }

}
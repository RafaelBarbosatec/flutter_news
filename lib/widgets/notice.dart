import 'package:flutter/material.dart';
import 'detail.dart';

class Notice extends StatelessWidget{

  var _img;
  var _tittle;
  var _date;
  var _description;
  final AnimationController animationController;

  Notice(this._img,this._tittle,this._date,this._description, this.animationController);

  BuildContext _context;


  @override
  Widget build(BuildContext context) {
    this._context = context;
    return new FadeTransition(
      opacity: animationController,
      child: new GestureDetector(
        onTap: _handleTapUp,
        child: new Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 10.0),
          child: new Material(
            borderRadius: new BorderRadius.circular(6.0),
            elevation: 2.0,
            child: _getListTile(),
          ),
        ),
      ),
    );
  }

  Widget _getListTile(){

    return new Container(
      height: 95.0,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getImgWidget(_getImageUrl(_img, 200, 200)),
          _getColumText(_tittle,_date,_description)
        ],

      ),
    );

  }

  String _getImageUrl(url,height,width){

    return 'http://104.131.18.84/notice/tim.php?src=$url&h=$height&w=$width';

  }

  _handleTapUp(){

    Navigator.of(_context).push(
      new MaterialPageRoute(builder: (BuildContext context) {
        return new DetailPage(_img,_tittle,_date,_description);
      }
      )
    );

  }

  Widget _getColumText(tittle,date, description){

    return new Expanded(
        child: new Container(
          margin: new EdgeInsets.all(10.0),
          child: new Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: <Widget>[
              _getTittleWidget(_tittle),
              _getDateWidget(_date),
              _getDescriptionWidget(_description)],
          ),
        )
    );
  }


  Widget _getImgWidget(String url){

    return new Container(
      width: 95.0,
      height: 95.0,
      child: new Material(
        borderRadius: new BorderRadius.only(topLeft: const Radius.circular(6.0),bottomLeft: const Radius.circular(6.0)),
        child: _getImageNetwork(url),
      ),
    );
  }

  Widget _getImageNetwork(url){

    try{
      if(url != '') {

        return new FadeInImage.assetNetwork(
          placeholder: 'assets/place_holder.jpg',
          image: url,
          fit: BoxFit.cover,);
      }else{
        return new Image.asset('assets/place_holder.jpg');
      }

    }catch(e){
      return new Image.asset('assets/place_holder.jpg');
    }

  }

  Text _getTittleWidget(String curencyName){
    return new Text(
      curencyName,
      maxLines: 1,
      style: new TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _getDescriptionWidget(String description){
    return new Container(
      margin: new EdgeInsets.only(top: 5.0),
      child: new Text(description,maxLines: 2,),
    );
  }

  Widget _getDateWidget(String date){
    return new Text(date,
    style: new TextStyle(color: Colors.grey,fontSize: 10.0),);
  }

}
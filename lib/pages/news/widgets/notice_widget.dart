import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/pages/datail/detail_page.dart';
import 'package:flutter_news/repository/notice/model/notice.dart';
import 'package:flutter_news/support/util/date_util.dart';
import 'package:flutter_news/support/util/functions.dart';

class NoticeWidget extends StatelessWidget {
  final Notice item;

  const NoticeWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () => _handleTapUp(context),
      child: new Container(
        margin: const EdgeInsets.only(
            left: 10.0, right: 10.0, bottom: 10.0, top: 0.0),
        child: new Material(
          borderRadius: new BorderRadius.circular(6.0),
          elevation: 2.0,
          child: _getListTile(),
        ),
      ),
    );
  }

  Widget _getListTile() {
    return new Container(
      height: 95.0,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Hero(
            tag: item.title,
            child: _getImgWidget(Functions.getImgResizeUrl(item.img, 200, 200)),
          ),
          _getColumText(item.title, item.date, item.description)
        ],
      ),
    );
  }

  void _handleTapUp(BuildContext context) {
    context.goTo(DetailPage(
      notice: item,
    ));
  }

  Widget _getColumText(title, date, description) {
    return new Expanded(
        child: new Container(
      margin: new EdgeInsets.all(10.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getTitleWidget(title),
          _getDateWidget(date),
          _getDescriptionWidget(description)
        ],
      ),
    ));
  }

  Widget _getImgWidget(String url) {
    return new Container(
      width: 95.0,
      height: 95.0,
      child: new ClipRRect(
        borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(6.0),
            bottomLeft: const Radius.circular(6.0)),
        child: _getImageNetwork(url),
      ),
    );
  }

  Widget _getImageNetwork(String url) {
    try {
      if (url.isNotEmpty) {
        return new FadeInImage.assetNetwork(
          placeholder: 'assets/place_holder.jpg',
          image: url,
          fit: BoxFit.cover,
        );
      } else {
        return new Image.asset('assets/place_holder.jpg');
      }
    } catch (e) {
      return new Image.asset('assets/place_holder.jpg');
    }
  }

  Text _getTitleWidget(String curencyName) {
    return new Text(
      curencyName,
      maxLines: 1,
      style: new TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _getDescriptionWidget(String description) {
    return new Container(
      margin: new EdgeInsets.only(top: 5.0),
      child: new Text(
        description,
        maxLines: 2,
      ),
    );
  }

  Widget _getDateWidget(String date) {
    return new Text(
      new DateUtil().buildDate(date),
      style: new TextStyle(color: Colors.grey, fontSize: 10.0),
    );
  }
}


import 'package:flutter/material.dart';

class CustomTab extends StatefulWidget {

  final Function(int) tabSelected;
  final List<String> itens;

  const CustomTab({Key key, this.tabSelected, this.itens}) : super(key: key);

  @override
  _CustomTabState createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> {
  var category_selected = 0;

  @override
  Widget build(BuildContext context) {
    return _getListCategory();
  }

  Widget _getListCategory(){

    ListView listCategory = new ListView.builder(
        itemCount: widget.itens.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          return _buildCategoryItem(index);
        }
    );

    return new Container(
      height: 50.0,
      child: listCategory,
      color: Colors.grey[200].withAlpha(200),
    );

  }

  Widget _buildCategoryItem(index){

    return new InkWell(
      onTap: (){
        setSelectedItem(index);
        print("click");
      },
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: new Material(
              elevation: 2.0,
              color: category_selected == index ? Theme.of(context).primaryColorDark : Theme.of(context).accentColor,
              borderRadius: const BorderRadius.all(const Radius.circular(25.0)),
              child:  new Container(
                padding: new EdgeInsets.only(left: 12.0,top: 7.0,bottom: 7.0,right: 12.0),
                child: new Text(widget.itens[index],
                  style: new TextStyle(
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );

  }

  void setSelectedItem(index) {

    if(index != category_selected) {
      widget.tabSelected(index);
      setState(() {
        category_selected = index;
      });
    }
  }

}

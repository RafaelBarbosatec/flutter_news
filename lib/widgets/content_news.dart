import 'package:flutter/material.dart';
import 'notice.dart';

class ContentNewsPage extends StatefulWidget{

  final state = new _ContentNewsPageState();

  @override
  _ContentNewsPageState createState() => state;

}

class _ContentNewsPageState extends State<ContentNewsPage>{

  var current_category = '';

  List _news = new List();

  bool carregando = false;

  @override
  void initState() {
    _news.add(new Notice(
      "https://pbs.twimg.com/profile_images/760249570085314560/yCrkrbl3_400x400.jpg","Titulo","25 de Abril de 2018","descrição"
    ));
    _news.add(new Notice(
        "https://pbs.twimg.com/profile_images/760249570085314560/yCrkrbl3_400x400.jpg","Titulo","25 de Abril de 2018","descrição"
    ));
    _news.add(new Notice(
        "https://pbs.twimg.com/profile_images/760249570085314560/yCrkrbl3_400x400.jpg","Titulo","25 de Abril de 2018","descridescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãoção"
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print(current_category);

    return new Container(
      child:new Column(
        children: <Widget>[
          _getListViewWidget()
        ],
      )
    );

  }

  Widget _getListViewWidget(){

    ListView listView = new ListView.builder(
        itemCount: _news.length,
        itemBuilder: (context, index){

          //final Map notice = _news[index];

          return _news[index];
        }
        );

    RefreshIndicator refreshIndicator = new RefreshIndicator(
        onRefresh: onRefresh,
        child: listView
    );

    return new Flexible(
        child: new Stack(
          children: <Widget>[
            refreshIndicator,
            _getProgress()
          ],
        )
    );

  }

  Widget _getProgress(){

    if(carregando){
      return new Container(
        child: new Center(
          child: new CircularProgressIndicator(),
        ),
      );
    }else{
      return new Container();
    }

  }

  onRefresh() async{

  }

  loadCategory(category){
    print(category);
    setState((){
      current_category = category;
      _news.add(new Notice(
          "https://pbs.twimg.com/profile_images/760249570085314560/yCrkrbl3_400x400.jpg","Titulo","25 de Abril de 2018","descrição"
      ));
      carregando = !carregando;
      }
    );
  }

}
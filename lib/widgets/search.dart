import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget{

  TextEditingController editingController = new TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.only(left: 16.0,right: 16.0,top: 40.0),
      margin: const EdgeInsets.only(),
      child: new Material(
        borderRadius: const BorderRadius.all(const Radius.circular(25.0)),
        elevation: 2.0,
        child: new Container(
          height: 45.0,
          margin: new EdgeInsets.only(left: 16.0,right: 16.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                    maxLines: 1,
                    decoration: new InputDecoration(
                      icon: const Icon(Icons.search,color: Colors.blue,),
                      hintText: "Busque sua noticia aqui",
                    ),
                    controller: editingController,
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
  
}
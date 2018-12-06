import 'package:FlutterNews/localization/MyLocalizations.dart';
import 'package:flutter/material.dart';

class ErroConection extends StatelessWidget {

  final VoidCallback tryAgain;

  ErroConection({Key key, this.tryAgain}) : super(key: key);

  MyLocalizations strl;

  @override
  Widget build(BuildContext context) {

    strl = MyLocalizations.of(context);

    return Container(
      child: Center(
        child: new Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 8.0,
          ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(
                  Icons.cloud_off,
                  size: 100.0,
                  color: Colors.blue,
                ),
                new Text(
                  strl.trans("text_error"),
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new RaisedButton(
                    onPressed: tryAgain,
                    child: new Text(strl.trans("text_tentar_novamente")),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

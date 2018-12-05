import 'package:FlutterNews/localization/MyLocalizationsDelegate.dart';
import 'package:flutter/material.dart';
import 'widgets/home.dart';

void main() => runApp(new NewsApp());

class NewsApp extends StatelessWidget {

  MyLocalizationsDelegate myLocation = const MyLocalizationsDelegate();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter News',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
//      supportedLocales: MyLocalizationsDelegate.supportedLocales(),
//      localizationsDelegates: [
//        myLocation,
//      ],
//      localeResolutionCallback: myLocation.resolution,
      home: new HomePage(),
    );
  }

}

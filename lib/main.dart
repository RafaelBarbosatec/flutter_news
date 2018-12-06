import 'package:FlutterNews/injection/injector.dart';
import 'package:FlutterNews/localization/MyLocalizationsDelegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'widgets/home.dart';

void main() => runApp(new NewsApp());

class NewsApp extends StatelessWidget {

  MyLocalizationsDelegate myLocation = const MyLocalizationsDelegate();

  NewsApp(){
    Injector.configure(Flavor.PRO);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter News',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      supportedLocales: MyLocalizationsDelegate.supportedLocales(),
      localizationsDelegates: [
        myLocation,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: myLocation.resolution,
      home: HomePage.create(),
    );
  }

}

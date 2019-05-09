import 'package:FlutterNews/support/di/BlocModule.dart';
import 'package:FlutterNews/support/di/RepositoryModule.dart';
import 'package:FlutterNews/support/localization/MyLocalizationsDelegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:FlutterNews/pages/home/home.dart';
import 'package:simple_injector/simple_injector.dart';

void main() => runApp(new NewsApp());

class NewsApp extends StatelessWidget {

  MyLocalizationsDelegate myLocation = const MyLocalizationsDelegate();

  NewsApp(){
    SimpleInjector.configure(Flavor.PROD);
    SimpleInjector().registerModule(RepositoryModule());
    SimpleInjector().registerModule(BlocModule());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter News',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        accentColor: Colors.blue,
        brightness: Brightness.light
      ),
      supportedLocales: MyLocalizationsDelegate.supportedLocales(),
      localizationsDelegates: [
        myLocation,
        DefaultCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: myLocation.resolution,
      home: HomePage.create(),
    );
  }

}

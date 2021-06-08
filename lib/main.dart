import 'package:cubes/cubes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/pages/home/home_page.dart';
import 'package:flutter_news/support/di/dependency_injection.dart';

import 'support/di/dependency_injection.dart';

void main() => runApp(new NewsApp());

class NewsApp extends StatelessWidget {
  final cubeLocation = CubesLocalizationDelegate(
    [
      Locale('en', 'US'),
      Locale('pt', 'BR'),
    ],
    pathFiles: 'resources/lang/',
  );

  NewsApp() {
    DependencyInjection.inject();
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
        brightness: Brightness.light,
      ),
      localizationsDelegates: cubeLocation.delegates,
      supportedLocales: cubeLocation.supportedLocations,
      home: HomePage(),
    );
  }
}

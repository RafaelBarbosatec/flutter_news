import 'package:FlutterNews/localization/MyLocalizations.dart';
import 'package:flutter/material.dart';

Type _typeOf<T>() => T;

abstract class StreamsBase {
  void dispose();
}

abstract class BlocBase<T extends StreamsBase> {
  T streams;
  MyLocalizations _myLocalizations;

  void confMyLocalizations(BuildContext context){
    _myLocalizations = MyLocalizations.of(context);
  }

  String getString(String key){
    try{
      return _myLocalizations.trans(key);
    }catch(e){
      return "";
    }
  }
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }): super(key: key);

  final Widget child;
  final T bloc;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context){
    final type = _typeOf<_BlocProviderInherited<T>>();
    _BlocProviderInherited<T> provider = context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    return provider?.bloc;
  }
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>>{
  @override
  void dispose(){
    widget.bloc?.streams?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    widget.bloc.confMyLocalizations(context);
    return new _BlocProviderInherited<T>(
      bloc: widget.bloc,
      child: widget.child,
    );
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}
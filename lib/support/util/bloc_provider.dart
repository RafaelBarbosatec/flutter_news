import 'dart:async';
import 'package:FlutterNews/support/localization/MyLocalizations.dart';
import 'package:flutter/material.dart';

Type _typeOf<T>() => T;

abstract class StreamsBase {
  void dispose();
}

abstract class EventsBase {
  dynamic data;
}

abstract class BlocView<E extends EventsBase> {
  @protected
  void eventViewReceiver(E event);
}

abstract class BlocBase<T extends StreamsBase, E extends EventsBase> {

  T streams;
  MyLocalizations _myLocalizations;

  StreamController<E> _eventController = StreamController<E>();
  Stream<E> get getEvent => _eventController.stream;
  Function(E) get setEvent => _eventController.sink.add;

  StreamController<E> _eventViewController = StreamController<E>.broadcast();
  Stream<E> get getViewEvent => _eventViewController.stream;
  Function(E) get setViewEvent => _eventViewController.sink.add;

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

  BlocBase() {
    getEvent.listen(eventReceiver);
  }

  void registerView(BlocView view) {
    getViewEvent.listen(view.eventViewReceiver);
  }

  @protected
  void dispathToView(E event) {
    setViewEvent(event);
  }

  void dispatch(E event) {
    setEvent(event);
  }

  @protected
  void eventReceiver(E event);

  dispose(){
    _eventController.close();
    _eventViewController.close();
    streams.dispose();
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
    widget.bloc?.dispose();
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
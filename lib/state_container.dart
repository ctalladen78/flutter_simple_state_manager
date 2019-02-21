import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'todo_model.dart';
import 'todo_bloc.dart';

class StateProvider extends StatefulWidget {
  final Widget ROOT_WIDGET;

  StateProvider({
    @required this.ROOT_WIDGET,
  });

  // TODO of
  static StateManager of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AppStateContainer) as AppStateContainer).stateManager;
  }

  @override
  StateManager createState() => StateManager();
}

class StateManager extends State<StateProvider> {

  TodoBloc todoBloc = TodoBloc();

  // addToTodos

  // deleteFromTodos


  @override
  Widget build(BuildContext context) {
    return new AppStateContainer(
      stateManager: this,
      child: widget.ROOT_WIDGET,
    );
  }
}

class AppStateContainer extends InheritedWidget {
  final StateManager stateManager; 

  AppStateContainer({
    Key key,
    @required this.stateManager,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(AppStateContainer oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }



}
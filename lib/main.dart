import 'package:flutter/material.dart';
import 'state_container.dart';
import 'home_screen.dart';

void main() => runApp(StateProvider(ROOT_WIDGET: TodoApp(),));

class TodoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: HomeScreen(),
    );
  }

}

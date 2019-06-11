import 'api_service.dart';
import 'package:flutter/material.dart';
import 'state_container.dart';
import 'todo_bloc.dart';

class UpdateUserForm extends StatelessWidget {
  static final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> firstNameKey =
  new GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> lastNameKey =
  new GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> emailKey =
  new GlobalKey<FormFieldState<String>>();

  UpdateUserForm(){}
  
  @override
  Widget build(BuildContext context) {

    final container = StateProvider.of(context); // TODO reference container to make state change

    void update() {
      final form = formKey.currentState;
          if (form.validate()) {
            var firstName = firstNameKey.currentState.value;
            var lastName = lastNameKey.currentState.value;
            var email = emailKey.currentState.value;

            if (firstName == '') {
              firstName = null;
            }
            if (lastName == '') {
              lastName = null;
            }
            if (email == '') {
              email = null;
            }

            container.todoBloc.addTodo(
              data: {"firstName":firstName,"lastName":lastName,"email":email}
            );

            Navigator.pop(context);
      }
    }
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Edit User Info'),
      ),
      body: new Padding(
        padding: new EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          autovalidate: false,
          child: new ListView(
            children: [
              new TextFormField(
                key: firstNameKey,
                style: Theme.of(context).textTheme.headline,
                decoration: new InputDecoration(
                  hintText: 'First Name',
                ),
              ),
              new TextFormField(
                key: lastNameKey,
                style: Theme.of(context).textTheme.headline,
                decoration: new InputDecoration(
                  hintText: 'Last Name',
                ),
              ),
              new TextFormField(
                key: emailKey,
                style: Theme.of(context).textTheme.headline,
                decoration: new InputDecoration(
                  hintText: 'Email Address',
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: update
      ),
    );
  }
}
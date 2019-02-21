import 'package:flutter/material.dart';
import 'state_container.dart';
import 'todo_model.dart';
import 'form_page.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final container = StateProvider.of(context);
    // container.todoBloc.streamItems();
    return Scaffold(
      // body:Container(),
      body: StreamBuilder(
        stream:container.todoBloc.streamItems(),
        initialData: [TodoItem(data: "test", objectId: "test123")],
        builder: (context, snapshot){
          if(snapshot.hasData && snapshot.connectionState == ConnectionState.active){
            
            return ListView.builder(
              itemCount:snapshot.data.length,
              itemBuilder: (context, index){
                var data = snapshot.data[index].data;
            var objid = snapshot.data[index].objectId;
            print("INFO $data $objid");
                return ListTile(
                  title:Text(snapshot.data[index].data),
                  trailing: IconButton(icon: Icon(Icons.delete),
                    onPressed: (){
                      container.todoBloc.deleteTodo(objectId: snapshot.data[index].objectId);
                    },
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context){
            return UpdateUserForm();
          }
        ));
      }),
    );
  }
}
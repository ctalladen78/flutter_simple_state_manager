import 'package:flutter/material.dart';
import 'state_container.dart';
import 'todo_model.dart';
import 'form_page.dart';


class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController controller = new PageController();
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen1(),
          HomeScreen2(),
  ];

  _HomeScreenState();

  BottomNavigationBar _buildFooter(){ 
    return new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
          controller.animateToPage(
            _selectedIndex,
            duration: kTabScrollDuration,
            curve: Curves.fastOutSlowIn,
          );
        });
      },
      items: <BottomNavigationBarItem>[
        new BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text('Discover', style: TextStyle(color: Colors.white),),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.add),
          title: new Text('Trips', style: TextStyle(color: Colors.white)),
        ),
        
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    print("HOME SCREEN INIT");
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    // final container = StateProvider.of(context);

    return new Scaffold(
      // backgroundColor: Colors.white,
      body: new PageView(
        controller: controller,
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        children: <Widget>[
          HomeScreen1(),
          HomeScreen2(),
        ],
      ),
      // body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: _buildFooter(), 
    );
  }
}


class HomeScreen1 extends StatelessWidget {
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
                  title:Text(objid),
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

class HomeScreen2 extends StatelessWidget {
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
                  title:Text(objid),
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
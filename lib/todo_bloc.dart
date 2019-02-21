import 'package:rxdart/rxdart.dart';
import 'package:youtube_simple_state_manager/api_service.dart';
import 'package:youtube_simple_state_manager/todo_model.dart';

class TodoBloc {
  final parseService =ParseService();
  final streamController = PublishSubject<List<TodoItem>>(); 

  TodoBloc(){}

  Observable<List<TodoItem>> streamItems() {
    parseService.getTodo().then((res){
      print("RESPONSE $res");
      streamController.sink.add(res);
    });
    return streamController.stream;
  }

  addTodo({data: String}) async {

    await parseService.createTodo(info: data);
    await parseService.getTodo().then((res){
      streamController.sink.add(res);
    });
    return streamController.stream;
  }

  deleteTodo({objectId: String}) async {
    await parseService.deleteUser(objectId: objectId);
    await parseService.getTodo().then((res){
      streamController.sink.add(res);
    });
    return streamController.stream;
  }

  dispse(){
    streamController.close();
  }


}
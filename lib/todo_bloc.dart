import 'package:rxdart/rxdart.dart';
import 'package:youtube_simple_state_manager/api_service.dart';
import 'package:youtube_simple_state_manager/todo_model.dart';
import 'dart:async';

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

  addTodo({data: Map}) async {
    
    await parseService.createTodo(info: data);
    await parseService.getTodo().then((res){
      streamController.sink.add(res);
    });
    return streamController.stream;
  }

  deleteTodo({objectId: String}) async {
    await parseService.deleteTodo(objectId: objectId);
    await parseService.getTodo().then((res){
      streamController.sink.add(res);
    });
    return streamController.stream;
  }

  dispse(){
    streamController.close();
  }


}

// https://github.com/ResoCoder/flutter-bloc-vanilla-tutorial
class CounterBloc {
  int _counter = 0;

  final _counterStateController = StreamController<int>();
  StreamSink<int> get _inCounter => _counterStateController.sink;
  
  // For state, exposing only a stream which outputs data
  Stream<int> get counter => _counterStateController.stream;

  final _counterEventController = StreamController<CounterEvent>();
  // For events, exposing only a sink which is an input
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    // Whenever there is a new event, we want to map it to a new state
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent)
      _counter++;
    else
      _counter--;

    _inCounter.add(_counter);
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}

abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}
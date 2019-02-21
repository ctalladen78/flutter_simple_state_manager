import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:dio/dio.dart';
import 'todo_model.dart';

class ParseService {

  String PARSE_APP_ID = "";
  String REST_API_KEY = "";
  String PARSE_URI = "https://parseapi.back4app.com/";
  
  ParseService();

  Future<List<TodoItem>> getTodo() async {
    var header = {
      "X-Parse-Application-Id":PARSE_APP_ID,
      "X-Parse-REST-API-Key":REST_API_KEY,
    };
    var options = Options(headers: header);
    // var data = {"data": firstname};
    String uri = PARSE_URI+"classes/TodoItem";
    var response = await Dio().get(uri, options: options).catchError((onError){print("USER error $onError");});
    var list = List<TodoItem>();
    for (var item in response.data["results"]) {
      TodoItem todo =TodoItem.fromJson(item);
      list.add(todo);
    }
    return list;
  }

  Future<bool> createTodo({info : String}) async {
    // trip.isReviewed == false
    var header = {
      "X-Parse-Application-Id":PARSE_APP_ID,
      "X-Parse-REST-API-Key":REST_API_KEY,
    };
    var options = Options(headers: header);
    // var data = {"data": data, };
    var data = {"data": info};
    String uri = PARSE_URI+"classes/TodoItem";
    var response = await Dio().post(uri, data: data,options: options).catchError((onError){print("USER error $onError");});
    return (response.statusCode == 201) ?  true : false;
  }

  Future<bool> deleteUser({objectId: String}) async {
    // trip.isReviewed == false
    var header = {
      "X-Parse-Application-Id":PARSE_APP_ID,
      "X-Parse-REST-API-Key":REST_API_KEY,
    };
    var options = Options(headers: header);
    var data = {};
    String uri = PARSE_URI+"classes/TodoItem/"+objectId;
    var response = await Dio().delete(uri, data: data,options: options).catchError((onError){print("USER error $onError");});
    return (response == null || response.statusCode == 200) ?  true : false;
  }

  Future<bool> UpdateTodoItem({description : String, date: String, duration: int, city: String, tripId: String, }) async {
    // trip.isReviewed == false
    var header = {
      "X-Parse-Application-Id":PARSE_APP_ID,
      "X-Parse-REST-API-Key":REST_API_KEY,
    };
    var options = Options(headers: header);
    var data = {};
    String uri = PARSE_URI+"classes/TodoItem";
    var response = await Dio().put(uri, data: data,options: options).catchError((onError){print("USER error $onError");});
    return (response.statusCode == 200) ?  true : false;
  }

}
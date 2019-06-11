import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:dio/dio.dart';
import 'todo_model.dart';
import 'tokens.dart';

class ParseService {

  
  
  ParseService();

  Future<List<TodoItem>> getTodo() async {
    var header = {
      "X-Parse-Application-Id":Tokens().PARSE_APP_ID,
      "X-Parse-REST-API-Key":Tokens().REST_API_KEY,
    };
    String s = "add add";
    var options = Options(headers: header);
    // {"createdBy":{"$inQuery":{"where":{"objectId":"RM37CXC37n"},"className":"Trip"}}}
    var queryParams = {"where": "{\"tripRef\":{\"\$inQuery\":{\"where\":{\"objectId\":\"RM37CXC37n\"},\"className\":\"Trip\"}}}"};
    // var queryParams = {
    //   "where":"{createdBy:{\"__type\": \"Pointer\",\"className\":\"_User\",\"objectId\":\"\$objectId\"}}"
    // };
    //     // var queryParameters = "?where={\"createdBy\":{ \"__type\": \"Pointer\", \"className\":\"_User\", \"objectId\": \"iHClyWQk1s\"}}";
    String uri = Tokens().PARSE_URI+"classes/TodoItem";
    var response = await Dio().get(uri, options: options).catchError((onError){print("USER error $onError");});
    var list = List<TodoItem>();
    for (var item in response.data["results"]) {
      print("RESULT $item");
      TodoItem todo =TodoItem.fromJson(item);
      list.add(todo);
    }
    return list;
  }

  Future<bool> createTodo({info : Map}) async {
    // trip.isReviewed == false
    var header = {
      "X-Parse-Application-Id":Tokens().PARSE_APP_ID,
      "X-Parse-REST-API-Key":Tokens().REST_API_KEY,
    };
    var options = Options(headers: header);
    // var data = {"data": data, };
    print("info ${info["firstName"]}");
    var payload = "${info['firstName']} ${info['lastName']}";
    var data = {"data": payload};
    String uri = Tokens().PARSE_URI+"classes/TodoItem";
    var response = await Dio().post(uri, data: data,options: options).catchError((onError){print("USER error $onError");});
    
    return (response.statusCode == 201) ?  true : false;
  }

  Future<bool> deleteTodo({objectId: String}) async {
    // trip.isReviewed == false
    var header = {
      "X-Parse-Application-Id":Tokens().PARSE_APP_ID,
      "X-Parse-REST-API-Key":Tokens().REST_API_KEY,
    };
    var options = Options(headers: header);
    var data = {};
    String uri = Tokens().PARSE_URI+"classes/TodoItem/"+objectId;
    var response = await Dio().delete(uri, data: data,options: options).catchError((onError){print("USER error $onError");});
    return (response == null || response.statusCode == 200) ?  true : false;
  }

  Future<bool> UpdateTodoItem({description : String, date: String, duration: int, city: String, tripId: String, }) async {
    // trip.isReviewed == false
    var header = {
      "X-Parse-Application-Id":Tokens().PARSE_APP_ID,
      "X-Parse-REST-API-Key":Tokens().REST_API_KEY,
    };
    var options = Options(headers: header);
    var data = {};
    String uri = Tokens().PARSE_URI+"classes/TodoItem";
    var response = await Dio().put(uri, data: data,options: options).catchError((onError){print("USER error $onError");});
    return (response.statusCode == 200) ?  true : false;
  }

}
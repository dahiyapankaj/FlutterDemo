import 'dart:convert';

import 'package:flutterapp/models/Todo.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'ApiHelper.dart';

class ApiRepository {
  ApiHelper _helper = ApiHelper();

//  Future<List<Todo>> fetchTodoList() async {
//    final response = await _helper.get("/todos");
//    List<dynamic> body = jsonDecode(response.body);
//    List<Todo> abc = body
//        .map(
//          (dynamic item) => Todo.fromJson(item),
//    ).toList();
//    print("myflutter response size abc is "+abc.length.toString());
////    print(abc.toString());
//    return abc;
//  }


  Future<List<Todo>> fetchTodoList() async {
    String url = 'https://jsonplaceholder.typicode.com/todos';
    final Response res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Todo> todoList = body
          .map(
            (dynamic item) => Todo.fromJson(item),
      )
          .toList();
      print("size is... " + todoList.length.toString());
      return todoList;
    } else {
      print("Can't get Todos....");
      throw "Can't get Todos.";
    }
  }
}

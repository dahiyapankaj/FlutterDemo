//ToDo : Imports
//ToDo : List of Todos
//ToDo : Stream controllers
//ToDo : Stream sink getters
//ToDo : Constructor - add data and listen to changes
//ToDo : Core functions
//ToDo : dispose

import 'dart:async';

import 'package:flutterapp/networking/ApiRepository.dart';
import 'package:flutterapp/networking/ApiResponse.dart';

import '../models/Todo.dart';

class TodoBloc {
  /// Sink to add in pipe
  /// Stream to get data from pipe
  /// by pipe, i mean data flow

  ApiRepository _apiRepository;
  StreamController _tooListController;

  StreamSink<ApiResponse<List<Todo>>> get todoListSink =>
      _tooListController.sink;

  Stream<ApiResponse<List<Todo>>> get todoListStream =>
      _tooListController.stream;

  TodoBloc() {
    _tooListController = StreamController<ApiResponse<List<Todo>>>();
    _apiRepository = ApiRepository();
    fetchDataList();
  }

  fetchDataList() async {
    todoListSink.add(ApiResponse.loading('Fetching data...'));
    try {
      List<Todo> list = await _apiRepository.fetchTodoList();
      todoListSink.add(ApiResponse.completed(list));
    } catch (e) {
      todoListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _tooListController?.close();
  }
}

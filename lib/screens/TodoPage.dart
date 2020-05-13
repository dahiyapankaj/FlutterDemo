import 'package:flutter/material.dart';
import 'package:flutterapp/bloc/TodoBlock.dart';
import 'package:flutterapp/models/Todo.dart';
import 'package:flutterapp/networking/ApiRepository.dart';
import 'package:flutterapp/networking/ApiResponse.dart';

import 'ErrorPage.dart';
import 'LoadingPage.dart';
import 'TodoList.dart';

class TodoPage extends StatefulWidget {
  TodoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  ApiRepository apiRepository = ApiRepository();
  TodoBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = TodoBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Listing')),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchDataList(),
        child: StreamBuilder<ApiResponse<List<Todo>>>(
          stream: _bloc.todoListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return TodoList(todoList: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchDataList(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutterapp/models/Todo.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todoList;

  const TodoList({Key key, this.todoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Card(
              elevation: 10,
              child: ListTile(
                leading: Text(todoList[index].id.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                title: Text(
                    'Task completed: ' +
                        todoList[index].completed.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                subtitle: Text(todoList[index].title),
              ),
            ),
          );
        });
  }
}

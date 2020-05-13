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
                leading: CircleAvatar(
                    backgroundColor: getColor(todoList[index].completed),
                    child: Text(todoList[index].id.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold))),
                title: Text(
                    'Task completed: ' + todoList[index].completed.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                subtitle: Text(todoList[index].title),
                onTap: () {
                  print("Tapped on the item " + index.toString());
                },
              ),
            ),
          );
        });
  }
}

//  Function to return background color for completed items
getColor(bool completed) {
  return completed ? Colors.green : Colors.red;
}

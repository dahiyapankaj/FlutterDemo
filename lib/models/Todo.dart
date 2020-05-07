import 'package:flutter/cupertino.dart';

class Todo {
  int _id;
  int _userId;
  String _title;
  bool _completed;

  Todo(this._id, this._userId, this._title, this._completed);

  /// Setters
  set id(int id) {
    this._id = id;
  }

  set userId(int userId) {
    this.userId = userId;
  }

  set title(String title) {
    this._title = title;
  }

  set completed(bool completed) {
    this._completed = completed;
  }

  /// getters
  int get id => this._id;

  int get userId => this._userId;

  String get title => this._title;

  bool get completed => this._completed;

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      json['id'] as int,
      json['userId'] as int,
      json['title'] as String,
      json['completed'] as bool,
    );
  }


}

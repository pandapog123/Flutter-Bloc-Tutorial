import 'package:code/models/todo.dart';
import 'package:flutter/material.dart';

class AppModel {
  String id;
  String name;
  bool darkTheme;
  Color themeColor;
  List<TodoModel> todos;

  AppModel({
    required this.id,
    required this.name,
    required this.darkTheme,
    required this.themeColor,
    required this.todos,
  });
}

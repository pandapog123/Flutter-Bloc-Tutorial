import 'package:code/models/todo.dart';
import 'package:flutter/material.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile({
    required this.todo,
    super.key,
  });

  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.content),
    );
  }
}

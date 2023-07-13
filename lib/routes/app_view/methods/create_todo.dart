import 'package:code/models/app.dart';
import 'package:code/routes/app_view/components/create_todo_dialog.dart';
import 'package:flutter/material.dart';

void createTodo(
  BuildContext context,
  AppModel currentApp,
) async {
  await showDialog(
    context: context,
    builder: (context) {
      return CreateTodoDialog(app: currentApp);
    },
  );
}

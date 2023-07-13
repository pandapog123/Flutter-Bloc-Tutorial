import 'package:code/models/app.dart';
import 'package:code/state/apps_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTodoDialog extends StatefulWidget {
  final AppModel app;

  const CreateTodoDialog({
    required this.app,
    super.key,
  });

  @override
  State<CreateTodoDialog> createState() => _CreateTodoDialogState();
}

class _CreateTodoDialogState extends State<CreateTodoDialog> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Create a new To-Do"),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Short text",
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop();

            context.read<AppsBloc>().add(AppAddTodo(
                  id: widget.app.id,
                  todoContent: _controller.text,
                ));
          },
          child: const Text("Create"),
        ),
      ],
    );
  }
}

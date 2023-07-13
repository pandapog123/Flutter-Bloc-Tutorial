import 'package:code/routes/app_view/components/todo_list_tile.dart';
import 'package:code/routes/app_view/methods/create_todo.dart';
import 'package:code/state/apps_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppViewWrapper extends StatelessWidget {
  final String appId;
  const AppViewWrapper({
    required this.appId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppsBloc>().state;

    final app = state.firstWhere((element) => element.id == appId);

    return Theme(
      data: ThemeData(
        useMaterial3: true,
        brightness: app.darkTheme ? Brightness.dark : Brightness.light,
        colorSchemeSeed: app.themeColor,
      ),
      child: AppView(
        appId: appId,
      ),
    );
  }
}

class AppView extends StatefulWidget {
  final String appId;

  const AppView({
    required this.appId,
    super.key,
  });

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    final appsBloc = context.watch<AppsBloc>();
    final state = appsBloc.state;
    final app = state.firstWhere((element) => element.id == widget.appId);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: Text(app.name),
          ),
          SliverList.separated(
            itemCount: app.todos.length,
            itemBuilder: (context, index) {
              final todo = app.todos[index];

              return Dismissible(
                key: ValueKey(todo.id),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  appsBloc.add(
                    AppRemoveTodo(
                      id: widget.appId,
                      todoId: todo.id,
                    ),
                  );
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: const Icon(Icons.delete_forever),
                ),
                child: TodoListTile(
                  todo: todo,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(height: 0);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createTodo(context, app);
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}

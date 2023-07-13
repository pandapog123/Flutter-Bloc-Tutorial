import 'package:code/routes/main/components/apps_list_tile.dart';
import 'package:code/routes/create_app/main.dart';
import 'package:code/state/apps_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  static const id = "MainPage";

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void handleAdd() {
    Navigator.pushNamed(
      context,
      CreateAppPage.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appsBloc = context.watch<AppsBloc>();

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text("Flutter Bloc Tutorial"),
      ),
      body: ListView.separated(
        itemCount: appsBloc.state.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(appsBloc.state[index].id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 16),
              child: const Icon(Icons.delete_forever),
            ),
            onDismissed: (direction) {
              appsBloc.add(
                AppRemoved(
                  id: appsBloc.state[index].id,
                ),
              );
            },
            child: AppsListTile(
              app: appsBloc.state[index],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(height: 0);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: handleAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}

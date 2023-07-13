import 'package:code/routes/create_app/main.dart';
import 'package:code/routes/main/main.dart';
import 'package:code/state/apps_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppsBloc(),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        initialRoute: MainPage.id,
        routes: {
          MainPage.id: (context) {
            return const MainPage();
          },
          CreateAppPage.id: (context) {
            return const CreateAppPage();
          },
        },
      ),
    );
  }
}

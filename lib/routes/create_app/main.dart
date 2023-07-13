import 'package:code/models/app.dart';
import 'package:code/state/apps_bloc.dart';
import 'package:code/utils/named_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class CreateAppPage extends StatefulWidget {
  static const id = "CreateAppPage";

  const CreateAppPage({super.key});

  @override
  State<CreateAppPage> createState() => CreateAppPageState();
}

class CreateAppPageState extends State<CreateAppPage> {
  late _AppState _state;

  @override
  void initState() {
    super.initState();

    _state = _AppState(
      currentApp: AppModel(
        darkTheme: false,
        id: const Uuid().v4(),
        name: "",
        themeColor: namedColors.entries.first.value,
        todos: [],
      ),
    );
  }

  handleSubmit() {
    setState(_state.toggleSubmitting);

    context.read<AppsBloc>().add(AppAdded(
          app: _state.currentApp,
        ));

    Navigator.pop(context);

    setState(_state.toggleSubmitting);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final dropdownColorsList = namedColors.entries.map((color) {
      return DropdownMenuItem(
        value: color.value,
        child: Row(
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: color.value,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(width: 8),
            Text(color.key),
          ],
        ),
      );
    }).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Create a new App"),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(4),
            sliver: SliverList.list(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              _state.setName(value);
                            });
                          },
                          autofocus: true,
                          decoration: const InputDecoration(
                            label: Text("Short and descriptive text"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Theme Color",
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        DropdownButton<Color>(
                          isExpanded: true,
                          value: _state._currentApp.themeColor,
                          items: dropdownColorsList,
                          onChanged: (color) {
                            assert(color != null);

                            setState(() {
                              _state.setThemeColor(color!);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _state.toggleDarkTheme();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Dark theme",
                            style: theme.textTheme.titleLarge,
                          ),
                          Switch.adaptive(
                            value: _state.currentApp.darkTheme,
                            onChanged: (value) {
                              setState(() {
                                _state.setDarkTheme(value);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            style: FilledButton.styleFrom(
              textStyle: theme.textTheme.titleLarge,
              padding: const EdgeInsets.all(16),
            ),
            onPressed: _state.nameValid ? handleSubmit : null,
            child: const Text("Create App"),
          ),
        ),
      ),
    );
  }
}

class _AppState {
  late AppModel _currentApp;
  bool _submitting = false;

  AppModel get currentApp => _currentApp;
  bool get nameValid => _currentApp.name != "";
  bool get submitting => _submitting;

  _AppState({required AppModel currentApp}) {
    _currentApp = currentApp;
  }

  void setThemeColor(Color color) {
    _currentApp.themeColor = color;
  }

  void setName(String name) {
    _currentApp.name = name;
  }

  void setDarkTheme(bool mode) {
    _currentApp.darkTheme = mode;
  }

  void toggleDarkTheme() {
    _currentApp.darkTheme = !_currentApp.darkTheme;
  }

  void toggleSubmitting() {
    _submitting = !_submitting;
  }
}

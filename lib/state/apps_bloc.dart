import 'package:bloc/bloc.dart';
import 'package:code/models/todo.dart';
import 'package:meta/meta.dart';
import "package:code/models/app.dart";

part 'apps_event.dart';

class AppsBloc extends Bloc<AppsEvent, List<AppModel>> {
  AppsBloc() : super([]) {
    on<AppAdded>((event, emit) {
      final stateCopy = List.of(state);

      stateCopy.add(event.app);

      emit(stateCopy);
    });

    on<AppRemoved>((event, emit) {
      emit(
        state.where(
          (element) {
            return element.id != event.id;
          },
        ).toList(),
      );
    });

    on<AppAddTodo>((event, emit) {
      final newState = state.map((app) {
        if (app.id == event.id) {
          final todosCopy = List.of(app.todos);

          todosCopy.add(TodoModel.fromContent(event.todoContent));

          app.todos = todosCopy;
        }

        return app;
      }).toList();

      emit(newState);
    });

    on<AppRemoveTodo>((event, emit) {
      final stateCopy = List.of(state);

      final newState = stateCopy.map((app) {
        if (app.id == event.id) {
          app.todos = app.todos.where((element) {
            return element.id != event.todoId;
          }).toList();
        }

        return app;
      }).toList();

      emit(newState);
    });
  }
}

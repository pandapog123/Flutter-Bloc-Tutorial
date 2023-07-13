part of 'apps_bloc.dart';

@immutable
abstract class AppsEvent {
  const AppsEvent();
}

final class AppAdded extends AppsEvent {
  final AppModel app;

  const AppAdded({required this.app});
}

final class AppRemoved extends AppsEvent {
  final String id;

  const AppRemoved({required this.id});
}

final class AppAddTodo extends AppsEvent {
  final String id;
  final String todoContent;

  const AppAddTodo({
    required this.id,
    required this.todoContent,
  });
}

final class AppRemoveTodo extends AppsEvent {
  final String id;
  final String todoId;

  const AppRemoveTodo({
    required this.id,
    required this.todoId,
  });
}

import 'package:uuid/uuid.dart';

class TodoModel {
  String content;
  String id;
  bool checked;

  TodoModel({
    required this.content,
    required this.id,
    required this.checked,
  });

  factory TodoModel.fromContent(String content) {
    return TodoModel(
      content: content,
      id: const Uuid().v4(),
      checked: false,
    );
  }
}

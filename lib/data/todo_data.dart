import '../model/todo_data.dart';

class Repository {
  static List<TodoModel> todoList = [
    TodoModel(1, "Go to zym", true),
    TodoModel(2, "Buy groceries", true),
    TodoModel(3, "Read Book", false),
    TodoModel(5, "Clean Home", false)
  ];
}

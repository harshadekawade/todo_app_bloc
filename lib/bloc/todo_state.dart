import 'package:todo_app_bloc/model/todo_data.dart';

abstract class TodoState {}

abstract class TodoActionState extends TodoState {}

class TodoInitialState extends TodoState {}

class TodoLoadingState extends TodoState {}

class TodoListFetchSuccesState extends TodoState {
  final List<TodoModel> list;
  TodoListFetchSuccesState(this.list);
}

class TodoListErrorState extends TodoState {}

class TodoTaskCompletedActionState extends TodoActionState {}

class TodoTaskAddActionState extends TodoActionState {}

class TodoTaskRemovedActionState extends TodoActionState {}

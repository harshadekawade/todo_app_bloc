import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todo_app_bloc/bloc/todo_event.dart';
import 'package:todo_app_bloc/bloc/todo_state.dart';
import 'package:todo_app_bloc/data/todo_data.dart';
import 'package:todo_app_bloc/model/todo_data.dart';

class TodoBloc extends Bloc<TodoEvents, TodoState> {
  TodoBloc() : super(TodoInitialState()) {
    on<TodoInitialEvent>(todoInitialEvent);
    on<TodoCompleteTaskEvent>(todoCompleteTaskEvent);
    on<TodoAddTaskEvent>(todoAddTaskEvent);
    on<TodoRemoveTaskEvent>(todoRemoveTaskEvent);
  }

  FutureOr<void> todoInitialEvent(
      TodoInitialEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    emit(TodoListFetchSuccesState(Repository.todoList));
  }

  FutureOr<void> todoCompleteTaskEvent(
      TodoCompleteTaskEvent event, Emitter<TodoState> emit) {
    Repository.todoList[event.index].isCompleted = event.isCompleted;
    if (event.isCompleted) {
      emit(TodoTaskCompletedActionState());
    }
    emit(TodoListFetchSuccesState(Repository.todoList));
  }

  FutureOr<void> todoAddTaskEvent(
      TodoAddTaskEvent event, Emitter<TodoState> emit) {
    Repository.todoList
        .add(TodoModel(Repository.todoList.length, event.taskName, false));
    emit(TodoTaskAddActionState());
    emit(TodoListFetchSuccesState(Repository.todoList));
  }

  FutureOr<void> todoRemoveTaskEvent(
      TodoRemoveTaskEvent event, Emitter<TodoState> emit) {
    Repository.todoList.removeAt(event.index);
    emit(TodoTaskRemovedActionState());
    emit(TodoListFetchSuccesState(Repository.todoList));
  }
}

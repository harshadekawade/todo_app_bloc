import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/bloc/todo_bloc.dart';
import 'package:todo_app_bloc/bloc/todo_event.dart';
import 'package:todo_app_bloc/bloc/todo_state.dart';
import 'package:todo_app_bloc/ui/todo_add_widget.dart';
import 'package:todo_app_bloc/ui/todo_tile_widget.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController taskNameController = TextEditingController();
  final TodoBloc todoBloc = TodoBloc();
  @override
  void initState() {
    todoBloc.add(TodoInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 255, 253),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("TODO App"),
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        bloc: todoBloc,
        listener: (context, state) {
          if (state is TodoTaskCompletedActionState) {
            showSnackBar(context, message: 'Task Completed');
          } else if (state is TodoTaskAddActionState) {
            showSnackBar(context, message: 'New Task Added');
          } else if (state is TodoTaskRemovedActionState) {
            showSnackBar(context, message: 'Task Removed');
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (TodoLoadingState):
              return const Center(child: CircularProgressIndicator());
            case const (TodoListFetchSuccesState):
              final successState = state as TodoListFetchSuccesState;
              if (successState.list.isNotEmpty) {
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: successState.list.length,
                  itemBuilder: (context, index) => TodoTileWidget(
                      index: index,
                      todoBloc: todoBloc,
                      todoModel: successState.list[index]),
                );
              }
              return buildErrorWidget("Todo List is empty");
            case const (TodoListErrorState):
              return buildErrorWidget("Something went wrong");
            default:
              return buildErrorWidget("Something went wrong");
          }
        },
      ),
      bottomSheet:
          TodoAddWidget(todoBloc: todoBloc, controller: taskNameController),
    );
  }

  Widget buildErrorWidget(message) {
    return Center(
        child: Text(message, style: const TextStyle(color: Colors.red)));
  }
}

void showSnackBar(context, {bool isError = false, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: const Duration(milliseconds: 500),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(message),
      )));
}

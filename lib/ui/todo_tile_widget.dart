import 'package:flutter/material.dart';
import 'package:todo_app_bloc/bloc/todo_bloc.dart';
import 'package:todo_app_bloc/bloc/todo_event.dart';
import 'package:todo_app_bloc/model/todo_data.dart';

class TodoTileWidget extends StatelessWidget {
  final TodoBloc todoBloc;
  final TodoModel todoModel;
  final int index;
  const TodoTileWidget(
      {super.key,
      required this.todoModel,
      required this.todoBloc,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.teal.withOpacity(0.5), blurRadius: 5)
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Checkbox(
            value: todoModel.isCompleted,
            onChanged: (val) {
              todoBloc.add(TodoCompleteTaskEvent(index, val!));
            }),
        title: Text(
          todoModel.taskName,
          style: TextStyle(
              fontSize: 14,
              decoration:
                  todoModel.isCompleted ? TextDecoration.lineThrough : null),
        ),
        trailing: IconButton(
            onPressed: () {
              todoBloc.add(TodoRemoveTaskEvent(index));
            },
            icon: const Icon(Icons.delete_outline_outlined, color: Colors.red)),
      ),
    );
  }
}

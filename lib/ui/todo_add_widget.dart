import 'package:flutter/material.dart';
import 'package:todo_app_bloc/bloc/todo_bloc.dart';
import 'package:todo_app_bloc/bloc/todo_event.dart';
import 'package:todo_app_bloc/ui/todo_screen.dart';

class TodoAddWidget extends StatelessWidget {
  final TodoBloc todoBloc;
  final TextEditingController controller;
  const TodoAddWidget(
      {super.key, required this.todoBloc, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.teal.withOpacity(0.2)))),
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: controller,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                  hintStyle:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Enter Task..",
                  border: OutlineInputBorder()),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
              flex: 1,
              child: IntrinsicHeight(
                child: ElevatedButton(
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        FocusScope.of(context).unfocus();
                        todoBloc.add(TodoAddTaskEvent(controller.text));
                        controller.text = "";
                      } else {
                        showSnackBar(context,
                            isError: true, message: "Please Enter Task");
                      }
                    },
                    child: const Icon(Icons.add)),
              ))
        ],
      ),
    );
  }
}

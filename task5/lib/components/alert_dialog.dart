import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_bloc/bloc/bloc_bloc.dart';
import 'package:with_bloc/bloc/event_bloc.dart';

class DialogAlert extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;

  const DialogAlert({
    super.key,
    required this.titleController,
    required this.contentController,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Enter your task"),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              maxLength: 20,
            ),
            TextField(
              controller: contentController,
              maxLines: 3,
              maxLength: 60,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (contentController.text.isNotEmpty &&
                titleController.text.isNotEmpty) {
              context.read<TodoListBloc>().add(
                AddTodo(
                  title: titleController.text,
                  content: contentController.text,
                ),
              );
              contentController.clear();
              titleController.clear();
              Navigator.pop(context);
            }
          },
          child: const Text("Add Task"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}

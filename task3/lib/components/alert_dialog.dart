
import 'package:flutter/material.dart';
import 'package:task_3/models/todo_store.dart';

class DialogAlert extends StatelessWidget {
  const DialogAlert({
    super.key,
    required this.titleController,
    required this.contentController,
    required TodoStore todoStore,
  }) : _todoStore = todoStore;

  final TextEditingController titleController;
  final TextEditingController contentController;
  final TodoStore _todoStore;

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
              _todoStore.addTodo(
                titleController.text,
                contentController.text,
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

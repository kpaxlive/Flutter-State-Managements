
import 'package:flutter/material.dart';
import 'package:task_3/models/todo_store.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton(
      {super.key, required TodoStore todoStore, required this.index})
      : _todoStore = todoStore;

  final TodoStore _todoStore;
  final int index;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _todoStore.removeTodo(index);
      },
      icon: const Icon(
        Icons.delete_outline_rounded,
        size: 28,
        color: Color.fromARGB(255, 98, 119, 215),
      ),
    );
  }
}

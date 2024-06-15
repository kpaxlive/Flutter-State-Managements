
import 'package:flutter/material.dart';
import 'package:task_2/bloc/bloc.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton(
      {super.key, required this.todoStore, required this.index});

  final TodoListCubit todoStore;
  final int index;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        todoStore.removeTodoAt(index);
      },
      icon: const Icon(
        Icons.delete_outline_rounded,
        size: 28,
        color: Color.fromARGB(255, 98, 119, 215),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_4/models/todo_store.dart';

class DeleteButton extends StatelessWidget {
  final int index;
  const DeleteButton(
      {super.key,  required this.index});


  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder:(context, ref, child) {
        final todoStore = ref.read(todoStoreProvider.notifier);
        return IconButton(
        onPressed: () {
          todoStore.removeTodo(index);
        },
        icon: const Icon(
          Icons.delete_outline_rounded,
          size: 28,
          color: Color.fromARGB(255, 98, 119, 215),
        ));
      },
    );
  }
}

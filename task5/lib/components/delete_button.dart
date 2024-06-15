import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_bloc/bloc/bloc_bloc.dart';
import 'package:with_bloc/bloc/event_bloc.dart';

class DeleteButton extends StatelessWidget {
  final int index;

  const DeleteButton({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<TodoListBloc>().add(RemoveTodoAt(index: index));
      },
      icon: const Icon(
        Icons.delete_outline_rounded,
        size: 28,
        color: Color.fromARGB(255, 98, 119, 215),
      ),
    );
  }
}

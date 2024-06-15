
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2/bloc/bloc.dart';
import 'package:task_2/components/alert_dialog.dart';

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({
    super.key,
    required this.titleController,
    required this.contentController,
    required this.todoStore,
  });

  final TextEditingController titleController;
  final TextEditingController contentController;
  final TodoListCubit todoStore;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: FloatingActionButton(
        backgroundColor: Colors.deepPurple.shade300,
        
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: DialogAlert(titleController: titleController, contentController: contentController, todoStore: context.read()),
              );
            },
          );
        },
        child: Icon(Icons.add, color: Colors.grey.shade200, size: 40),
      ),
    );
  }}
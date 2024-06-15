
import 'package:flutter/material.dart';
import 'package:task_3/components/alert_dialog.dart';
import 'package:task_3/models/todo_store.dart';

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({
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
                child: DialogAlert(titleController: titleController, contentController: contentController, todoStore: _todoStore),
              );
            },
          );
        },
        child: Icon(Icons.add, color: Colors.grey.shade200, size: 40),
      ),
    );
  }}
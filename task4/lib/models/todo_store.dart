import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:task_4/models/todo_model.dart';
import 'package:task_4/services/hive_service.dart';

final todoStoreProvider = ChangeNotifierProvider((ref) {
  return getIt<TodoStore>();
});

final getIt = GetIt.instance;

class TodoStore extends ChangeNotifier {
  final HiveService _hiveService = getIt<HiveService>();

  List<Todo> todos = [];

  TodoStore() {
    _init();
  }

  Future _init() async {
    await _hiveService.init();
    await loadTodos();
  }

  Future loadTodos() async {
    final todoList = await _hiveService.getAllTodoItems();
    todos = todoList.cast();
    notifyListeners();
  }

  void addTodo(String title, String content) {
    final id = DateTime.now().toIso8601String();

    final todo = Todo(
      id: id,
      title: title,
      content: content,
      isDone: false,
    );
    todos.add(todo);
    _hiveService.addTodoItem(id, todo);
    notifyListeners();
  }

  void removeTodo(int index) {
    _hiveService.deleteTodoItem(todos[index].id);
    todos.removeAt(index);
    notifyListeners();
  }

  void toggleTodoStatus(int index) {
    todos[index] = todos[index].copyWith(isDone: !todos[index].isDone);
    _hiveService.addTodoItem(todos[index].id, todos[index]);
    notifyListeners();
  }
}

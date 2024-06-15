
import 'package:flutter/material.dart';
import 'package:task_3/models/todo_model.dart';
import 'package:task_3/services/hive_service.dart';



class TodoStore extends ChangeNotifier {
  final HiveService _hiveService = HiveService();


  List<Todo> todos = [];


   TodoStore() {
    _init();
  }

  Future _init() async {
    await _hiveService.init();
    await loadTodos();
    notifyListeners();
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

  void removeTodo(int index)
  {
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



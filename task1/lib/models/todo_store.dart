import 'package:deneme/models/todo_model.dart';
import 'package:deneme/services/hive_service.dart';
import 'package:mobx/mobx.dart';

part 'todo_store.g.dart';

class TodoStore = _TodoStore with _$TodoStore;

abstract class _TodoStore with Store {
  final HiveService _hiveService = HiveService();

  @observable
  ObservableList todos = ObservableList();

   _TodoStore() {
    _init();
  }

  Future _init() async {
    await _hiveService.init();
    await loadTodos();
  }

  @action
  Future loadTodos() async {
    final todoList = await _hiveService.getAllTodoItems();
    todos = ObservableList.of(todoList.cast());
  }

  @action
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
  }

  @action
  void removeTodo(int index)
  {
    _hiveService.deleteTodoItem(todos[index].id);
    todos.removeAt(index);
  }

  @action
  void toggleTodoStatus(int index) {
    todos[index] = todos[index].copyWith(isDone: !todos[index].isDone);
    _hiveService.addTodoItem(todos[index].id, todos[index]);
  }
}



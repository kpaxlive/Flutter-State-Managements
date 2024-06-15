import 'package:bloc/bloc.dart';
import 'package:task_2/models/todo_model.dart';
import 'package:task_2/services/hive_service.dart';

class TodoListCubit extends Cubit<List<Todo>> {
  final HiveService _hiveService = HiveService();

  TodoListCubit() : super([]) {
    _init();
  }

  Future _init() async {
    await _hiveService.init();
    await loadTodos();
  }

  Future loadTodos() async {
    final todoList = await _hiveService.getAllTodoItems();
    emit(todoList.cast());
  }

  void addTodo(String title, String content) {
    final id = DateTime.now().toIso8601String();
    final todo = Todo(
      id: id,
      title: title,
      content: content,
      isDone: false,
    );
    final List<Todo> updatedTodos = List.from(state)..add(todo);
    emit(updatedTodos);
    _hiveService.addTodoItem(id, todo);
  }

  void removeTodoAt(int index) {
    final List<Todo> updatedTodos = List.from(state)..removeAt(index);
    _hiveService.deleteTodoItem(state[index].id);
    emit(updatedTodos);
  }

  void toggleTodoStatus(int index) {
    final Todo todo = state[index];
    final Todo updatedTodo = todo.copyWith(isDone: !todo.isDone);
    final List<Todo> updatedTodos = List.from(state)..[index] = updatedTodo;
    emit(updatedTodos);
    _hiveService.addTodoItem(updatedTodo.id, updatedTodo);
  }
}

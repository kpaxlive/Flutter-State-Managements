import 'package:bloc/bloc.dart';
import 'package:with_bloc/bloc/event_bloc.dart';
import 'package:with_bloc/bloc/state_bloc.dart';
import 'package:with_bloc/models/todo_model.dart';
import 'package:with_bloc/services/hive_service.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  final HiveService _hiveService;

  TodoListBloc(this._hiveService) : super(TodoListInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<RemoveTodoAt>(_onRemoveTodoAt);
    on<ToggleTodoStatus>(_onToggleTodoStatus);
    _init();
  }

  Future _init() async {
    await _hiveService.init();
    add(LoadTodos());
  }

  Future _onLoadTodos(LoadTodos event, Emitter emit) async {
    final todoList = await _hiveService.getAllTodoItems();
    emit(TodoListLoaded(todoList.cast()));
  }

  void _onAddTodo(AddTodo event, Emitter emit) {
    final id = DateTime.now().toIso8601String();
    final todo = Todo(
      id: id,
      title: event.title,
      content: event.content,
      isDone: false,
    );

    if (state is TodoListLoaded) {
      final updatedTodos = List.from((state as TodoListLoaded).todos)
        ..add(todo);
      emit(TodoListLoaded(updatedTodos));
      _hiveService.addTodoItem(id, todo);
    }
  }

  void _onRemoveTodoAt(RemoveTodoAt event, Emitter emit) {
    if (state is TodoListLoaded) {
      final updatedTodos = List.from((state as TodoListLoaded).todos)
        ..removeAt(event.index);
      _hiveService
          .deleteTodoItem((state as TodoListLoaded).todos[event.index].id);
      emit(TodoListLoaded(updatedTodos));
    }
  }

  void _onToggleTodoStatus(ToggleTodoStatus event, Emitter emit) {
    if (state is TodoListLoaded) {
      final todos = List.from((state as TodoListLoaded).todos);
      final todo = todos[event.index];
      final updatedTodo = todo.copyWith(isDone: !todo.isDone);
      todos[event.index] = updatedTodo;
      emit(TodoListLoaded(todos));
      _hiveService.addTodoItem(updatedTodo.id, updatedTodo);
    }
  }
}

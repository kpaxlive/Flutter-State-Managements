import 'package:equatable/equatable.dart';

abstract class TodoListEvent extends Equatable {
  
  @override
  List get props => [];
}

class LoadTodos extends TodoListEvent {}

class AddTodo extends TodoListEvent {
  final String title;
  final String content;

  AddTodo({
    required this.title,
    required this.content,
  });

  @override
  List get props => [title, content];
}

class RemoveTodoAt extends TodoListEvent {
  final int index;

  RemoveTodoAt({required this.index});

  @override
  List get props => [index];
}

class ToggleTodoStatus extends TodoListEvent {
  final int index;

  ToggleTodoStatus({required this.index});

  @override
  List get props => [index];
}

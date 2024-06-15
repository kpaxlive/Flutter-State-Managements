import 'package:equatable/equatable.dart';

abstract class TodoListState extends Equatable {
  @override
  List get props => [];
}

class TodoListInitial extends TodoListState {}

class TodoListLoaded extends TodoListState {
  final List todos;

  TodoListLoaded(this.todos);

  @override
  List get props => [todos];
}

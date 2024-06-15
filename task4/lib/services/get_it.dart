import 'package:get_it/get_it.dart';
import 'package:task_4/services/hive_service.dart';
import 'package:task_4/models/todo_store.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton(HiveService());
  getIt.registerSingleton(TodoStore());
}

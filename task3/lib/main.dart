
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_3/models/todo_model.dart';
import 'package:task_3/models/todo_store.dart';
import 'package:task_3/screens/tasks_page.dart';
import 'package:task_3/services/hive_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TodoAdapter());

  final hiveService = HiveService();
  await hiveService.init();
  
  runApp(ChangeNotifierProvider(
    create:(context) => TodoStore(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,),
      home: const TasksPage(),
    );
  }
}
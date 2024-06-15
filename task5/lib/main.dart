import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:with_bloc/bloc/bloc_bloc.dart';
import 'package:with_bloc/models/todo_model.dart';
import 'package:with_bloc/screens/home_page.dart';
import 'package:with_bloc/services/hive_service.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TodoAdapter());

  final hiveService = HiveService();
  await hiveService.init();
  runApp( MyApp(hiveService: hiveService,));
}

class MyApp extends StatelessWidget {
  final HiveService hiveService;
  const MyApp({super.key, required this.hiveService});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) =>  TodoListBloc(hiveService),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Bloc",
        home: HomePage(),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_2/bloc/bloc.dart';
import 'package:task_2/components/alert_dialog.dart';
import 'package:task_2/components/delete_button.dart';
import 'package:task_2/models/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 46, 46, 61),

      
      body: BlocBuilder<TodoListCubit, List<Todo>>(builder: (context, todoStore) {
        // if (todoStore.isEmpty) {
        //     return const Center(child: Text('No todos yet'));
        // }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "You",
                      style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "got things to do",
                          style: GoogleFonts.aBeeZee(
                              textStyle: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          )),
                        ),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: DialogAlert(
                                        titleController: titleController,
                                        contentController: contentController,
                                        todoStore: context.read(),),
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 55,
                            )),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 66, 66, 88),
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(25),
                        topEnd: Radius.circular(25)),
                  ),
                  child: ListView.builder(
                    itemCount: todoStore.length,
                    itemBuilder: (context, index) {
                      final task = todoStore[index];
                      return Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 73, 73, 96),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                value: todoStore[index].isDone,
                                activeColor: Colors.blue,
                                fillColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 98, 119, 215)),
                                onChanged: (value) 
                                {
                                  context.read<TodoListCubit>().toggleTodoStatus(index);
                                }      
                              ),
                            ),
                            const SizedBox(
                                height: 80,
                                width: 5,
                                child:
                                    VerticalDivider(color: Colors.red)),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      task.title.toUpperCase(),
                                      style: GoogleFonts.aBeeZee(
                                        textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    task.content,
                                    softWrap: true,
                                    style: GoogleFonts.aBeeZee(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 2),
                            DeleteButton(todoStore: context.read<TodoListCubit>(), index: index),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

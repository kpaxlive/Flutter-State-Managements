import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart'; // Ensure the correct import
import 'package:with_bloc/bloc/bloc_bloc.dart';
import 'package:with_bloc/bloc/event_bloc.dart';
import 'package:with_bloc/bloc/state_bloc.dart';
import 'package:with_bloc/components/alert_dialog.dart';
import 'package:with_bloc/components/delete_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State {
  // Change 1
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 46, 46, 61),
      body: BlocBuilder<TodoListBloc, TodoListState>(
        // Change 1
        builder: (context, state) {
          if (state is TodoListInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoListLoaded) {
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
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: DialogAlert(
                                          titleController: titleController,
                                          contentController: contentController,
                                        ),
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
                        itemCount: state.todos.length,
                        itemBuilder: (context, index) {
                          final task = state.todos[index];
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
                                      value: task.isDone,
                                      activeColor: Colors.blue,
                                      fillColor: MaterialStateProperty.all(
                                          const Color.fromARGB(
                                              255, 98, 119, 215)),
                                      onChanged: (value) {
                                        context
                                            .read<TodoListBloc>()
                                            .add(// Change 1
                                                ToggleTodoStatus(index: index));
                                      }),
                                ),
                                const SizedBox(
                                    height: 80,
                                    width: 5,
                                    child: VerticalDivider(color: Colors.red)),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                DeleteButton(index: index),
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
          } else {
            return const Center(child: Text('Something went wrong!'));
          }
        },
      ),
    );
  }
}

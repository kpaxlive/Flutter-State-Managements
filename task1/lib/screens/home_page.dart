//Yukarıya yapışık ve altta liste olan bir görüntü için kaydettim.


// import 'package:deneme/models/todo_store.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:hive/hive.dart';

// class TodoListPage extends StatelessWidget {
//   final TodoStore todoStore;

//   TodoListPage({required this.todoStore});

//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _contentController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Todo List'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _titleController,
//                   decoration: const InputDecoration(labelText: 'Title'),
//                 ),
//                 TextField(
//                   controller: _contentController,
//                   decoration: const InputDecoration(labelText: 'Content'),
//                 ),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     todoStore.addTodo(
//                       _titleController.text,
//                       _contentController.text,
//                     );
//                     _titleController.clear();
//                     _contentController.clear();
//                   },
//                   child: const Text('Add Todo'),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Container(
//               height: MediaQuery.of(context).size.height,
//               decoration: const BoxDecoration(
//                 color: Color.fromARGB(255, 73, 73, 96),
//                 borderRadius: BorderRadiusDirectional.only(
//                     topStart: Radius.circular(25), topEnd: Radius.circular(25)),
//               ),
//               child: Observer(
//                 builder: (_) {
//                   return ListView.builder(
//                     itemCount: todoStore.todos.length,
//                     itemBuilder: (context, index) {
//                       final todo = todoStore.todos[index];
//                       return ListTile(
//                         leading: Checkbox(
//                           value: todo.isDone,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(
//                                 5.0), // Adjust border radius as needed
//                             side: BorderSide(
//                               color: Colors.red, // Change to your desired color
//                               width: 2.0, // Adjust border width as needed
//                             ),
//                           ),
//                           onChanged: (_) {
//                             todoStore.toggleTodoStatus(index);
//                           },
//                         ),
//                         title: Text(todo.title),
//                         subtitle: Text(todo.content),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.delete_outline),
//                           onPressed: () {
//                             todoStore.removeTodo(index);
//                           },
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

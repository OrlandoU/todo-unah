import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_unah/components/Input.dart';
import 'package:todo_unah/extras/todos.dart';
import 'package:todo_unah/extras/utils.dart';

class AdminTodoPage extends StatelessWidget {
  AdminTodoPage({super.key, this.todo});

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final FocusNode titleFocus = FocusNode();

  final Map<String, dynamic>? todo;

  @override
  Widget build(BuildContext context) {
    final todoId = GoRouterState.of(context).pathParameters['id'];

    if (todo != null) {
      titleController.text = todo!['title'];
      descriptionController.text = todo!['description'];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          todo == null
              ? 'Creación de una nueva tarea'
              : 'Editando la tarea # $todoId',
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Input(label: 'Titulo', controller: titleController, focusNode: titleFocus, prefixIcon: Icon(Icons.text_fields_rounded), maxLines: 1,),
            SizedBox(height: 8),
            Input(label: 'Descripcion', controller: descriptionController, maxLines: 4,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[300],
        onPressed: () {
          if (titleController.text.isEmpty) {

            Utils.showSnackBar(
              context: context,
              title: "El titulo es obligatorio",
              color: Colors.red,
            );

            return;
          }

          final Map<String, dynamic> newTodo = {
            'id': todoList.length + 1,
            'title': titleController.text,
            'description': descriptionController.text,
            'completed': false,
          };

          if (todoId == null) {
            todoList.add(newTodo);
            Utils.showSnackBar(
              context: context,
              title: "Tarea creada correctamente",
            );
          } else {
            final indice = todoList.indexWhere(
              (todo) => todo['id'].toString() == todoId,
            );
            Utils.showSnackBar(
              context: context,
              title: "Tarea editada correctamente",
            );
            todoList[indice] = newTodo;
          }


          titleController.text = '';
          descriptionController.text = '';

          context.pop();
        },
        child: Icon(Icons.add, color: Colors.blue[50]),
      ),
    );
  }
}

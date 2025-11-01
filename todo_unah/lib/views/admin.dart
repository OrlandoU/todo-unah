import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
            TextField(
              focusNode: titleFocus,
              controller: titleController,
              decoration: InputDecoration(
                label: Text('Titulo'),
                hint: Text('Eje. Crear opción de eliminar'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),

                prefixIcon: Icon(Icons.text_fields_rounded),
              ),

              maxLines: 1,
              maxLength: 50,
              obscureText: false,
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(label: Text('Descripción')),
            ),
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

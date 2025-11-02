import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_unah/views/admin.dart';
import 'package:todo_unah/views/home.dart';
import 'package:todo_unah/views/login.dart';
import 'package:todo_unah/views/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        initialLocation: '/login',
        routes: [
          GoRoute(
            path: '/',
            name: 'todo-list',
            builder: (context, state) => HomePage(),
            routes: [
              GoRoute(path: '/login', name: 'login', builder: (context, state) {
                return LoginPage();
              }),
              GoRoute(path:'/signup', name: 'signup', builder: (context, state) {
                return SignupPage();
              }),
              GoRoute(
                path: '/create', //?   /todos/create
                name: 'new-todo',   
                builder: (context, state) => AdminTodoPage(),
              ),
              GoRoute(
                path: '/:id', //?   /todos/124
                name: 'update-todo',
                builder: (context, state) {
                  final todo = state.extra as Map<String, dynamic>;

                  return AdminTodoPage(todo: todo);
                },
              ),
            ],
          ),
        ],
      ));
  }
}


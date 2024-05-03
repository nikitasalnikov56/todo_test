import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/domain/todo_bloc/todo_bloc.dart';
import 'package:todo_list/ui/routes/app_navigator.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc()..add(TodoLoadingEvent()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppNavigator.router,
      ),
    );
  }
}

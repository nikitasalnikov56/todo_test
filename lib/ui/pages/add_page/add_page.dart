import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/domain/todo_bloc/todo_bloc.dart';
import 'package:todo_list/domain/models/app_controllers/app_controllers.dart';
import 'package:todo_list/ui/components/form_widget.dart';
import 'package:todo_list/ui/components/home_button.dart';
import 'package:todo_list/ui/routes/app_routes.dart';
import 'package:todo_list/ui/style/app_colors.dart';
import 'package:todo_list/ui/style/app_style.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.purple,
        title: Text(
          'Add Task',
          style: AppStyle.fontStyle,
        ),
        leading: const HomeButton(),
      ),
      body: FormWidget(
        btnName: 'Add',
        func: () {
          context.read<TodoBloc>().add(
                TodoAddEvent(
                  title: AppControllers.titleController.text,
                  text: AppControllers.textController.text,
                ),
              );
          context.go(AppRoutes.home);
        },
      ),
    );
  }
}

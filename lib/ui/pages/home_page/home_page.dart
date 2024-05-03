import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/domain/models/app_controllers/app_controllers.dart';
import 'package:todo_list/domain/models/clear_controllers/clear_controllers.dart';
import 'package:todo_list/domain/todo_bloc/todo_bloc.dart';
import 'package:todo_list/ui/components/home_body.dart';
import 'package:todo_list/ui/routes/app_routes.dart';
import 'package:todo_list/ui/style/app_colors.dart';
import 'package:todo_list/ui/style/app_style.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.purple,
        title: Text(
          'TODO APP'.toUpperCase(),
          style: AppStyle.fontStyle,
        ),
        actions: [
          SizedBox(
            width: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: AppControllers.searchController,
                decoration: InputDecoration(
                  fillColor: AppColors.white,
                  filled: true,
                  hintText: 'Поиск',
                  hintStyle: AppStyle.fontStyle.copyWith(
                    fontSize: 16,
                    color: AppColors.black,
                  ),
                  contentPadding:
                      const EdgeInsets.only(left: 8, top: 0, bottom: 10),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (String str) {
                  context.read<TodoBloc>().add(
                        TodoSearchEvent(
                          title: str,
                        ),
                      );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.purple,
        shape: const CircleBorder(),
        onPressed: () {
          ClearController.contollersClear();
          context.go(AppRoutes.add);
        },
        child: Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
      body: const HomeBody(),
    );
  }
}

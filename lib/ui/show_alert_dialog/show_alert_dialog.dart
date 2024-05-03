import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/domain/todo_bloc/todo_bloc.dart';
import 'package:todo_list/ui/style/app_colors.dart';
import 'package:todo_list/ui/style/app_style.dart';

class ShowAlertDialog {
  static Future<dynamic> showAlertDialog(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Are you really want to delete?',
              style: AppStyle.fontStyle.copyWith(
                fontSize: 16,
                color: AppColors.lightPurple,
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.background,
                ),
                onPressed: () {
                  context.read<TodoBloc>().add(TodoDeleteEvent(index));
                  Navigator.pop(context);
                },
                child: Text(
                  'Yes',
                  style: AppStyle.fontStyle,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purple,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'No',
                  style: AppStyle.fontStyle,
                ),
              ),
            ],
            actionsAlignment: MainAxisAlignment.spaceAround,
          );
        });
  }

 
}

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/domain/todo_bloc/todo_bloc.dart';
import 'package:todo_list/ui/routes/app_routes.dart';
import 'package:todo_list/ui/show_alert_dialog/show_alert_dialog.dart';
import 'package:todo_list/ui/style/app_colors.dart';
import 'package:todo_list/ui/style/app_style.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.index,
    required this.state,
  });
  final String title, subTitle;
  final AllTodoState state;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !state.notes[index].isChecked
          ? () {
              context.go(AppRoutes.edit, extra: index);
            }
          : null,
      child: Card(
        color:
            state.notes[index].isChecked ? Colors.grey[200] : AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 19, right: 25, top: 22, bottom: 22),
          child: ListTile(
            enabled: false,
            dense: true,
            contentPadding: const EdgeInsets.all(0),
            leading: state.notes[index].imagePath != null
                ? SizedBox(
                    height: 100,
                    child: Image.file(File(state.notes[index].imagePath!)))
                : null,
            title: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.fontStyle.copyWith(
                fontSize: 20,
                color: AppColors.purple,
                decoration: state.notes[index].isChecked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationThickness: 3,
              ),
            ),
            subtitle: Text(
              subTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.fontStyle.copyWith(
                fontSize: 18,
                color: AppColors.black,
                decoration: state.notes[index].isChecked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationThickness: 3,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    ShowAlertDialog.showAlertDialog(context, index);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: AppColors.lightPurple,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<TodoBloc>().add(
                          TodoCheckEvent(
                            index: index,
                            title: '${state.notes[index].title}',
                            text: '${state.notes[index].text}',
                            isChecked: true,
                          ),
                        );
                  },
                  icon: Icon(
                    Icons.check_circle_outline,
                    color: state.notes[index].isChecked
                        ? const Color.fromARGB(255, 144, 244, 29)
                        : AppColors.lightPurple,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

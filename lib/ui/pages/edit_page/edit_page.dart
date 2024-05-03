import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/domain/models/app_controllers/app_controllers.dart';
import 'package:todo_list/domain/todo_bloc/todo_bloc.dart';
import 'package:todo_list/ui/components/form_widget.dart';
import 'package:todo_list/ui/components/home_button.dart';
import 'package:todo_list/ui/routes/app_routes.dart';
import 'package:todo_list/ui/show_alert_dialog/show_alert_dialog.dart';
import 'package:todo_list/ui/style/app_colors.dart';
import 'package:todo_list/ui/style/app_style.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final extra =
        GoRouter.of(context).routerDelegate.currentConfiguration.extra;
    final index = extra is int ? extra : 0;
    BlocProvider.of<TodoBloc>(context).add(TodoSetControllersEvent(index));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.purple,
          title: Text(
            'Edit Task',
            style: AppStyle.fontStyle,
          ),
          leading: const HomeButton(),
          actions: [
            IconButton.filledTonal(
              color: AppColors.background,
              onPressed: () async {
                await ShowAlertDialog.showAlertDialog(context, index).then(
                  (value) => context.go(AppRoutes.home),
                );
              },
              icon: Icon(
                Icons.delete,
                color: AppColors.purple,
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
        body: FormWidget(
            func: () {
              context.read<TodoBloc>().add(
                    TodoChangeEvent(
                      index: index,
                      title: AppControllers.titleController.text,
                      text: AppControllers.textController.text,
                    ),
                  );
              context.go(AppRoutes.home);
            },
            btnName: 'Update')
        // Padding(
        //   padding: const EdgeInsets.symmetric(
        //     horizontal: 14,
        //   ),
        //   child: Column(
        //     children: [
        //       TextField(
        //         controller: AppControllers.titleController,
        //         decoration: InputDecoration(
        //           hintText: 'Title',
        //           hintStyle: AppStyle.fontStyle.copyWith(
        //             fontWeight: FontWeight.w400,
        //             fontSize: 16,
        //             color: AppColors.grey,
        //           ),
        //         ),
        //         maxLines: 5,
        //         minLines: 1,
        //       ),
        //       const SizedBox(height: 20),
        //       TextField(
        //         controller: AppControllers.textController,
        //         decoration: InputDecoration(
        //           hintText: 'Text',
        //           hintStyle: AppStyle.fontStyle.copyWith(
        //             fontWeight: FontWeight.w400,
        //             fontSize: 16,
        //             color: AppColors.grey,
        //           ),
        //         ),
        //         maxLines: 10,
        //         minLines: 1,
        //       ),
        //       const SizedBox(height: 20),
        //       SizedBox(
        //         width: double.infinity,
        //         child: ElevatedButton(
        //           style: ElevatedButton.styleFrom(
        //               backgroundColor: AppColors.purple,
        //               padding: const EdgeInsets.symmetric(vertical: 26),
        //               elevation: 0,
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(15),
        //               )),
        //           onPressed: () {
        //             context.read<TodoBloc>().add(
        //                   TodoChangeEvent(
        //                     index: index,
        //                     title: AppControllers.titleController.text,
        //                     text: AppControllers.textController.text,
        //                   ),
        //                 );
        //             context.go(AppRoutes.home);
        //           },
        //           child: Text(
        //             'Update',
        //             style: AppStyle.fontStyle.copyWith(fontSize: 20),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        );
  }
}

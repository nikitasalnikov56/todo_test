import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/domain/models/image_helper/image_helper.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: AppColors.white,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.purple,
                              padding: const EdgeInsets.all(20),
                            ),
                            onPressed: () {
                              context.read<TodoBloc>().add(
                                  TodoCameraEvent(ImageHelper.selectedImage));
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.camera_alt_rounded,
                              size: 35,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.purple,
                              padding: const EdgeInsets.all(20),
                            ),
                            onPressed: () {
                              context.read<TodoBloc>().add(
                                  TodoGalleryEvent(ImageHelper.selectedImage));
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.collections,
                              size: 35,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
            icon: Icon(
              Icons.camera_alt_rounded,
              size: 35,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FormWidget(
              btnName: 'Add',
              func: () async {
                context.read<TodoBloc>().add(
                      TodoAddEvent(
                        title: AppControllers.titleController.text,
                        text: AppControllers.textController.text,
                        selectedImage: ImageHelper.selectedImage,
                      ),
                    );
                context.go(AppRoutes.home);
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is AllTodoState && state.selectedImage != null) {
                  return Padding(
                    padding: const EdgeInsets.all(25),
                    child: SizedBox(
                      height: 350,
                      child: Image.file(state.selectedImage!),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/domain/models/app_controllers/app_controllers.dart';
import 'package:todo_list/ui/routes/app_routes.dart';
import 'package:todo_list/ui/style/app_colors.dart';
import 'package:todo_list/ui/style/app_style.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    super.key,
    required this.func,
    required this.btnName,
  });

  final Function func;
  final String btnName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(29, 43, 29, 43),
              child: TextFieldWidget(
                controller: AppControllers.titleController,
                hintText: 'Title',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 29),
              child: TextFieldWidget(
                controller: AppControllers.textController,
                hintText: 'Title',
              ),
            ),
            const SizedBox(height: 54),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.purple,
                    padding: const EdgeInsets.symmetric(vertical: 26),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                onPressed: () {
                  func();
                },
                child: Text(
                  btnName,
                  style: AppStyle.fontStyle.copyWith(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key, required this.controller, required this.hintText});
  final TextEditingController controller;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: 1,
      maxLines: 5,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyle.fontStyle.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: AppColors.grey,
        ),
      ),
    );
  }
}

class RowButtons extends StatelessWidget {
  const RowButtons({super.key, required this.updateFunc});
  final Function updateFunc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 26),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
              onPressed: () {
                updateFunc();
              },
              child: Text(
                'Update',
                style: AppStyle.fontStyle.copyWith(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(width: 46),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 26),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
              onPressed: () {
                context.go(AppRoutes.home);
              },
              child: Text(
                'Cancel',
                style: AppStyle.fontStyle.copyWith(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

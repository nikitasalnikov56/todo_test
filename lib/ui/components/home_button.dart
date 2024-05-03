import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/ui/routes/app_routes.dart';
import 'package:todo_list/ui/style/app_colors.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.go(AppRoutes.home);
      },
      icon: Icon(
        Icons.arrow_back_outlined,
        color: AppColors.white,
        size: 35,
      ),
    );
  }
}

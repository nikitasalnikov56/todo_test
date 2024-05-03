import 'package:flutter/material.dart';
import 'package:todo_list/ui/style/app_colors.dart';

abstract class AppStyle {
  static TextStyle fontStyle = TextStyle(
    color: AppColors.white,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );
}

import 'package:todo_list/domain/models/app_controllers/app_controllers.dart';

abstract class ClearController{
  static void contollersClear(){
    AppControllers.titleController.clear();
    AppControllers.textController.clear();
  }
}
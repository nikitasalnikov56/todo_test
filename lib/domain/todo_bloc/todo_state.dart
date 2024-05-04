part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoadingState extends TodoState {
  final List<NotesData> notes;
  TodoLoadingState({required this.notes});
}

class AllTodoState extends TodoState {
  final List<NotesData> notes;
 final File? selectedImage;
  AllTodoState({required this.notes, this.selectedImage});
}


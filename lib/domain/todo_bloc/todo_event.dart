part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class TodoLoadingEvent extends TodoEvent {}

class TodoAddEvent extends TodoEvent {
  final String title;
  final String text;
  final File? selectedImage;

  TodoAddEvent({required this.title, required this.text, this.selectedImage});
}

class TodoCameraEvent extends TodoEvent {
  final File? selectedImage;

  TodoCameraEvent(this.selectedImage);
}
class TodoGalleryEvent extends TodoEvent {
  final File? selectedImage;

  TodoGalleryEvent(this.selectedImage);
}

class TodoDeleteEvent extends TodoEvent {
  final int index;

  TodoDeleteEvent(this.index);
}

class TodoSetControllersEvent extends TodoEvent {
  final int index;
  TodoSetControllersEvent(this.index);
}

class TodoChangeEvent extends TodoEvent {
  final int index;
  final String title;
  final String text;
  final bool? isChecked;
   final File? selectedImage;
  TodoChangeEvent({
    required this.index,
    required this.title,
    required this.text,
     this.selectedImage,
    this.isChecked = false,
  });
}

class TodoSearchEvent extends TodoEvent {
  final String title;
  TodoSearchEvent({required this.title});
}

class TodoCheckEvent extends TodoEvent {
  final int index;
  final bool isChecked;
  final String title;
  final String text;
  TodoCheckEvent({
    required this.index,
    required this.isChecked,
    required this.title,
    required this.text,
  });
}

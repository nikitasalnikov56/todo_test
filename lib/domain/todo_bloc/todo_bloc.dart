import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todo_list/domain/database/hive/hive_box.dart';
import 'package:todo_list/domain/database/hive/notes_data.dart';
import 'package:todo_list/domain/models/app_controllers/app_controllers.dart';
import 'package:todo_list/domain/models/clear_controllers/clear_controllers.dart';
import 'package:todo_list/domain/models/image_helper/image_helper.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<TodoLoadingEvent>(_todoLoadingEvent);

    on<TodoAddEvent>(_todoAddEvent);

    on<TodoDeleteEvent>(_todoDeleteEvent);

    on<TodoSetControllersEvent>(_todoSetControllerEvent);

    on<TodoChangeEvent>(_todoChangeEvent);

    on<TodoCheckEvent>(_todoCheckEvent);

    on<TodoSearchEvent>(_todoSearchEvent);

    on<TodoCameraEvent>(_todoCameraEvent);
    on<TodoGalleryEvent>(_todoGalleryEvent);
  }

  Future<void> _todoGalleryEvent(
      TodoGalleryEvent event, Emitter<TodoState> emit) async {
    final selectedImage = await ImageHelper.pickImageFromGallery();
    if (selectedImage != null) {
      List<NotesData> allNotes = HiveBoxes.notes.values.toList();
      emit(AllTodoState(selectedImage: selectedImage, notes: allNotes));
    }
  }

  Future<void> _todoCameraEvent(
      TodoCameraEvent event, Emitter<TodoState> emit) async {
    final selectedImage = await ImageHelper.pickImageFromCamera();
    if (selectedImage != null) {
      List<NotesData> allNotes = HiveBoxes.notes.values.toList();
      emit(AllTodoState(selectedImage: selectedImage, notes: allNotes));
    }
  }

  Future<void> _todoSearchEvent(
      TodoSearchEvent event, Emitter<TodoState> emit) async {
    List<NotesData> allNotes = HiveBoxes.notes.values.toList();
    var filteredNotes = <NotesData>[];
    if (event.title.isNotEmpty) {
      filteredNotes = allNotes.where((item) {
        return item.title!.toLowerCase().contains(event.title.toLowerCase());
      }).toList();
    } else {
      filteredNotes = allNotes;
    }

    emit(
      AllTodoState(notes: filteredNotes),
    );
  }

  Future<void> _todoCheckEvent(
      TodoCheckEvent event, Emitter<TodoState> emit) async {
    await HiveBoxes.notes.putAt(
      event.index,
      NotesData(
        title: event.title.isNotEmpty ? event.title : 'Title',
        text: event.text.isNotEmpty ? event.text : 'Text',
        isChecked: event.isChecked,
      ),
    );
    List<NotesData> allNotes = HiveBoxes.notes.values.toList();
    emit(AllTodoState(notes: allNotes));
  }

  Future<void> _todoChangeEvent(
      TodoChangeEvent event, Emitter<TodoState> emit) async {
    final selectedImage = event.selectedImage;
    if (selectedImage != null) {
      await HiveBoxes.notes
          .putAt(
            event.index,
            NotesData(
              title: event.title.isNotEmpty ? event.title : 'Title',
              text: event.text.isNotEmpty ? event.text : 'Text',
              isChecked: event.isChecked ?? false,
              imagePath: selectedImage.path,
            ),
          )
          .then((value) => ClearController.contollersClear());
    } else {
      await HiveBoxes.notes
          .putAt(
            event.index,
            NotesData(
              title: event.title.isNotEmpty ? event.title : 'Title',
              text: event.text.isNotEmpty ? event.text : 'Text',
              isChecked: event.isChecked ?? false,
            ),
          )
          .then((value) => ClearController.contollersClear());
    }

    List<NotesData> allNotes = HiveBoxes.notes.values.toList();
    emit(AllTodoState(notes: allNotes));
  }

  Future<void> _todoSetControllerEvent(
      TodoSetControllersEvent event, Emitter<TodoState> emit) async {
    AppControllers.titleController.text =
        HiveBoxes.notes.getAt(event.index)?.title ?? '';

    AppControllers.textController.text =
        HiveBoxes.notes.getAt(event.index)?.text ?? '';
  }

  Future<void> _todoDeleteEvent(
      TodoDeleteEvent event, Emitter<TodoState> emit) async {
    await HiveBoxes.notes.deleteAt(event.index);

    List<NotesData> allNotes = HiveBoxes.notes.values.toList();

    emit(AllTodoState(notes: allNotes));
  }

  Future<void> _todoAddEvent(
      TodoAddEvent event, Emitter<TodoState> emit) async {
    final selectedImage = event.selectedImage;
    if (selectedImage != null) {
      await HiveBoxes.notes
          .add(
            NotesData(
              title: event.title.isNotEmpty ? event.title : 'Title',
              text: event.text.isNotEmpty ? event.text : 'Text',
              imagePath: selectedImage.path,
            ),
          )
          .then((value) => ClearController.contollersClear());
    } else {
      await HiveBoxes.notes
          .add(
            NotesData(
              title: event.title.isNotEmpty ? event.title : 'Title',
              text: event.text.isNotEmpty ? event.text : 'Text',
            ),
          )
          .then((value) => ClearController.contollersClear());
    }

    List<NotesData> allNotes = HiveBoxes.notes.values.toList();
    emit(AllTodoState(notes: allNotes));
  }

  Future<void> _todoLoadingEvent(
      TodoLoadingEvent event, Emitter<TodoState> emit) async {
    List<NotesData> allNotes = HiveBoxes.notes.values.toList();
    emit(TodoLoadingState(notes: allNotes));
  }
}

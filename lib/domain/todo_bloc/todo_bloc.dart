import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todo_list/domain/database/hive/hive_box.dart';
import 'package:todo_list/domain/database/hive/notes_data.dart';
import 'package:todo_list/domain/models/app_controllers/app_controllers.dart';
import 'package:todo_list/domain/models/clear_controllers/clear_controllers.dart';


part 'todo_event.dart';
part 'todo_state.dart';

enum PictureEvent { camera, gallery }

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<TodoLoadingEvent>(_todoLoadingEvent);

    on<TodoAddEvent>(_todoAddEvent);

    on<TodoDeleteEvent>(_todoDeleteEvent);

    on<TodoSetControllersEvent>(_todoSetControllerEvent);

    on<TodoChangeEvent>(_todoChangeEvent);

    on<TodoCheckEvent>(_todoCheckEvent);

    on<TodoSearchEvent>(_todoSearchEvent);
  
  }

  Future<void> _todoSearchEvent(event, emit) async {
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

  Future<void> _todoCheckEvent(event, emit) async {
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

  Future<void> _todoChangeEvent(event, emit) async {
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
    List<NotesData> allNotes = HiveBoxes.notes.values.toList();
    emit(AllTodoState(notes: allNotes));
  }

  Future<void> _todoSetControllerEvent(event, emit) async {
    AppControllers.titleController.text =
        HiveBoxes.notes.getAt(event.index)?.title ?? '';

    AppControllers.textController.text =
        HiveBoxes.notes.getAt(event.index)?.text ?? '';
  }

  Future<void> _todoDeleteEvent(event, emit) async {
    await HiveBoxes.notes.deleteAt(event.index);

    List<NotesData> allNotes = HiveBoxes.notes.values.toList();

    emit(AllTodoState(notes: allNotes));
  }

  Future<void> _todoAddEvent(event, emit) async {
    await HiveBoxes.notes
        .add(
          NotesData(
            title: event.title.isNotEmpty ? event.title : 'Title',
            text: event.text.isNotEmpty ? event.text : 'Text',
          ),
        )
        .then((value) => ClearController.contollersClear());

    List<NotesData> allNotes = HiveBoxes.notes.values.toList();
    emit(AllTodoState(notes: allNotes));
  }

  Future<void> _todoLoadingEvent(event, emit) async {
    List<NotesData> allNotes = HiveBoxes.notes.values.toList();
    emit(TodoLoadingState(notes: allNotes));
  }
}

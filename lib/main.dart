import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/domain/database/hive/notes_data.dart';
import 'package:todo_list/todo_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NotesDataAdapter());
  await Hive.openBox<NotesData>('notes');

  runApp(const TodoApp());
}

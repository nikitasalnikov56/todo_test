import 'package:hive/hive.dart';
import 'package:todo_list/domain/database/hive/notes_data.dart';

abstract class HiveBoxes {
  static final notes = Hive.box<NotesData>('notes');

}
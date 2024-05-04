import 'package:hive/hive.dart';

// flutter packages pub run build_runner build --delete-conflicting-outputs
part 'notes_data.g.dart';

@HiveType(typeId: 0)
class NotesData {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? text;

  @HiveField(2)
  bool isChecked;

  @HiveField(3)
  String? imagePath;

  NotesData({
    this.title,
    this.text,
    this.isChecked = false,
     this.imagePath,
  });
}

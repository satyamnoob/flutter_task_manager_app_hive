import 'package:hive/hive.dart';
part 'note.g.dart';

@HiveType(typeId: 1)
class Note extends HiveObject{

  @HiveField(0)
  final String id;
  
  @HiveField(1)
  String title;

  @HiveField(2)
  String note;

  @HiveField(3)
  bool isPinned;

  Note({
    required this.id,
    required this.title,
    required this.note,
    this.isPinned = false,
  });
}
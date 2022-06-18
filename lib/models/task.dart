import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject{

  @HiveField(0)
  final String id;
  
  @HiveField(1)
  String title;

  @HiveField(2)
  final DateTime createdOn;
  
  @HiveField(3)
  bool isDone;

  Task({
    required this.id,
    required this.title,
    required this.createdOn,
    this.isDone = false,
  });
}

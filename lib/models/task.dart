class Task {
  final String id;
  String title;
  final DateTime createdOn;
  bool isDone;

  Task({
    required this.id,
    required this.title,
    required this.createdOn,
    this.isDone = false,
  });
}

class Task {
  final String title;
  final String description;
  final DateTime? dueDate;
  bool isCompleted = false;
  bool isImportant;
  DateTime? trashTime;

  Task({
    required this.title,
    required this.description,
    this.dueDate,
    this.isImportant = false
  });
}
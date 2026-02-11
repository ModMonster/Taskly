class Task {
  final String title;
  final String description;
  final DateTime? dueDate;
  bool isCompleted = false;
  bool isImportant;
  DateTime? completionTime;

  Task({
    required this.title,
    required this.description,
    this.dueDate,
    this.isImportant = false
  });
}
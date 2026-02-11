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

  bool isOverdue() {
    if (dueDate == null) return false;
    return dueDate!.isBefore(DateTime.now().subtract(Duration(days: 1)));
  }
}
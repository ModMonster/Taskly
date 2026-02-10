class Task {
  final String title;
  final String? description;
  final DateTime? dueDate;
  bool isCompleted = false;

  Task({
    required this.title,
    this.description,
    this.dueDate
  });
}
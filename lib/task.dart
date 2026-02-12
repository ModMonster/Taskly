import 'package:intl/intl.dart';

class Task {
  String title;
  String description;
  DateTime? dueDate;
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
    if (isCompleted) return false;
    if (dueDate == null) return false;
    return dueDate!.isBefore(DateTime.now().subtract(Duration(days: 1)));
  }

  static String formatDueDate(DateTime? dueDate) {
    if (dueDate == null) return "";
    if (dueDate.year == DateTime.now().year) {
      return DateFormat("MMM d").format(dueDate);
    }
    return DateFormat("MMM d, yyyy").format(dueDate);
  }
}
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:taskly/task.dart';

class GenericTaskListTile extends StatelessWidget {
  final int index;
  final Task task;
  final Widget? trailing;
  const GenericTaskListTile(this.index, this.task, {this.trailing, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: task.description.isNotEmpty ? Text(task.description) : null,
      leading: IconButton(
        icon: Icon(
          task.isCompleted? Icons.check_box : Icons.check_box_outline_blank
        ),
        onPressed: () {
          toggleTaskCompleted(index, task);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              persist: false,
              behavior: SnackBarBehavior.floating,
              content: Text(task.isCompleted? "Task marked as complete" : "Task marked as incomplete"),
              action: SnackBarAction(
                label: "Undo",
                onPressed: () {
                  toggleTaskCompleted(index, task);
                },
              ),
            )
          );
        },
        tooltip: "Mark as completed",
      ),
      trailing: trailing
    );
  }
}

void toggleTaskCompleted(int index, Task task) {
  task.isCompleted = !task.isCompleted;
  task.completionTime = task.isCompleted? DateTime.now() : null;
  Hive.box("tasks").putAt(index, task);
}
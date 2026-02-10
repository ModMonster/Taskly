import 'package:flutter/material.dart';
import 'package:taskly/task.dart';

class TaskListTile extends StatelessWidget {
  final Task task;
  const TaskListTile(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: task.description != null ? Text(task.description!) : null,
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          // TODO: Handle checkbox change
          task.isCompleted = true;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Task marked as complete!"),
              action: SnackBarAction(
                label: "Undo",
                onPressed: () {
                  task.isCompleted = false;
                },
              ),
            )
          );
        },
      ),
    );
  }
}
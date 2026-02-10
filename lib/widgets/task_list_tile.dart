import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:taskly/task.dart';
import 'package:taskly/widgets/generic_task_list_tile.dart';

class TaskListTile extends StatelessWidget {
  final int index;
  final Task task;
  const TaskListTile(this.index, this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return GenericTaskListTile(
      index,
      task,
      trailing: IconButton(
        onPressed: () {
          task.isImportant = !task.isImportant;
          Hive.box("tasks").putAt(index, task);
        },
        icon: Icon(
          task.isImportant? Icons.label_important : Icons.label_important_outline
        ),
        tooltip: "Mark as important",
      ),
    );
  }
}
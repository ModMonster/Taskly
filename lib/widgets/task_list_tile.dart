import 'package:flutter/material.dart';
import 'package:taskly/task.dart';

class TaskListTile extends StatefulWidget {
  final Task task;
  const TaskListTile(this.task, {super.key});

  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.task.title),
      subtitle: widget.task.description != null ? Text(widget.task.description!) : null,
      leading: IconButton(
        icon: Icon(Icons.check_box_outline_blank),
        onPressed: () {
          // TODO: Handle checkbox change
          widget.task.isCompleted = true;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Task marked as completed"),
              action: SnackBarAction(
                label: "Undo",
                onPressed: () {
                  widget.task.isCompleted = false;
                },
              ),
            )
          );
        },
        tooltip: "Mark as completed",
      ),
      trailing: IconButton(
        onPressed: () {
          setState(() {
            widget.task.isImportant = !widget.task.isImportant;
          });
        },
        icon: Icon(
          widget.task.isImportant? Icons.label_important : Icons.label_important_outline
        ),
        tooltip: "Mark as important",
      ),
    );
  }
}
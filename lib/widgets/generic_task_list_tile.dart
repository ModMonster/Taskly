import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:taskly/task.dart';
import 'package:taskly/widgets/add_task.dart';

class GenericTaskListTile extends StatelessWidget {
  final int index;
  final Task task;
  final Widget? trailing;
  const GenericTaskListTile(this.index, this.task, {this.trailing, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(task.title),
          subtitle: task.description.isEmpty && task.dueDate == null? null : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: task.description.isNotEmpty,
                child: Text(
                  task.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Visibility(
                visible: task.dueDate != null,
                child: Container(
                  child: Chip(
                    avatar: Icon(Icons.calendar_month),
                    label: Text(formatDueDate(task.dueDate)),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              )
            ],
          ),
          isThreeLine: task.dueDate != null,
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
                  margin: EdgeInsets.only(
                    bottom: 10,
                    right: 10,
                    left: MediaQuery.of(context).size.width > 768? MediaQuery.of(context).size.width - 310 : 10
                  ),
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
        ),
      ],
    );
  }
}

void toggleTaskCompleted(int index, Task task) {
  task.isCompleted = !task.isCompleted;
  task.completionTime = task.isCompleted? DateTime.now() : null;
  Hive.box("tasks").putAt(index, task);
}
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:taskly/task.dart';
import 'package:taskly/widgets/auto_delete_box.dart';
import 'package:taskly/widgets/empty_page.dart';
import 'package:taskly/widgets/generic_task_list_tile.dart';
import 'package:taskly/widgets/scaffold.dart';

class CompletedPage extends StatelessWidget {
  const CompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Box box = Hive.box("tasks");
    final Box settingsBox = Hive.box("settings");

    return StreamBuilder(
      stream: settingsBox.watch(),
      builder: (context, snapshot) {
        return StreamBuilder(
          stream: box.watch(),
          builder: (context, snapshot) {
            int completed = 0;
            box.toMap().forEach((key, value) {
              if (value.isCompleted) completed++;
            });

            return ResponsiveScaffold(
              pageNumber: 1,
              appBar: AppBar(
                title: Text("Completed tasks"),
                actions: settingsBox.get("auto_delete", defaultValue: true)? null : [
                  TextButton(
                    onPressed: completed > 0? () => confirmDelete(context, completed) : null,
                    child: Text("Delete all"),
                  ),
                ],
              ),
              body: completed > 0? ListView.builder(
                itemCount: box.length + 1,
                itemBuilder: (context, index) {
                  // Auto-delete reminder box
                  if (index == 0) {
                    // Auto delete info box
                    if (!settingsBox.get("auto_delete", defaultValue: true)) return Container();
                    return AutoDeleteBox(completed);
                  }

                  Task task = box.getAt(index - 1);
                  if (!task.isCompleted) return Container();
                  return GenericTaskListTile(index - 1, task);
                }
              ) : Column(
                children: [
                  Visibility(
                    visible: settingsBox.get("auto_delete", defaultValue: true),
                    child: AutoDeleteBox(completed)
                  ),
                  Expanded(
                    child: EmptyPage(
                      icon: Icons.check_circle_outline,
                      text: "Nothing to see here!",
                    ),
                  ),
                ],
              )
            );
          }
        );
      }
    );
  }
}

String pluralize(int num) {
  if (num == 1) return "1 task";
  return "$num tasks";
}

void confirmDelete(BuildContext context, int completed) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Delete completed tasks?"),
      content: Text("${pluralize(completed)} will be permanently deleted."),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel")
        ),
        TextButton(
          onPressed: () {
            // Delete all tasks
            Hive.box("tasks").toMap().forEach((key, value) {
              if (value.isCompleted) {
                Hive.box("tasks").delete(key);
              }
            });

            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                margin: EdgeInsets.only(
                  bottom: 10,
                  left: MediaQuery.of(context).size.width > 768? 314 : 10,
                  right: MediaQuery.of(context).size.width > 768? MediaQuery.of(context).size.width - 624 : 10
                ),
                persist: false,
                behavior: SnackBarBehavior.floating,
                content: Text("${pluralize(completed)} permanently deleted"),
              )
            );
          },
          child: Text("Delete")
        )
      ],
    ));
  }
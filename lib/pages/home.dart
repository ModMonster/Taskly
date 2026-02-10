import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:taskly/task.dart';
import 'package:taskly/widgets/add_task.dart';
import 'package:taskly/widgets/auto_extend_fab.dart';
import 'package:taskly/widgets/scaffold.dart';
import 'package:taskly/widgets/task_list_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return ResponsiveScaffold(
      pageNumber: 0,
      appBar: AppBar(
        title: Text("All tasks"),
      ),
      floatingActionButton: AutoExtendedFab(
        icon: Icon(Icons.add),
        text: Text("Create"),
        tooltip: "Create",
        onPressed: () {
          if (screenSize.width >= 480) {
            SideSheet.right(
              context: context,
              width: 360,
              body: AddTaskModal(shrink: false)
            );
          } else {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: AddTaskModal(shrink: true),
                );
              },
              isScrollControlled: true
            );
          }
        },
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return TaskListTile(
            Task(
              title: "Task ${index + 1}",
              description: index % 2 == 0? null : "This is the description for task ${index + 1}"
            )
          );
        }
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
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
    final Box box = Hive.box("tasks");
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
              sheetColor: Theme.of(context).colorScheme.surfaceContainer,
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
      body: StreamBuilder(
        stream: box.watch(),
        builder: (context, snapshot) {
          int waiting = 0;
          box.toMap().forEach((key, value) {
            if (!value.isCompleted) waiting++;
          });

          if (waiting == 0) {
            return Align(
              alignment: Alignment(0, -0.25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 12,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 96,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  Text(
                    "You're all caught up!",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              Task task = box.getAt(index);
              if (task.isCompleted) return Container();
              return TaskListTile(index, task);
            }
          );
        }
      )
    );
  }
}
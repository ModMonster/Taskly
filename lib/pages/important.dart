import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:taskly/task.dart';
import 'package:taskly/widgets/scaffold.dart';
import 'package:taskly/widgets/task_list_tile.dart';

class ImportantPage extends StatelessWidget {
  const ImportantPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Box box = Hive.box("tasks");

    return ResponsiveScaffold(
      pageNumber: 2,
      appBar: AppBar(
        title: Text("Important tasks"),
      ),
      body: StreamBuilder(
        stream: box.watch(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              Task task = box.getAt(index);
              if (task.isCompleted || !task.isImportant) return Container();
              return TaskListTile(index, task);
            }
          );
        }
      )
    );
  }
}
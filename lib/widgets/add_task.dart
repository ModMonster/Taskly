import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:taskly/task.dart';

class AddTaskModal extends StatefulWidget {
  final bool shrink;
  AddTaskModal({super.key, required this.shrink});

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool isImportant = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: titleController,
                  autofocus: true,
                  decoration: InputDecoration(
                    label: Text("New task"),
                    focusColor: Colors.deepPurple[300]
                  ),
                  onChanged: (newValue) {
                    setState(() {});
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isImportant = !isImportant;
                  });
                },
                icon: Icon(
                  isImportant? Icons.label_important : Icons.label_important_outline
                ),
                tooltip: "Mark as important",
              )
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 8,
              children: [
                ActionChip(
                  label: Text("Description"),
                  avatar: Icon(Icons.add),
                  onPressed: () {
            
                  },
                ),
                ActionChip(
                  label: Text("Due date"),
                  avatar: Icon(Icons.add),
                  onPressed: () {
            
                  },
                )
              ],
            ),
          ),
          widget.shrink? Container() : Spacer(),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: OutlinedButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  }
                ),
              ),
              Expanded(
                child: FilledButton(
                  child : Text("Create"),
                  onPressed: titleController.text.isEmpty? null : () {
                    // Add task to storage
                    Hive.box("tasks").add(new Task(
                      title: titleController.text,
                      description: descriptionController.text
                    ));
                    Navigator.pop(context);
                  }
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Create Task",
            style: TextStyle(
              fontSize: 20
            )
          ),
          SizedBox(height: 24),
          TextField(
            controller: titleController,
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Title"),
              focusColor: Colors.deepPurple[300]
            ),
            onChanged: (newValue) {
              setState(() {});
            },
          ),
          SizedBox(height: 12),
          TextField(
            controller: descriptionController,
            minLines: 3,
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Description"),
              focusColor: Colors.deepPurple[300]
            ),
          ),
          widget.shrink? SizedBox(height: 24) : Spacer(),
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
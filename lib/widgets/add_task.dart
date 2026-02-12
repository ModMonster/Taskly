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
  final FocusNode descriptionFocusNode = FocusNode();

  bool isImportant = false;
  bool hasDescription = false;
  DateTime? dueDate = null;

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
          Visibility(
            visible: hasDescription,
            child: TextField(
              controller: descriptionController,
              focusNode: descriptionFocusNode,
              maxLines: 3,
              minLines: 3,
              decoration: InputDecoration(
                label: Text("Description"),
                border: OutlineInputBorder()
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Visibility(
                  visible: !hasDescription,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ActionChip(
                      label: Text("Description"),
                      avatar: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          hasDescription = true;
                          descriptionFocusNode.requestFocus(); // Focus the description field
                        });
                      },
                    ),
                  ),
                ),
                ActionChip(
                  label: Text(
                    dueDate != null? Task.formatDueDate(dueDate!) : "Due date"
                  ),
                  avatar: Icon(
                    dueDate != null? Icons.calendar_month : Icons.add
                  ),
                  onPressed: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: dueDate == null? DateTime.now().add(Duration(days: 1)) : dueDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now().add(Duration(days: 365*1000))
                    );
                    if (date == null) return;

                    setState(() {
                      this.dueDate = date;
                    });
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
                      description: descriptionController.text,
                      isImportant: isImportant,
                      dueDate: dueDate
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
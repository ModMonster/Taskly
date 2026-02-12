import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:intl/intl.dart';
import 'package:taskly/task.dart';

class TaskPage extends StatefulWidget {
  final int index;
  final Task task;
  TaskPage(this.index, this.task, {super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool deleted = false;

  @override
  void initState() {
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (deleted) return;
        widget.task.title = _titleController.text; // Update the title
        widget.task.description = _descriptionController.text; // Update the description
        // Post to database
        Hive.box("tasks").putAt(widget.index, widget.task);
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _titleController,
            onTapOutside: (PointerDownEvent event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)
              )
            ),
            style: Theme.of(context).textTheme.titleLarge
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  widget.task.isImportant = !widget.task.isImportant;
                });
              },
              icon: widget.task.isImportant? Icon(Icons.label_important) : Icon(Icons.label_important_outline),
              tooltip: "Mark as important",
            ),
            IconButton(
              onPressed: () {
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    title: Text("Delete task"),
                    content: Text("Are you sure you want to delete this task?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async {
                          deleted = true;
                          Hive.box("tasks").deleteAt(widget.index);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text("Delete"),
                      ),
                    ],
                  );
                });
              },
              icon: Icon(Icons.delete),
              tooltip: "Delete task",
            ),
          ],
        ),
        body: Column(
          children: [
            widget.task.isCompleted? Row(
              spacing: 6,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle_outline),
                Text("Completed on " + DateFormat("MMM d, yyyy 'at' h:mm a").format(widget.task.completionTime!)),
              ],
            ) : Container(),
            ListTile(
              title: TextField(
                controller: _descriptionController,
                maxLines: null,
                onTapOutside: (PointerDownEvent event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                decoration: InputDecoration(
                  hintText: "Add description",
                  border: InputBorder.none,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)
                  )
                ),
              ),
              leading: Icon(Icons.notes),
            ),
            ListTile(
              title: widget.task.dueDate != null? Text(
                "Due on ${Task.formatDueDate(widget.task.dueDate)}"
              ) : Text(
                "Add due date",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant
                ),
              ),
              subtitle: widget.task.isOverdue()? Text(
                "Overdue",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error
                ),
              ) : null,
              leading: Icon(Icons.calendar_month),
              onTap: () async {
                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: widget.task.dueDate == null? DateTime.now().add(Duration(days: 1)) : widget.task.dueDate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now().add(Duration(days: 365*1000))
                );
                if (date == null) return;
      
                setState(() {
                  widget.task.dueDate = date;
                });
              }
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.task.isCompleted = !widget.task.isCompleted;
                    widget.task.completionTime = widget.task.isCompleted? DateTime.now() : null;
                  });
                },
                child: Text(widget.task.isCompleted? "Mark as uncompleted" : "Mark as completed"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
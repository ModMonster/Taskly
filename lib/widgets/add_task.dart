import 'package:flutter/material.dart';

class AddTaskModal extends StatelessWidget {
  final bool shrink;
  const AddTaskModal({super.key, required this.shrink});

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
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Title"),
              focusColor: Colors.deepPurple[300]
            ),
          ),
          SizedBox(height: 12),
          TextField(
            minLines: 3,
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Description"),
              focusColor: Colors.deepPurple[300]
            ),
          ),
          shrink? SizedBox(height: 24) : Spacer(),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: OutlinedButton(
                  child: Text(
                    "Cancel"
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }
                ),
              ),
              Expanded(
                child: FilledButton(
                  child : Text("Create"),
                  onPressed: () {
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
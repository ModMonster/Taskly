import 'package:flutter/material.dart';
import 'package:taskly/pages/completed.dart';

class AutoDeleteBox extends StatelessWidget {
  final int completed;
  const AutoDeleteBox({this.completed = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(Icons.check_circle_outline),
          title: Text("Tasks that have been marked as complete for more than 30 days will be deleted automatically."),
          titleTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)
        ),
        Padding(
          padding: const EdgeInsets.only(left: 54),
          child: OutlinedButton(
            onPressed: completed > 0? () => confirmDelete(context, completed) : null,
            child: Text("Delete all now"),
          ),
        ),
      ],
    );
  }
}
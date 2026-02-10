import 'package:flutter/material.dart';
import 'package:taskly/task.dart';
import 'package:taskly/widgets/scaffold.dart';

class TrashPage extends StatelessWidget {
  const TrashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      pageNumber: 3,
      appBar: AppBar(
        title: Text("Trash"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(context: context, builder: (context) => AlertDialog(
                title: Text("Empty trash?"),
                content: Text("10 tasks will be permanently deleted."), // TODO: replace with actual number
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")
                  ),
                  TextButton(
                    onPressed: () {

                    },
                    child: Text("Empty")
                  )
                ],
              ));
            },
            icon: Icon(Icons.delete_forever)
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.delete_outline),
            subtitle: Text("Items that have been in Trash more than 30 days will be deleted automatically."),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 54),
            child: OutlinedButton(
              onPressed: () {
                showDialog(context: context, builder: (context) => AlertDialog(
                  title: Text("Empty trash?"),
                  content: Text("10 tasks will be permanently deleted."), // TODO: replace with actual number
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel")
                    ),
                    TextButton(
                      onPressed: () {
            
                      },
                      child: Text("Empty")
                    )
                  ],
                ));
              },
              child: Text("Empty trash now"),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                Task t = Task(
                  title: "Task ${index + 1}",
                  description: index % 2 == 0? null : "This is the description for task ${index + 1}"
                );
                return ListTile(
                  title: Text(t.title),
                  subtitle: t.description != null? Text(t.description!) : null,
                );
              }
            ),
          ),
        ],
      )
    );
  }
}
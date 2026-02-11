import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:taskly/hive/hive_registrar.g.dart';
import 'package:taskly/pages/completed.dart';
import 'package:taskly/pages/home.dart';
import 'package:taskly/pages/important.dart';
import 'package:taskly/pages/settings.dart';
import 'package:taskly/task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapters();
  await Hive.openBox("tasks");
  await Hive.openBox("settings");

  clearExpiredTasks();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Box box = Hive.box("settings");

    return StreamBuilder(
      stream: box.watch().where((event) => {"theme"}.contains(event.key)),
      builder: (context, snapshot) {
        return MaterialApp(
          themeMode: ThemeMode.values[box.get("theme", defaultValue: 0)],
          theme: ThemeData(
            colorSchemeSeed: Colors.purple
          ),
          darkTheme: ThemeData(
            colorSchemeSeed: Colors.purple,
            brightness: Brightness.dark
          ),
          title: "Taskly",
          routes: {
            "/": (context) => HomePage(),
            "/settings": (context) => SettingsPage(),
            "/completed": (context) => CompletedPage(),
            "/important": (context) => ImportantPage(),
          },
        );
      },
    );
  }
}

void showTasklyAboutDialog(BuildContext context) {
  showAboutDialog(
    context: context,
    applicationName: "Taskly",
    applicationVersion: "1.0.0",
    applicationIcon: Icon(Icons.task),
    children: [
      Text("Taskly is a simple task management app built with Flutter.")
    ]
  );
}

// Empty any tasks that have been completed for 30+ days
void clearExpiredTasks() {
  // Don't do anything if user turned this feature off
  if (!Hive.box("settings").get("auto_delete", defaultValue: true)) return;

  final Box box = Hive.box("tasks");
  final List keysToDelete = [];
  for (var key in box.keys) {
    final Task task = box.get(key);
    if (task.isCompleted && DateTime.now().difference(task.completionTime!).inDays >= 30) {
      keysToDelete.add(key);
    }
  }
  box.deleteAll(keysToDelete);
}
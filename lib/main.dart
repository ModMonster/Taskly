import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:taskly/pages/home.dart';
import 'package:taskly/pages/settings.dart';
import 'package:taskly/widgets/scaffold.dart';

late final StreamingSharedPreferences preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await StreamingSharedPreferences.instance;

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
    return PreferenceBuilder(
      preference: preferences.getInt("theme", defaultValue: 0),
      builder: (context, value) {
        return MaterialApp(
          themeMode: ThemeMode.values[value],
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
            "/completed": (context) => ResponsiveScaffold(pageNumber: 1, appBar: AppBar(title: Text("Completed tasks")), body: Container(color: Colors.orange)),
            "/important": (context) =>  ResponsiveScaffold(pageNumber: 2, appBar: AppBar(title: Text("Important tasks")), body: Container(color: Colors.yellow)),
            "/trash": (context) =>  ResponsiveScaffold(pageNumber: 3, appBar: AppBar(title: Text("Trash")), body: Container(color: Colors.red)),
          },
        );
      },
    );
  }
}
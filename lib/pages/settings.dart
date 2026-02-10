import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:taskly/main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Preference<int> theme = preferences.getInt("theme", defaultValue: 0);

  String getCurrentThemeName() {
    switch (theme.getValue()) {
      case 1:
        return "Light";
      case 2:
        return "Dark";
      default:
        return "System default";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Theme"),
            subtitle: Text(getCurrentThemeName()),
            leading: Icon(Icons.palette_outlined),
            onTap: () {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title: Text("Choose theme"),
                  contentPadding: EdgeInsets.only(top: 8.0),
                  content: StatefulBuilder(
                    builder: (context, setState2) {
                      return RadioGroup(
                        groupValue: theme.getValue(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState2(() {
                            theme.setValue(value.toInt());
                            themeNotifier.value = ThemeMode.values[value];
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RadioListTile(
                              value: 1,
                              title: Text("Light"),
                            ),
                            RadioListTile(
                              value: 2,
                              title: Text("Dark"),
                            ),
                            RadioListTile(
                              value: 0,
                              title: Text("System default"),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK")
                    )
                  ],
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
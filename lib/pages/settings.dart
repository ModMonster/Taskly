import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:taskly/main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String getCurrentThemeName() {
    switch (Hive.box("settings").get("theme")) {
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
    final Box box = Hive.box("settings");

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
                      // Putting this directly in doesn't work.
                      // Do not ask me why, I have literally no idea.
                      int val = box.get("theme", defaultValue: 0);
                      
                      return RadioGroup(
                        groupValue: val,
                        onChanged: (value) {
                          if (value == null) return;
                          setState2(() {
                            box.put("theme", value);
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
          SwitchListTile(
            secondary: Icon(Icons.delete_outline),
            title: Text("Auto-delete completed tasks"),
            subtitle: Text(
              box.get("auto_delete", defaultValue: true)?
                "Tasks will be deleted after 30 days" :
                "Tasks will only be deleted manually"
            ),
            value: box.get("auto_delete", defaultValue: true),
            onChanged: (value) {
              setState(() {
                box.put("auto_delete", value);
              });
            }
          ),
          Divider(),
          ListTile(
            title: Text("About Taskly"),
            leading: Icon(Icons.info_outline),
            onTap: () {
              showTasklyAboutDialog(context);
            }
          )
        ],
      ),
    );
  }
}
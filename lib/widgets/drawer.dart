import 'package:flutter/material.dart';
import 'package:taskly/main.dart';
import 'package:taskly/widgets/drawer_list_tile.dart';

class CustomDrawer extends StatelessWidget {
  final bool isCollapsed;
  final double? elevation;
  final int selectedIndex;
  const CustomDrawer({super.key, this.isCollapsed = true, this.elevation, this.selectedIndex = -1});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: elevation,
      child: Padding(
        padding: MediaQuery.of(context).padding,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              isCollapsed? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 22
                ),
                child: Row(
                  spacing: 12,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/icon.png",
                      ),
                      radius: 18,
                    ),
                    Text(
                      "Taskly",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ],
                ),
              ) : SizedBox(height: 10),
              DrawerListTile(
                leading: Icon(Icons.topic),
                title: const Text("All tasks"),
                selected: selectedIndex == 0,
                onTap: () => Navigator.pushReplacementNamed(context, "/")
              ),
              DrawerListTile(
                leading: Icon(Icons.check_circle),
                title: const Text("Completed"),
                selected: selectedIndex == 1,
                onTap: () => Navigator.pushReplacementNamed(context, "/completed")
              ),
              DrawerListTile(
                leading: Icon(Icons.label_important),
                title: const Text("Important"),
                selected: selectedIndex == 2,
                onTap: () => Navigator.pushReplacementNamed(context, "/important")
              ),
              Spacer(),
              DrawerListTile(
                leading: Icon(Icons.settings),
                title: const Text("Settings"),
                onTap: () {
                  if (isCollapsed) Navigator.pop(context); // close drawer
                  Navigator.pushNamed(context, "/settings");
                }
              ),
              DrawerListTile(
                leading: Icon(Icons.info),
                title: const Text("About Taskly"),
                onTap: () {
                  if (isCollapsed) Navigator.pop(context); // close drawer
                  showTasklyAboutDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
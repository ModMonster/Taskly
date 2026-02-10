import 'package:flutter/material.dart';
import 'package:taskly/widgets/drawer.dart';


class ResponsiveScaffold extends StatelessWidget {
  final AppBar? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final int pageNumber;
  const ResponsiveScaffold({super.key, this.appBar, required this.body, this.floatingActionButton, required this.pageNumber});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      drawer: screenSize.width < 768? CustomDrawer(selectedIndex: pageNumber) : null,
      appBar: appBar,
      body: screenSize.width >= 768? Row(
        children: [
          CustomDrawer(showHeader: false, elevation: 0, selectedIndex: pageNumber),
          VerticalDivider(
            width: 1,
            thickness: 1,
          ),
          body
        ]
      ) : body,
      floatingActionButton: floatingActionButton
    );
  }
}
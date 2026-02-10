import 'package:flutter/material.dart';

class AutoExtendedFab extends StatelessWidget {
  final Widget icon;
  final Widget text;
  final String? tooltip;
  final void Function() onPressed;
  
  const AutoExtendedFab({super.key, required this.icon, required this.text, this.tooltip, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return screenSize.width >= 768? FloatingActionButton.extended(
      label: text,
      icon: icon,
      onPressed: onPressed,
    ) : FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      child: icon,
    );
  }
}
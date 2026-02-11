import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final bool selected;
  final void Function()? onTap;

  const DrawerListTile({super.key, this.leading, this.title, this.onTap, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: selected? Theme.of(context).colorScheme.surfaceContainerHighest : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      leading: leading,
      title: title,
      onTap: onTap,
    );
  }
}
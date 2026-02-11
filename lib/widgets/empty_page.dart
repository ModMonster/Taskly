import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  final String? text;
  final IconData? icon;
  const EmptyPage({this.text, this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, -0.25),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            icon != null? Icon(
              icon,
              size: 96,
              color: Theme.of(context).colorScheme.secondary,
            ) : Container(),
            text != null? Text(
              text!,
              style: TextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ) : Container()
          ],
        ),
      ),
    );
  }
}
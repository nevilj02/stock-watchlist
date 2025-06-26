import 'package:flutter/material.dart';

class DialogWrapper extends StatelessWidget {
  final Widget child;
  final String? title;

  const DialogWrapper({required this.child, this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Column(
                children: [
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            child,
          ],
        ),
      ),
    );
  }
} 
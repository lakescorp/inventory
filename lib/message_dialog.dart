import 'package:flutter/material.dart';

class MessageDialog extends StatelessWidget {
  final String title;
  final String message;
  final String firstButtonName;
  final String? secondButtonName;
  final IconData icon;
  final VoidCallback onFirstButton;
  final VoidCallback? onSecondButton;

  const MessageDialog({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    required this.onFirstButton,
    this.onSecondButton,
    required this.firstButtonName,
    this.secondButtonName,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Icon(
        icon,
        size: 50,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          
          children: [
            ElevatedButton(
              onPressed: onFirstButton,
              child: Text(firstButtonName),
            ),
            if (secondButtonName != null)
              ElevatedButton(
                onPressed: onSecondButton,
                child: Text(secondButtonName!),
              ),
          ],
        ),
      ],
    );
  }
}

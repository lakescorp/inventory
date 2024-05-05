import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String title;
  final String message;
  final String firstButtonName;
  final String? secondButtonName;
  final IconData icon;
  final VoidCallback onFirstButton;
  final VoidCallback? onSecondButton;

  const ErrorMessage({
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
    return Container(
      constraints: const BoxConstraints(minHeight: 200),
      width: 400,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: onFirstButton,
                    child: Text(firstButtonName),
                  ),
                  const SizedBox(width: 10),
                  secondButtonName != null
                      ? ElevatedButton(
                          onPressed: onSecondButton,
                          child: Text(secondButtonName!),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ErrorUI extends StatelessWidget {
  final String message;
  final String secondaryMessage;
  final Function()? onRetry;

  const ErrorUI({
    super.key,
    required this.message,
    required this.secondaryMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(
              fontSize: 28,
              height: 1.2,
              fontWeight: FontWeight.w300,
              fontFamily: 'Rubik',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            secondaryMessage,
            style: const TextStyle(
              fontSize: 20,
              height: 1.2,
              fontWeight: FontWeight.w300,
              fontFamily: 'Rubik',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          if (onRetry != null)
            ElevatedButton(
              onPressed: onRetry,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Colors.purple[900]!,
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                fixedSize: WidgetStateProperty.all(
                  Size(size.width * 0.8, 50),
                ),
              ),
              child: const Text(
                'Retry',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

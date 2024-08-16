import 'package:flutter/material.dart';

class RetryError extends StatelessWidget {
  const RetryError({super.key, required this.onRetry, required this.message});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 48),
          const SizedBox(height: 8),
          Text('An error occurred', style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(message, style: textTheme.bodySmall),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

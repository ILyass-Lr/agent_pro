import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RedirectionText extends StatelessWidget {
  const RedirectionText({
    super.key,
    required this.label,
    required this.redirectionText,
    required this.path,
  });

  final String label, redirectionText, path;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const white = Colors.white;
    final textTheme = theme.textTheme;
    return Row(
      mainAxisAlignment: .center,
      mainAxisSize: .max,
      children: [
        Text(label, style: textTheme.bodySmall!.copyWith(color: white)),
        TextButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            context.go(path);
          },

          child: Text(
            redirectionText,
            style: textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.inversePrimary,
              decoration: TextDecoration.underline,
              decorationColor: Theme.of(context).colorScheme.inversePrimary,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

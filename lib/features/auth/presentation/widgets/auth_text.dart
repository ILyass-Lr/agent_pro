import 'package:flutter/material.dart';

class AuthText extends StatelessWidget {
  const AuthText({required this.title, required this.subtitle, super.key});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const white = Colors.white;
    final textTheme = theme.textTheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,

        spacing: 8,
        children: [
          Text(
            title,
            style: textTheme.headlineLarge!.copyWith(color: white).apply(fontWeightDelta: 2),
          ),
          Text(subtitle, style: textTheme.bodyMedium!.copyWith(color: white)),
        ],
      ),
    );
  }
}

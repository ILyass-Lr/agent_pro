import 'package:flutter/material.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({super.key, required this.icon, required this.title, this.subtitle});
  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Container(
      // width: double.infinity,
      //height: 1,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorScheme.inverseSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: .start,

        spacing: 8,
        children: [
          Icon(icon, color: colorScheme.inversePrimary, size: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium!.copyWith(
                    color: colorScheme.inversePrimary,
                    height: 1.3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    subtitle!,
                    style: textTheme.bodySmall!.copyWith(color: colorScheme.inversePrimary),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

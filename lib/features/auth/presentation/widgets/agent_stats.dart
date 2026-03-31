import 'package:flutter/material.dart';

class AgentStats extends StatelessWidget {
  const AgentStats({
    required this.statsTitle,
    required this.statsValue,
    this.selected = false,
    super.key,
  });
  final String statsTitle;
  final String statsValue;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    const borderRadius = 24.0;
    const borderWidth = 5.0;

    return CustomPaint(
      painter: const _DualGradientBorderPainter(
        borderRadius: borderRadius,
        strokeWidth: borderWidth,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .start,
          mainAxisSize: .max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: .start,
              children: [
                Text(
                  statsTitle,
                  style: textTheme.labelSmall?.copyWith(
                    color: selected ? colorScheme.inversePrimary : colorScheme.onInverseSurface,
                  ),
                ),
                Text(
                  statsValue,
                  style: textTheme.headlineMedium?.copyWith(
                    color: selected ? colorScheme.inversePrimary : colorScheme.onInverseSurface,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.double_arrow_outlined,
              color: selected ? colorScheme.inversePrimary : colorScheme.surfaceContainer,
            ),
          ],
        ),
      ),
    );
  }
}

class _DualGradientBorderPainter extends CustomPainter {
  const _DualGradientBorderPainter({required this.borderRadius, required this.strokeWidth});

  final double borderRadius;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(
      rect.deflate(strokeWidth / 2),
      Radius.circular(borderRadius),
    );

    final gradientA = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0x80FFFFFF), Color(0x00FFFFFF)],
      ).createShader(rect);

    final gradientB = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0x00FFFFFF), Color(0x80FFFFFF)],
      ).createShader(rect);

    canvas.drawRRect(rrect, gradientA);
    canvas.drawRRect(rrect, gradientB);
  }

  @override
  bool shouldRepaint(covariant _DualGradientBorderPainter oldDelegate) {
    return oldDelegate.borderRadius != borderRadius || oldDelegate.strokeWidth != strokeWidth;
  }
}

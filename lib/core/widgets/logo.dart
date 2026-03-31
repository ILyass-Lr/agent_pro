import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Column(
      spacing: 16,
      children: [
        RichText(
          text: TextSpan(
            text: 'Agent',
            style: textTheme.displayLarge?.apply(
              fontWeightDelta: 2,
              color: colorScheme.inversePrimary,
            ),
            children: [
              TextSpan(
                text: 'Pro',
                style: textTheme.displayLarge?.apply(
                  fontWeightDelta: 2,
                  color: colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.outline),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.only(left: 8, right: 16, top: 6, bottom: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              SvgPicture.asset(
                'assets/icons/fifa_verified.svg',
                height: 18,
                colorFilter: ColorFilter.mode(colorScheme.inversePrimary, BlendMode.srcIn),
              ),
              Text(
                'PLATEFORME CERTIFIFIÉE FIFA',
                style: textTheme.labelMedium!
                    .copyWith(color: Colors.white)
                    .apply(fontWeightDelta: 1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

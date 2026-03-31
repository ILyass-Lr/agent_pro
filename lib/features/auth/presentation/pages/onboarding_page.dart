import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.iconPath,
  });

  final String title;
  final String description;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Column(
      children: [
        SizedBox(height: height * 0.13),
        SvgPicture.asset(
          iconPath,
          height: 360,
          colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
        ),

        const Expanded(child: SizedBox()),
        Container(
          height: 295,
          padding: const EdgeInsets.fromLTRB(32, 40, 32, 32),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(128),
              topRight: Radius.circular(128),
            ),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: textTheme.headlineMedium?.apply(fontWeightDelta: 2),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(description, style: textTheme.bodyLarge, textAlign: TextAlign.center),
            ],
          ),
        ),
      ],
    );
  }
}

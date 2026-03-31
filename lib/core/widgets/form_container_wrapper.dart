import 'package:flutter/material.dart';

class FormContainerWrapper extends StatelessWidget {
  const FormContainerWrapper({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline, width: 1),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(152, 0, 17, 0.6),
            Color.fromRGBO(239, 68, 68, 0.3),
            Color.fromRGBO(152, 0, 17, 0.6),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(64),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: child,
      ),
    );
  }
}

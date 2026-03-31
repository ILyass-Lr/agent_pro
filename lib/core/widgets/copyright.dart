import 'package:flutter/material.dart';

class Copyright extends StatelessWidget {
  const Copyright({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '© ${DateTime.now().year} AgentPro · Certifié FIFA · Technologie',
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
      textAlign: TextAlign.center,
    );
  }
}

import 'package:flutter/material.dart';

class BackgroundWrapper extends StatelessWidget {
  const BackgroundWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset('assets/images/bg.jpg', fit: BoxFit.cover)),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.25),
                    const Color.fromRGBO(69, 10, 10, 0.3),
                    Colors.black.withValues(alpha: 0.25),
                  ],
                  begin: const Alignment(-0.3, -1),
                  end: const Alignment(0.3, 1),
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

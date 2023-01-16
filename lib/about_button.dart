import 'package:flutter/material.dart';
import 'package:zphos/about_page.dart';

class AboutButton extends StatelessWidget {
  const AboutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                opaque: false,
                pageBuilder: (BuildContext context, _, __) {
                  return const AboutPage();
                },
                transitionsBuilder:
                    (___, Animation<double> animation, ____, Widget child) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: CurvedAnimation(
                        parent: Tween<double>(begin: 1.0, end: 1.0)
                            .animate(animation),
                        curve: Curves.easeInCirc,
                      ),
                      child: child,
                    ),
                  );
                }));
      },
      child: const Text(
        'About',
        // style: TextStyle(color: Colors.white),
      ),
    );
  }
}

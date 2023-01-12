import 'package:flutter/material.dart';
import 'package:zphos/about_button.dart';
import 'package:zphos/about_page.dart';
import 'package:curved_gradient/curved_gradient.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade400.withAlpha(200),
        backgroundBlendMode: BlendMode.difference,
      ),
      // gradient: CurvedGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     colors: [Colors.grey[400]!, Colors.transparent],
      //     granularity: 2,
      //     curveGenerator: ((p0) => Curves.elasticIn.transform(p0)))),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Row(
          children: [
            TextButton(
              child: Text(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                title,
              ),
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
            ),
            const Spacer(),
            ButtonBar(
              children: [
                AboutButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

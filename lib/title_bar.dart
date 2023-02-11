import 'package:flutter/material.dart';
import 'package:zphos/main.dart';

// class TitleBar extends StatefulWidget {
//   const TitleBar({super.key, required this.title});

//   final String title;

//   @override
//   State<TitleBar> createState() => _TitleBarState();
// }

class TitleBar extends StatelessWidget {
  final String title;
  final void Function() onMenuPressed;

  const TitleBar({super.key, required this.title, required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withAlpha(200),
        // backgroundBlendMode: BlendMode.difference,
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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryTextTheme.titleLarge!.color,
                ),
                title,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        const MyHomePage(title: 'ZPHOS'),
                    transitionDuration: Duration.zero,
                  ),
                );
                // Navigator.pushNamed(context, '/');
              },
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: onMenuPressed,
            ),
            // const ButtonBar(
            //   children: [
            //     AboutButton(),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

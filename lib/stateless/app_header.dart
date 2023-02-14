import 'package:flutter/material.dart';
import 'package:zphos/app_strings.dart';
import 'package:zphos/screens/homepage.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final void Function() onMenuPressed;

  const AppHeader(
      {super.key, required this.title, required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withAlpha(200),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Row(
          children: [
            ButtonBar(
              children: [
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: onMenuPressed,
                ),
                // TextButton(
                //     onPressed: () {
                //       Navigator.pushNamed(context, '/posts');
                //     },
                //     child: const Text('Posts')),
              ],
            ),
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
                        const MyHomePage(title: AppStrings.appName),
                    transitionDuration: Duration.zero,
                  ),
                );
                // Navigator.pushNamed(context, '/');
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zphos/app_strings.dart';
import 'package:zphos/path.dart';
import 'package:zphos/screens/homepage.dart';
import 'package:zphos/screens/post.dart';

List<Path> paths = [
  Path(
    '/',
    (context, path) => const MyHomePage(title: 'ZPHOS'),
  ),
  Path(
    '/post/(.*)/(.*)',
    (context, path) => const Post(),
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        fontFamily: 'NunitoSans',
        primarySwatch: Colors.grey,
        brightness:
            MediaQueryData.fromView(View.of(context)).platformBrightness,
      ),
      home: const MyHomePage(title: AppStrings.appName),
      onGenerateRoute: (settings) {
        Uri uri = Uri.parse(settings.name!);
        if (uri.path == '/post') {
          return MaterialPageRoute(
            builder: (context) => const Post(),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}

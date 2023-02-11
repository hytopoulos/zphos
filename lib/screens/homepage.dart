import 'package:flutter/material.dart';
import 'package:zphos/stateless/app_footer.dart';
import 'package:zphos/stateless/future_markdown_view.dart';
import 'package:zphos/stateful/sidebar.dart';
import 'package:zphos/stateless/title_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          key: _scaffoldKey,
          drawer: const SideBar(),
          body: Stack(
            children: [
              Center(
                child: Column(
                  children: const [
                    FutureMarkdownView(id: "homepage", isStatic: true),
                    AppFooter(),
                  ],
                ),
              ),
              TitleBar(
                  title: widget.title,
                  onMenuPressed: () {
                    setState(() {
                      _scaffoldKey.currentState!.openDrawer();
                    });
                  }),
            ],
          ),
        ),
      ],
    );
  }
}

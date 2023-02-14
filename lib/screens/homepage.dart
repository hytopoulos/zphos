import 'package:flutter/material.dart';
import 'package:zphos/app_style.dart';
import 'package:zphos/stateless/app_footer.dart';
import 'package:zphos/stateless/future_markdown_view.dart';
import 'package:zphos/stateful/sidebar.dart';
import 'package:zphos/stateless/app_header.dart';

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
              ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    padding: AppStyle.withTheme(context).kDefaultPagePadding,
                    child: const FutureMarkdownView(
                        id: 'homepage', isStatic: true),
                  ),
                  const AppFooter(),
                ],
              ),
              AppHeader(
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

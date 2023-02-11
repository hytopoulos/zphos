import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zphos/future_markdown_view.dart';
import 'package:zphos/hyperlink_button.dart';
import 'package:zphos/sidebar.dart';
import 'package:zphos/title_bar.dart';

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
    const String githubUrl = "https://github.com/notyourav";
    const String linkedinUrl =
        "https://www.linkedin.com/in/theo-hytopoulos-066392207/";
    const String twitterUrl = "https://twitter.com/pokeprotos";

    return Stack(
      children: [
        Scaffold(
          key: _scaffoldKey,
          drawer: const SideBar(),
          body: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Expanded(
                            child: FutureMarkdownView(
                                id: "homepage", isStatic: true),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              HyperlinkButton(
                                  url: linkedinUrl,
                                  icon: FontAwesomeIcons.linkedin),
                              HyperlinkButton(
                                  url: githubUrl,
                                  icon: FontAwesomeIcons.github),
                              HyperlinkButton(
                                  url: twitterUrl,
                                  icon: FontAwesomeIcons.twitter),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'Built with Flutter and Firebase',
                      style: TextStyle(color: Colors.grey),
                    ),
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

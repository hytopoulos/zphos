import 'package:flutter/material.dart';
// import 'package:flutter_highlighter/themes/atom-one-light.dart';
import 'package:flutter_highlighter/themes/solarized-dark.dart';
import 'package:flutter_highlighter/themes/solarized-light.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zphos/services/firestore_service.dart';
import 'package:zphos/sidebar.dart';
import 'package:zphos/title_bar.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_highlighter/flutter_highlighter.dart';

class CodeHighlighter extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    var language = '';

    final brightness = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
        .platformBrightness;

    if (element.attributes['class'] == null) {
      return null;
      // INLINE
      // return TextSpan(
      //   text: element.textContent,
      // color: brightness == Brightness.dark
      //     ? const Color(0xFF2B2B2B)
      //     : const Color(0xFFE5E5E5),
      // child: SelectableText(
      //   element.textContent,
      //   style: const TextStyle(
      //     fontFamily: 'monospace',
      //     fontWeight: FontWeight.w500,
      //     color: Color.fromARGB(255, 193, 25, 25),
      //   ),
      // ),
      // );
    }

    String lg = element.attributes['class'] as String;
    language = lg.substring(9);

    return SizedBox(
      width:
          MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width,
      child: HighlightView(
        element.textContent,
        language: language,
        theme: brightness == Brightness.dark
            ? solarizedDarkTheme
            : solarizedLightTheme,
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 12,
        ),
        textStyle: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
        ),
      ),
    );
  }
}

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // post/<category>/<name>?id=<id>
    RouteSettings settings = ModalRoute.of(context)!.settings;
    final settingsUri = Uri.parse(settings.name!);
    final postID = settingsUri.queryParameters['id']!;
    // final category = settingsUri.queryParameters['category'] ?? "";
    // final name = settingsUri.queryParameters['name'] ?? "";
    final Future<String> content = FirestoreService().getPost(postID);

    return FutureBuilder(
      future: content,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            key: _scaffoldKey,
            drawer: const SideBar(),
            drawerScrimColor: Colors.transparent,
            body: Stack(
              children: [
                Column(
                  children: [
                    // Container(
                    //   padding: const EdgeInsets.only(
                    //     top: 40,
                    //     left: 20,
                    //     right: 20,
                    //   ),
                    //   alignment: Alignment.topLeft,
                    //   child: IconButton(
                    //     icon: const Icon(Icons.menu),
                    //     onPressed: () {
                    //       setState(() {
                    //         _scaffoldKey.currentState!.openDrawer();
                    //       });
                    //     },
                    //   ),
                    // ),
                    Expanded(
                      child: Markdown(
                        //scale padding with screen size
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height / 10,
                            horizontal: MediaQuery.of(context).size.width / 10),
                        data: snapshot.data!.replaceAll("\\n", "\n"),
                        extensionSet: md.ExtensionSet.gitHubWeb,
                        builders: {
                          // 'table': TableBuilder(),
                          'code': CodeHighlighter(),
                        },
                        onTapLink: (text, href, title) {
                          launchUrl(Uri.parse(href!));
                        },
                        selectable: true,
                        imageDirectory: 'assets/',
                        imageBuilder: (uri, title, alt) {
                          return Container(
                            alignment: Alignment.center,
                            child: Wrap(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    height: 400,
                                    uri.toString(),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                // TitleBar(title: name),
                TitleBar(
                  title: "ZPHOS",
                  onMenuPressed: (() {
                    setState(() {
                      _scaffoldKey.currentState!.openDrawer();
                    });
                  }),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

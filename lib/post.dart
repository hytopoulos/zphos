import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:zphos/services/firestore_service.dart';
import 'package:zphos/sidebar.dart';
import 'package:zphos/title_bar.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_highlighter/flutter_highlighter.dart';

class CodeHighlighter extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    var language = '';

    final brightness = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
        .platformBrightness;

    if (element.attributes['class'] == null) {
      return Container(
        color: brightness == Brightness.dark
            ? const Color(0xFF2B2B2B)
            : const Color(0xFFE5E5E5),
        child: SelectableText(
          element.textContent,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 193, 25, 25),
          ),
        ),
      );
    }

    String lg = element.attributes['class'] as String;
    language = lg.substring(9);

    return HighlightView(
      element.textContent,
      language: language,
      // theme:
      //     brightness == Brightness.dark ? atomOneDarkTheme : atomOneLightTheme,
      padding: const EdgeInsets.all(12),
      textStyle: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
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
                    Container(
                      padding: const EdgeInsets.only(top: 50),
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          setState(() {
                            _scaffoldKey.currentState!.openDrawer();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: Markdown(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 20),
                        data: snapshot.data!.replaceAll("\\n", "\n"),
                        extensionSet: md.ExtensionSet.gitHubWeb,
                        builders: {
                          // 'table': TableBuilder(),
                          'code': CodeHighlighter(),
                        },
                        selectable: true,
                        imageDirectory: 'assets/',
                        imageBuilder: (uri, title, alt) {
                          return Image.asset(
                            height: 400,
                            uri.toString(),
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                // TitleBar(title: name),
                const TitleBar(title: "ZPHOS"),
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

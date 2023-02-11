import 'package:flutter/material.dart';
import 'package:zphos/markdown_view.dart';
import 'package:zphos/services/firestore_service.dart';
import 'package:zphos/sidebar.dart';
import 'package:zphos/title_bar.dart';

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
                      child: MarkdownView(
                          content: snapshot.data!.replaceAll("\\n", "\n")),
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

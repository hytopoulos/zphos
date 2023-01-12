import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:zphos/models/post_meta_model.dart';
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
    if (ModalRoute.of(context)!.settings.arguments == null) {
      Navigator.pop(context);
      return const Scaffold();
    }

    PostMetaModel post =
        ModalRoute.of(context)!.settings.arguments as PostMetaModel;

    final Future<String> content = FirestoreService().getPost(post.id);

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
                        data: snapshot.data as String,
                      ),
                    ),
                  ],
                ),
                TitleBar(title: "ZPHOS > ${post.category} > ${post.name}"),
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

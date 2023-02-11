import 'package:flutter/material.dart';
import 'package:zphos/markdown_view.dart';
import 'package:zphos/services/firestore_service.dart';

class FutureMarkdownView extends StatelessWidget {
  final String id;
  final bool isStatic;

  const FutureMarkdownView({Key? key, required this.id, this.isStatic = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<String> content = isStatic
        ? FirestoreService().getPostStatic(id)
        : FirestoreService().getPost(id);

    return FutureBuilder(
      future: content,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MarkdownView(content: snapshot.data!.replaceAll("\\n", "\n"));
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

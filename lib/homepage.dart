import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zphos/hyperlink_button.dart';
import 'package:zphos/markdown_view.dart';
import 'package:zphos/services/firestore_service.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<String> content = FirestoreService().getPostStatic("homepage");

    const String githubUrl = "https://github.com/notyourav";
    const String linkedinUrl =
        "https://www.linkedin.com/in/theo-hytopoulos-066392207/";
    const String twitterUrl = "https://twitter.com/pokeprotos";

    return FutureBuilder(
      future: content,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  MarkdownView(content: snapshot.data!.replaceAll("\\n", "\n")),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      HyperlinkButton(
                          url: linkedinUrl, icon: FontAwesomeIcons.linkedin),
                      HyperlinkButton(
                          url: githubUrl, icon: FontAwesomeIcons.github),
                      HyperlinkButton(
                          url: twitterUrl, icon: FontAwesomeIcons.twitter),
                    ],
                  ),
                  const Text(
                    'Built with Flutter and Firebase',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

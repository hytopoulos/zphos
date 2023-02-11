import 'package:flutter/material.dart';
import 'package:zphos/hyperlink.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zphos/hyperlink_button.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String githubUrl = "https://github.com/notyourav";
    const String linkedinUrl =
        "https://www.linkedin.com/in/theo-hytopoulos-066392207/";
    const String twitterUrl = "https://twitter.com/pokeprotos";

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 20),
        child: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints.loose(const Size.fromWidth(400)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Contact Me',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const Spacer(),
              // const Text('Links'),
              Table(
                children: const [
                  TableRow(
                    children: [
                      HyperlinkButton(
                          url: linkedinUrl, icon: FontAwesomeIcons.linkedin),
                      Hyperlink(
                        text: "LinkedIn",
                        url: linkedinUrl,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      HyperlinkButton(
                          url: githubUrl, icon: FontAwesomeIcons.github),
                      Hyperlink(
                        text: "GitHub",
                        url: githubUrl,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      HyperlinkButton(
                          url: twitterUrl, icon: FontAwesomeIcons.twitter),
                      Hyperlink(
                        text: "Twitter",
                        url: twitterUrl,
                      ),
                    ],
                  ),
                ],
                columnWidths: const {
                  0: FixedColumnWidth(50),
                  1: FixedColumnWidth(100),
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

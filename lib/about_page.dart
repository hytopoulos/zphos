import 'package:flutter/material.dart';
import 'package:zphos/hyperlink.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                'About',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const Spacer(),
              const Text('Links'),
              const Hyperlink(
                  text: "LinkedIn",
                  url: "https://www.linkedin.com/in/theo-hytopoulos-066392207/",
                  icon: Icon(FontAwesomeIcons.linkedin)),
              const Hyperlink(
                  text: "Github",
                  url: "https://github.com/notyourav",
                  icon: Icon(FontAwesomeIcons.squareGithub)),
              const Hyperlink(
                  text: "Twitter",
                  url: "https://twitter.com/pokeprotos",
                  icon: Icon(FontAwesomeIcons.squareTwitter)),
              const Spacer(),
              const Text(
                'Built with Flutter and Firebase',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

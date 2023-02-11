import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zphos/app_strings.dart';
import 'package:zphos/stateless/hyperlink_button.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            HyperlinkButton(
                url: AppStrings.myLinkedin, icon: FontAwesomeIcons.linkedin),
            HyperlinkButton(
                url: AppStrings.myGithub, icon: FontAwesomeIcons.github),
            HyperlinkButton(
                url: AppStrings.myTwitter, icon: FontAwesomeIcons.twitter),
          ],
        ),
        const Text(
          AppStrings.footer,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}

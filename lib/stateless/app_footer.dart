import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zphos/app_strings.dart';
import 'package:zphos/stateless/hyperlink.dart';
import 'package:zphos/stateless/hyperlink_button.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              HyperlinkButton(
                  url: AppStrings.myLinkedin,
                  icon: FontAwesomeIcons.linkedin,
                  hoverColor: Colors.blue),
              HyperlinkButton(
                  url: AppStrings.myGithub, icon: FontAwesomeIcons.github),
              HyperlinkButton(
                  url: AppStrings.myTwitter,
                  icon: FontAwesomeIcons.twitter,
                  hoverColor: Colors.blue),
            ],
          ),
          const FittedBox(
            child:
                Hyperlink(text: AppStrings.footer, url: AppStrings.footerURL),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HyperlinkButton extends StatelessWidget {
  final String url;
  final IconData icon;

  const HyperlinkButton({super.key, required this.url, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        splashRadius: 1,
        onPressed: () => launchUrl(
              Uri.parse(url),
            ),
        icon: Icon(icon));
  }
}

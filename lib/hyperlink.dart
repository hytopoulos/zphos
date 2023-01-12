import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Hyperlink extends StatelessWidget {
  final String text;
  final String url;
  final Icon? icon;

  const Hyperlink(
      {super.key, required this.text, required this.url, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) icon!,
          Text(
            text,
            style: const TextStyle(color: Colors.blue),
          ),
        ],
      ),
      onTap: () => launchUrl(
        Uri.parse(url),
      ),
    );
    // )
    // return RichText(
    //   text: TextSpan(
    //     text: 'GitHub',
    //     style: TextStyle(color: Colors.blue),
    //     recognizer: TapGestureRecognizer()
    //       ..onTap = () => launchUrl(
    //             Uri(
    //               scheme: 'https',
    //               host: url,
    //             ),
    //           ),
    //   ),
    // );
  }
}

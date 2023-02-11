import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/solarized-dark.dart';
import 'package:flutter_highlighter/themes/solarized-light.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

class CodeHighlighter extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    var language = '';

    final brightness = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
        .platformBrightness;

    if (element.attributes['class'] == null) {
      return null;
      // INLINE
      // return TextSpan(
      //   text: element.textContent,
      // color: brightness == Brightness.dark
      //     ? const Color(0xFF2B2B2B)
      //     : const Color(0xFFE5E5E5),
      // child: SelectableText(
      //   element.textContent,
      //   style: const TextStyle(
      //     fontFamily: 'monospace',
      //     fontWeight: FontWeight.w500,
      //     color: Color.fromARGB(255, 193, 25, 25),
      //   ),
      // ),
      // );
    }

    String lg = element.attributes['class'] as String;
    language = lg.substring(9);

    return SizedBox(
      width:
          MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width,
      child: HighlightView(
        element.textContent,
        language: language,
        theme: brightness == Brightness.dark
            ? solarizedDarkTheme
            : solarizedLightTheme,
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 12,
        ),
        textStyle: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
        ),
      ),
    );
  }
}

class MarkdownView extends StatelessWidget {
  final String content;

  const MarkdownView({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Markdown(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 10,
          horizontal: MediaQuery.of(context).size.width / 10),
      data: content,
      extensionSet: md.ExtensionSet.gitHubWeb,
      builders: {
        'code': CodeHighlighter(),
      },
      onTapLink: (text, href, title) {
        launchUrl(Uri.parse(href!));
      },
      selectable: true,
      imageDirectory: 'assets/',
      imageBuilder: (uri, title, alt) {
        return Container(
          alignment: Alignment.center,
          child: Wrap(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 7,
                      blurStyle: BlurStyle.outer,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.asset(
                  height: 400,
                  uri.toString(),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

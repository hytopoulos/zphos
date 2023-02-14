import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HyperlinkButton extends StatefulWidget {
  final String url;
  final IconData icon;
  final Color hoverColor;

  const HyperlinkButton(
      {super.key,
      required this.url,
      required this.icon,
      this.hoverColor = Colors.grey});

  @override
  State<HyperlinkButton> createState() => _HyperlinkButtonState();
}

class _HyperlinkButtonState extends State<HyperlinkButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(widget.url)),
      onHover: (value) => setState(() => _isHovering = value),
      child: IconButton(
        icon: Icon(widget.icon),
        splashRadius: 1,
        onPressed: () => launchUrl(Uri.parse(widget.url)),
        color:
            _isHovering ? widget.hoverColor : Theme.of(context).iconTheme.color,
      ),
    );
  }
}

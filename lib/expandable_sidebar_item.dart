import 'package:flutter/material.dart';

class ExpandableSidebarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final bool expanded;
  final VoidCallback onTap;

  const ExpandableSidebarItem({
    required Key key,
    required this.title,
    required this.icon,
    this.selected = false,
    this.expanded = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? Colors.grey[200] : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: selected ? Colors.blue : Colors.grey,
              ),
              SizedBox(width: 16.0),
              Text(
                title,
                style: TextStyle(
                  color: selected ? Colors.blue : Colors.grey,
                ),
              ),
              Spacer(),
              if (expanded)
                Icon(
                  Icons.expand_less,
                  color: selected ? Colors.blue : Colors.grey,
                ),
              if (!expanded)
                Icon(
                  Icons.expand_more,
                  color: selected ? Colors.blue : Colors.grey,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SidebarTile extends StatelessWidget {
  final String name;
  final String category;
  final String id;

  const SidebarTile(
      {super.key,
      required this.name,
      required this.category,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      onTap: () {
        Navigator.of(context, rootNavigator: true).pushNamed(
          Uri(path: '/post', queryParameters: {
            'id': id,
            'category': category,
            'name': name,
          }).toString(),
        );
      },
    );
  }
}

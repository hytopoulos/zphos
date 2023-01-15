import 'package:flutter/material.dart';

class Path {
  final String path;
  final Widget Function(BuildContext, String) builder;

  const Path(this.path, this.builder);
}

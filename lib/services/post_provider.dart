import 'package:flutter/material.dart';
import 'package:zphos/services/firestore_service.dart';

class PostProvider extends ChangeNotifier {
  String _content = "";

  Future<String> load(String id, {bool isStatic = false}) async {
    final Future<String> content = isStatic
        ? FirestoreService().getPostStatic(id)
        : FirestoreService().getPost(id);

    _content = await content;
    notifyListeners();
    return _content;
  }
}

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getPostMeta() {
    CollectionReference<Map<String, dynamic>> meta =
        _db.collection('post_meta');

    return meta.get().then((value) {
      return value.docs.map((e) => e.data()).toList();
    });
  }
}

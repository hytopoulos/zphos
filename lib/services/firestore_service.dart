import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Get post metadata (for sidebar)
  Future<List<Map<String, dynamic>>> getPostMeta() {
    CollectionReference<Map<String, dynamic>> meta =
        _db.collection('post_meta');

    return meta.get().then((value) {
      return value.docs.map((e) => e.data()).toList();
    });
  }

  Future<String> getPost(String id) {
    CollectionReference<Map<String, dynamic>> posts = _db.collection('post');
    return posts.doc(id).get().then((value) => value.data()!['content']);
  }

  /// Get static post (homepage)
  Future<String> getPostStatic(String id) {
    CollectionReference<Map<String, dynamic>> posts =
        _db.collection('post_static');
    return posts.doc(id).get().then((value) => value.data()!['content']);
  }
}

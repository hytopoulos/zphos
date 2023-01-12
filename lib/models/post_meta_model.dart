class PostMetaModel {
  final String id;
  final String name;

  PostMetaModel({
    required this.id,
    required this.name,
  });

  static Map<String, List<PostMetaModel>> parseCategories(
      List<Map<String, dynamic>> list) {
    Map<String, List<PostMetaModel>> categories = {};

    for (var element in list) {
      final String category = element['category'];
      final String id = element['post_id'];
      final String name = element['name'];

      if (categories.containsKey(category)) {
        categories[category]!.add(PostMetaModel(id: id, name: name));
      } else {
        categories[category] = [PostMetaModel(id: id, name: name)];
      }
    }

    return categories;
  }
}

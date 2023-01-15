import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:zphos/models/post_meta_model.dart';
import 'package:zphos/services/firestore_service.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    final Future<List<Map<String, dynamic>>> posts =
        FirestoreService().getPostMeta();

    return Drawer(
      elevation: 0,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  Scaffold.of(context).closeDrawer();
                });
              },
            ),
          ),
          FutureBuilder(
            future: posts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                log(snapshot.data.toString());
                Map<String, List<PostMetaModel>> posts =
                    PostMetaModel.parseCategories(
                  snapshot.data!,
                );

                log("num posts ${posts.length}");

                return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final String category = posts.keys.elementAt(index);
                      final List<PostMetaModel> postsInCategory =
                          posts[category] as List<PostMetaModel>;

                      return ExpansionTile(
                        title: Text(category),
                        children: postsInCategory
                            .map(
                              (e) => ListTile(
                                title: Text(e.name),
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed(
                                    Uri(path: '/post', queryParameters: {
                                      'id': e.id,
                                      'category': e.category,
                                      'name': e.name,
                                    }).toString(),
                                  );
                                },
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: LinearProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

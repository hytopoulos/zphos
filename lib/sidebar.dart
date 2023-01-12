import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:zphos/models/post_meta_model.dart';
import 'package:zphos/services/firebase_service.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final Future<List<Map<String, dynamic>>> posts =
        FirebaseService().getPostMeta();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: _isExpanded ? 300 : 50,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: _isExpanded
                  ? const Icon(Icons.arrow_back)
                  : const Icon(Icons.arrow_forward),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
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
                                  log(e.id);
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

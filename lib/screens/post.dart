import 'package:flutter/material.dart';
import 'package:zphos/app_strings.dart';
import 'package:zphos/app_style.dart';
import 'package:zphos/stateless/app_footer.dart';
import 'package:zphos/stateless/future_markdown_view.dart';
import 'package:zphos/stateful/sidebar.dart';
import 'package:zphos/stateless/app_header.dart';

/// Expects a query parameter named 'id' to be passed with the current route.
class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // post?id=<id>&category=<category>&name=<title>
    RouteSettings settings = ModalRoute.of(context)!.settings;
    final settingsUri = Uri.parse(settings.name!);
    final postID = settingsUri.queryParameters['id']!;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideBar(),
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                padding: AppStyle.withTheme(context).kDefaultPagePadding,
                child: FutureMarkdownView(id: postID),
              ),
              const AppFooter(),
            ],
          ),
          AppHeader(
            title: AppStrings.appName,
            onMenuPressed: (() {
              setState(() {
                _scaffoldKey.currentState!.openDrawer();
              });
            }),
          ),
        ],
      ),
    );
  }
}

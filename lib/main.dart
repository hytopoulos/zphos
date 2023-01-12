import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zphos/about_page.dart';
import 'package:zphos/firebase_options.dart';
import 'package:zphos/post.dart';
import 'package:zphos/sidebar.dart';
import 'package:zphos/title_bar.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/about': (context) => const AboutPage(),
        '/post': (context) => const Post(),
      },
      title: 'ZPHOS',
      theme: ThemeData(
        fontFamily: 'NunitoSans',
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'ZPHOS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          key: _scaffoldKey,
          drawer: const SideBar(),
          drawerScrimColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 50),
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    setState(() {
                      _scaffoldKey.currentState!.openDrawer();
                    });
                  },
                ),
              ),
              Center(
                child: Row(
                  children: [
                    // const SideBar(),
                    Expanded(
                      child: Column(
                        children: const [
                          Expanded(
                            child: Center(
                              child: Text(
                                  'Under construction! Please use the side bar.'),
                              // child: GridView.count(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 20, vertical: 80),
                              //   crossAxisCount: 4,
                              //   children: [
                              //     for (int i = 0; i < 10; i++)
                              //       const HomepageTile(
                              //           title: "Title",
                              //           subtitle: "subtitle",
                              //           image: "",
                              //           route: ""),
                              //   ],
                              // ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        TitleBar(title: widget.title),
      ],
    );
  }
}

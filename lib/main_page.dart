import 'package:first_app/GraphPages/graph_view_page.dart';
import 'package:flutter/material.dart';
import 'current_page.dart';
import 'EnterPages/choshi_enter_page.dart';

// タブによる画面切り替え等を担当しています

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // タブ一覧
  final tab = <Tab>[
    // アイコンは適当につきあとでまた変えたいです
    const Tab(text: "Enter Choshi", icon: Icon(Icons.directions_car)),
    const Tab(text: "Recent Choshi", icon: Icon(Icons.directions_bike)),
    const Tab(text: "Choshi Trends", icon: Icon(Icons.directions_boat))
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tab.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Jinx"),
            bottom: TabBar(
              tabs: tab,
            ),
          ),
          body: const TabBarView(children: [
            // 入力画面です
            ChoshiEnterPage(),

            // グラフ表示画面ですが今は仮置きです
            GraphViewPage(),

            // 共有画面ですが今は仮置きです
            TabPage(icon: Icons.directions_boat, title: "Choshi Trends")
          ]),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import './enterChosi.dart';
import './recentChosi.dart';
import './trendChosi.dart';

void main() {
  runApp(const MyApp());
}

enum Factors {
  atomosphere,
  temprature,
  calorie,
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final tab = <Tab>[
    Tab(text: "Enter Choshi", icon: const Icon(Icons.directions_car)),
    Tab(text: "Recent Choshi", icon: const Icon(Icons.directions_bike)),
    Tab(text: "Choshi Trends", icon: const Icon(Icons.directions_boat))
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
            AtomosphereEnterWidget(),
            TabPage(icon: Icons.directions_bike, title: "Recent Choshi"),
            TabPage(icon: Icons.directions_boat, title: "Choshi Trends")
          ]),
        ));
  }
}

class TabPage extends StatelessWidget {
  final IconData icon;
  final String title;

  const TabPage({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline1!;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 64.0, color: textStyle.color),
          Text(title, style: textStyle),
        ],
      ),
    );
  }
}

class ChoshiEnterPage extends StatefulWidget {
  const ChoshiEnterPage({super.key});
  @override
  _ChoshiEnterPageState createState() => _ChoshiEnterPageState();
}

class _ChoshiEnterPageState extends State<ChoshiEnterPage> {
  var data = <StatefulWidget>[];
  @override
  Widget build(BuildContext context) {
    loadWidgets();
    return ListView(
      children: data,
    );
  }

  bool isAlreadyEntered(Factors factor) {
    return false;
  }

  bool isObserved(Factors factor) {
    return true;
  }

  void loadWidgets() {
    if (isObserved(Factors.atomosphere)) {
      data.add(const AtomosphereEnterWidget());
    }
  }
}

class AtomosphereEnterWidget extends StatefulWidget {
  const AtomosphereEnterWidget({super.key});
  @override
  _AtomosphereEnterWidget createState() => _AtomosphereEnterWidget();
}

class _AtomosphereEnterWidget extends State<AtomosphereEnterWidget> {
  final txtcontroller = TextEditingController();
  var atomosphere = 0;
  void enterAtm() {}
  @override
  Widget build(BuildContext context) {
    // final TextStyle textStyle = Theme.of(context).textTheme.headline1!;
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "current atomosphere",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
              )),
          Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: txtcontroller,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.right,
              )),
          TextButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
              },
              child: const Text("Enter"))
        ]));
  }
}

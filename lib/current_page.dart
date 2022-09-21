import 'package:flutter/material.dart';

// 仮置きの画面です
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

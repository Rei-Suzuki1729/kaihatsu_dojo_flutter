import 'package:flutter/material.dart';

class ChoshiViewWidget extends StatelessWidget {
  const ChoshiViewWidget({super.key, required this.data});
  final int data;
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline3!;
    return Column(
      children: [
        const Text(
          "Calorie:",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
        ),
        Text(
          "$data point",
          style: textStyle,
        )
      ],
    );
  }
}

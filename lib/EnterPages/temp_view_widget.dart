import 'package:flutter/material.dart';

class TemperatureViewWidget extends StatelessWidget {
  const TemperatureViewWidget({super.key, required this.data});
  final int data;
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline3!;
    return Column(
      children: [
        const Text(
          "Temperature:",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
        ),
        Text(
          "$dataºC",
          style: textStyle,
        )
      ],
    );
  }
}

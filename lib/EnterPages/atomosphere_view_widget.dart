import 'package:flutter/material.dart';

class AtomosphereViewWidget extends StatelessWidget {
  final int data;
  const AtomosphereViewWidget({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline3!;
    return Column(
      children: [
        const Text(
          "Atomosphere:",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
        ),
        Text(
          "${data}hPa",
          style: textStyle,
        )
      ],
    );
  }
}

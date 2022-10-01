import 'package:first_app/GraphPages/graph_view_widget.dart';
import 'package:first_app/shared_definitions.dart';
import 'package:flutter/material.dart';

class GraphViewPage extends StatefulWidget {
  const GraphViewPage({super.key});
  @override
  _GraphViewPageState createState() => _GraphViewPageState();
}

class _GraphViewPageState extends State<GraphViewPage> {
  @override
  Widget build(BuildContext context) {
    return const GraphViewWidget(viewContents: Factors.atomosphere);
  }
}

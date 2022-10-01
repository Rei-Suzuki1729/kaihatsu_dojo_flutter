import 'package:first_app/shared_definitions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraphViewWidget extends StatefulWidget {
  final Factors viewContents;
  const GraphViewWidget({super.key, required this.viewContents});
  @override
  _GraphViewWidgetState createState() =>
      _GraphViewWidgetState(viewContents: viewContents);
}

class _GraphViewWidgetState extends State<GraphViewWidget> {
  final Factors viewContents;
  _GraphViewWidgetState({required this.viewContents});
  late FlTitlesData _titles;
  final TextStyle _labelStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w800);
  final TextStyle _titleStyle =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.w800);

  @override
  void initState() {
    super.initState();
    _initChartTitle();
  }

  SideTitles _bottomTitles() => SideTitles(
      showTitles: true,
      reservedSize: 24,
      interval: 1,
      getTitlesWidget: (month, meta) {
        const style = TextStyle(
          color: Color(0xff72719b),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        );
        String text;

        if (month.toInt() < 1 || month.toInt() > 12) {
          text = "";
        } else {
          text = "${month.toInt()}";
        }

        return SideTitleWidget(
          axisSide: meta.axisSide,
          space: 10,
          child: Text(
            text,
            style: style,
          ),
        );
      });

  void _initChartTitle() {
    DateTime dt = DateTime.now();
    _titles = FlTitlesData(
      topTitles: AxisTitles(
          axisNameWidget: Text(
            "Choshi - ${viewContents.toString()}",
            style: _titleStyle,
          ),
          axisNameSize: 48),
      rightTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: false,
      )),
      bottomTitles: AxisTitles(
        sideTitles: _bottomTitles(),
        axisNameWidget: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "day",
            style: _labelStyle,
          ),
        ),
      ),
      leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          axisNameWidget: Text(
            viewContents.toString(),
            style: _labelStyle,
          ),
          axisNameSize: 32),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8, right: 32),
          height: 300,
          width: 500,
          child: LineChart(LineChartData(
              backgroundColor: Colors.grey[200],
              titlesData: _titles,
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  color: Colors.red[400],
                  barWidth: 4,
                  dotData: FlDotData(show: true),
                  spots: const [
                    FlSpot(1, 1011),
                    FlSpot(2, 1008),
                    FlSpot(3, 993),
                    FlSpot(4, 995),
                    FlSpot(5, 1019),
                    FlSpot(6, 1011),
                    FlSpot(7, 1008),
                  ],
                ),
                LineChartBarData(
                  isCurved: true,
                  color: const Color.fromARGB(255, 85, 80, 239),
                  barWidth: 4,
                  dotData: FlDotData(show: true),
                  spots: const [
                    FlSpot(1, 75 / 100 * 26 + 993),
                    FlSpot(2, 80 / 100 * 26 + 993),
                    FlSpot(3, 43 / 100 * 26 + 993),
                    FlSpot(4, 50 / 100 * 26 + 993),
                    FlSpot(5, 67 / 100 * 26 + 993),
                    FlSpot(6, 70 / 100 * 26 + 993),
                    FlSpot(7, 75 / 100 * 26 + 993),
                  ],
                ),
              ])),
        ),
      ],
    );
  }
}

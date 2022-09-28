import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kaihatsu_dojo_flutter/bar_chart_main/bar_chart.dart';
import 'package:kaihatsu_dojo_flutter/constants/const.dart';

class GraphPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 100.0, width: 30.0),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              'YOUR WEIGHT RECORD',
              style: kBlackTextStyle,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: BarChartSampleNasubi(),
        ),
        SizedBox(height: 120.0, width: 30.0),
      ],
    );
  }
}

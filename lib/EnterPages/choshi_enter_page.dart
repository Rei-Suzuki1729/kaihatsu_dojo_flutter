import 'package:first_app/EnterPages/calorie_enter_widget.dart';
import 'package:first_app/EnterPages/calorie_view_widget.dart';
import 'package:first_app/EnterPages/choshi_enter_widget.dart';
import 'package:first_app/EnterPages/choshi_view_widget.dart';
import 'package:first_app/EnterPages/temp_enter_widget.dart';
import 'package:first_app/EnterPages/temp_view_widget.dart';
import 'package:first_app/LocalDataAccess/local_data_access.dart';
import 'package:flutter/material.dart';
import '../shared_definitions.dart';
import 'atomosphere_enter_widget.dart';
import 'atomosphere_view_widget.dart';

// 調子を入力する画面です
//
class ChoshiEnterPage extends StatefulWidget {
  const ChoshiEnterPage({super.key});
  @override
  _ChoshiEnterPageState createState() => _ChoshiEnterPageState();
}

class _ChoshiEnterPageState extends State<ChoshiEnterPage> {
  _ChoshiEnterPageState() {
    loadWidgets();
  }
  var data = <Widget>[];
  final atmEnter = const AtomosphereEnterWidget();
  final tempEnter = const TemperatureEnterWidget();
  final calEnter = const CalorieEnterWidget();
  final manager = DataManager();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //loadWidgets();
      },
      child: ListView(
        children: data,
      ),
    );
  }

  // @override
  // void initState() async {
  //   await loadWidgets();
  //   super.initState();
  // }

  Future<int> loadWidgets() async {
    data.clear();
    if (await isObserved(Factors.atomosphere)) {
      // 気圧が対象ファクターの時
      if (await manager.getDataOf(Factors.atomosphere, manager.today()) ==
          null) {
        // 未記入→記入画面生成
        data.add(atmEnter);
      } else {
        // 記入済み 記入情報表示
        final vd =
            (await manager.getDataOf(Factors.atomosphere, manager.today()))!;
        data.add(AtomosphereViewWidget(data: vd));
      }
    }
    if (await isObserved(Factors.temperature)) {
      if (await manager.getDataOf(Factors.temperature, manager.today()) ==
          null) {
        data.add(tempEnter);
      } else {
        final vd =
            (await manager.getDataOf(Factors.temperature, manager.today()))!;
        data.add(TemperatureViewWidget(data: vd));
      }
    }

    if (await isObserved(Factors.calorie)) {
      if (await manager.getDataOf(Factors.calorie, manager.today()) == null) {
        data.add(calEnter);
      } else {
        final vd = (await manager.getDataOf(Factors.calorie, manager.today()))!;
        data.add(CalorieViewWidget(data: vd));
      }
    }
    if (await manager.getChoshiDataAt(manager.today()) == null) {
      data.add(const ChoshiEnterWidget());
    } else {
      final vd = (await manager.getChoshiDataAt(manager.today()))!;
      data.add(ChoshiViewWidget(data: vd));
    }
    setState(() {});
    return 0;
  }
}

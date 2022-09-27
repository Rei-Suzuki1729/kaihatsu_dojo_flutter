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
  @override
  Widget build(BuildContext context) {
    loadWidgets();
    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: ListView(
        children: data,
      ),
    );
  }

  void loadWidgets() async {
    data.clear();
    final dm = DataManager();
    if (await isObserved(Factors.atomosphere)) {
      // 気圧が対象ファクターの時
      if (dm.getDataOf(Factors.atomosphere, dm.today()) == null) {
        // 未記入→記入画面生成
        data.add(const AtomosphereEnterWidget());
      } else {
        // 記入済み 記入情報表示
        data.add(const AtomosphereViewWidget());
      }
    }
  }
}

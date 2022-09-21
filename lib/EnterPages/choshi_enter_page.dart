import 'package:flutter/material.dart';
import '../shared_definitions.dart';
import 'atomosphere_enter_widget.dart';

// 調子を入力する画面です
//
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

  // ローカルファイルを検索し、その日すでに入力が行われているか確認します
  bool isAlreadyEntered(Factors factor) {
    return false;
  }

  // ユーザーがそのファクターを紐づけているかどうかを返します
  bool isObserved(Factors factor) {
    return true;
  }

  void loadWidgets() {
    data.clear();
    if (isObserved(Factors.atomosphere)) {
      // 気圧が対象ファクターの時
      if (!isAlreadyEntered(Factors.atomosphere)) {
        // 未記入→記入画面生成
        data.add(const AtomosphereEnterWidget());
      } else {
        // 記入済み 記入情報表示
        // data.add(const AtomosphereShowWidget())
      }
    }
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import '../shared_definitions.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

// ユーザーがそのファクターを記録しているか返します
Future<bool> isObserved(Factors factor) async {
  final pref = await SharedPreferences.getInstance();
  final result = pref.getBool(toString(factor));
  return result ?? false;
}

// 特定のファクターの記録を開始します 気軽に呼んで大丈夫です
void startObserve(Factors factor) async {
  final pref = await SharedPreferences.getInstance();
  await pref.setBool(toString(factor), true);
}

// 特定のファクターの記録を停止します
void stopObserve(Factors factor) async {
  final pref = await SharedPreferences.getInstance();
  await pref.setBool(toString(factor), false);
}

/*
ローカルデータの読み込みを行います
本来ならシングルトン設計するべきですが、面倒なので後回し
loadAllDatas()を呼んでから動かしてください。コンストラクタに入れようとしたらできませんでした。
*/
class DataManager {
  Map<DateTime, int> atmData = {};
  Map<DateTime, int> calData = {};
  Map<DateTime, int> tempData = {};
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> getFileOf(Factors factor) async {
    final path = await localPath;
    switch (factor) {
      case Factors.atomosphere:
        return File("$path/atm.txt");
      case Factors.calorie:
        return File("$path/cal.txt");
      case Factors.temperature:
        return File("$path/temp.txt");
    }
  }

  void loadAtmData() {
    String data;
    int currentVal = 0;
    int month = 0;
    int year = 0;
    int date = 0;
    int info = 0;
    try {
      final file = getFileOf(Factors.atomosphere);
      data = file.toString();
    } catch (e) {
      return;
    }
    for (var i = 0; i < data.length; i++) {
      final character = data[i];
      int? intData = int.tryParse(character);
      if (intData != null) {
        currentVal = currentVal * 10 + intData;
        continue;
      }
      if (character == "/") {
        if (year == 0) {
          year = currentVal;
        } else {
          month = currentVal;
        }
        currentVal = 0;
      }
      if (character == " ") {
        date = currentVal;
        currentVal = 0;
      }
      if (character == ",") {
        info = currentVal;
        currentVal = 0;
        DateTime dt = DateTime(year, month, date);
        atmData[dt] = info;
        month = 0;
        year = 0;
        date = 0;
        info = 0;
      }
    }
  }

  void loadTempData() {
    String data;
    int currentVal = 0;
    int month = 0;
    int year = 0;
    int date = 0;
    int info = 0;
    try {
      final file = getFileOf(Factors.atomosphere);
      data = file.toString();
    } catch (e) {
      return;
    }
    for (var i = 0; i < data.length; i++) {
      final character = data[i];
      int? intData = int.tryParse(character);
      if (intData != null) {
        currentVal = currentVal * 10 + intData;
        continue;
      }
      if (character == "/") {
        if (year == 0) {
          year = currentVal;
        } else {
          month = currentVal;
        }
        currentVal = 0;
      }
      if (character == " ") {
        date = currentVal;
        currentVal = 0;
      }
      if (character == ",") {
        info = currentVal;
        currentVal = 0;
        DateTime dt = DateTime(year, month, date);
        tempData[dt] = info;
        month = 0;
        year = 0;
        date = 0;
        info = 0;
      }
    }
  }

  void loadCalData() {
    String data;
    int currentVal = 0;
    int month = 0;
    int year = 0;
    int date = 0;
    int info = 0;
    try {
      final file = getFileOf(Factors.atomosphere);
      data = file.toString();
    } catch (e) {
      return;
    }
    for (var i = 0; i < data.length; i++) {
      final character = data[i];
      int? intData = int.tryParse(character);
      if (intData != null) {
        currentVal = currentVal * 10 + intData;
        continue;
      }
      if (character == "/") {
        if (year == 0) {
          year = currentVal;
        } else {
          month = currentVal;
        }
        currentVal = 0;
      }
      if (character == " ") {
        date = currentVal;
        currentVal = 0;
      }
      if (character == ",") {
        info = currentVal;
        currentVal = 0;
        DateTime dt = DateTime(year, month, date);
        calData[dt] = info;
        month = 0;
        year = 0;
        date = 0;
        info = 0;
      }
    }
  }

  void loadAllDatas() async {
    if (await isObserved(Factors.atomosphere)) {
      loadAtmData();
    }
    if (await isObserved(Factors.temperature)) {
      loadTempData();
    }
    if (await isObserved(Factors.calorie)) {
      loadCalData();
    }
  }

  void writeData(Factors factor, int data) async {
    DateTime dt = DateTime.now();
    final year = dt.year;
    final month = dt.month;
    final date = dt.day;
    final file = await getFileOf(factor);
    file.writeAsString("$year/$month/$date $data,");
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared_definitions.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

// ユーザーがそのファクターを記録しているか返します
Future<bool> isObserved(Factors factor) async {
  final pref = await SharedPreferences.getInstance();
  final result = pref.getBool(toString(factor));
  return result ?? true;
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
-> できました
*/
class DataManager {
  DataManager() {
    loadAllDatas();
  }
  Map<String, int> atmData = {};
  Map<String, int> calData = {};
  Map<String, int> tempData = {};
  Map<String, int> choshiData = {};
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

  Future<File> getChoshiFile() async {
    final path = await localPath;
    return File("$path/choshi.txt");
  }

  Future<Map<String, int>> loadAtmData() async {
    String data = "";
    int currentVal = 0;
    int month = 0;
    int year = 0;
    int date = 0;
    int info = 0;
    Map<String, int> atm = {};
    try {
      var mayFile = await getFileOf(Factors.atomosphere);
      data = mayFile.readAsStringSync();
    } catch (e) {
      return {};
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
        atm["$year/$month/$date"] = info;
        month = 0;
        year = 0;
        date = 0;
        info = 0;
      }
    }
    return atm;
  }

  Future<Map<String, int>> loadTempData() async {
    String data;
    int currentVal = 0;
    int month = 0;
    int year = 0;
    int date = 0;
    int info = 0;
    Map<String, int> temp = {};
    try {
      var file = await getFileOf(Factors.temperature);
      data = file.readAsStringSync();
      debugPrint(data);
    } catch (e) {
      return temp;
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
        temp["$year/$month/$date"] = info;
        month = 0;
        year = 0;
        date = 0;
        info = 0;
      }
    }
    return temp;
  }

  Future<Map<String, int>> loadCalData() async {
    String data;
    int currentVal = 0;
    int month = 0;
    int year = 0;
    int date = 0;
    int info = 0;
    Map<String, int> cal = {};
    try {
      var file = await getFileOf(Factors.calorie);
      data = file.readAsStringSync();
      debugPrint(data);
    } catch (e) {
      return cal;
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
        cal["$year/$month/$date"] = info;
        month = 0;
        year = 0;
        date = 0;
        info = 0;
      }
    }
    return cal;
  }

  Future<Map<String, int>> loadChoshi() async {
    String data;
    int currentVal = 0;
    int month = 0;
    int year = 0;
    int date = 0;
    int info = 0;
    Map<String, int> choshi = {};
    try {
      var file = await getChoshiFile();
      data = file.readAsStringSync();
      debugPrint(data);
    } catch (e) {
      return choshi;
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
        choshi["$year/$month/$date"] = info;
        month = 0;
        year = 0;
        date = 0;
        info = 0;
      }
    }
    return choshi;
  }

  Future<int> loadAllDatas() async {
    if (await isObserved(Factors.atomosphere)) {
      atmData = await loadAtmData();
    }
    if (await isObserved(Factors.temperature)) {
      tempData = await loadTempData();
    }
    if (await isObserved(Factors.calorie)) {
      calData = await loadCalData();
    }
    choshiData = await loadChoshi();
    return 0;
  }

  void writeData(Factors factor, int data) async {
    DateTime dt = DateTime.now();
    final year = dt.year;
    final month = dt.month;
    final date = dt.day;
    final file = await getFileOf(factor);
    file.writeAsString("$year/$month/$date $data,");
    await loadAllDatas();
  }

  void writeChoshiData(int data) async {
    DateTime dt = DateTime.now();
    final year = dt.year;
    final month = dt.month;
    final date = dt.day;
    final file = await getChoshiFile();
    file.writeAsString("$year/$month/$date $data,");
    await loadAllDatas();
  }

  Future<int?> getDataOf(Factors factor, String when) async {
    await loadAllDatas();
    switch (factor) {
      case Factors.atomosphere:
        return atmData[when];
      case Factors.calorie:
        return calData[when];
      case Factors.temperature:
        return tempData[when];
    }
  }

  Future<int?> getChoshiDataAt(String when) async {
    await loadAllDatas();
    return choshiData[when];
  }

  String today() {
    DateTime dt = DateTime.now();
    final year = dt.year;
    final month = dt.month;
    final date = dt.day;
    return "$year/$month/$date";
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import '../shared_definitions.dart';

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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kaihatsu_dojo_flutter/constants/const.dart';
import 'package:kaihatsu_dojo_flutter/model/viewmodel/firestoreDatamodel.dart';
import 'package:kaihatsu_dojo_flutter/model/viewmodel/addmodel.dart';
import 'package:kaihatsu_dojo_flutter/model/viewmodel/DiffConditionmodel.dart';
import 'package:kaihatsu_dojo_flutter/model/symplemodel/loginmodel.dart';

class RecordPage extends HookConsumerWidget {
  RecordPage({required this.date});

  String date;
  String condition = '';
  String age = '';
  String memo = '';
  double DiffCondition = 0.0;
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _addController = ref.watch(userInfoModelProvider.notifier);
    final _DiffConditionController = DiffConditionModel();
    final _fireStoreDataController = ref.watch(firestoreDataModelProvider);

    ///TODO: 年齢が変化した時にはデフォルトも修正する
    TextEditingController _ageController =
        TextEditingController(text: _fireStoreDataController.newage);
    TextEditingController _dateController = TextEditingController(text: date);
    TextEditingController _conditionController = TextEditingController();
    TextEditingController _memoController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //TODO: テキストフィールド → ドロップダウンリストにする
              TextField(
                decoration: InputDecoration(
                  labelText: 'DAY',
                  hintText: '2021-09-03',
                  labelStyle: kBlackTextStyle,
                ),
                controller: _dateController,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  date = text;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'condition',
                  hintText: '50.0',
                  labelStyle: kBlackTextStyle,
                ),
                controller: _conditionController,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  condition = text;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'age',
                  hintText: '165.6',
                  labelStyle: kBlackTextStyle,
                ),
                controller: _ageController,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  age = text;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'MEMO',
                  hintText: '例 : 食べすぎた',
                  labelStyle: kBlackTextStyle,
                ),
                controller: _memoController,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  memo = text;
                  //print(_memoController.text);
                },
              ),
              SizedBox(
                width: 10.0,
                height: 16.0,
              ),
              MaterialButton(
                onPressed: () {
                  //TODO firestoreからとってくるように実装する
                  DiffCondition = _DiffConditionController.DiffConditionCalc(YesterdayConditon: double.parse(condition), Condition: double.parse(condition))!;
                  _addController.addRecord(
                      email: auth.currentUser!.email,
                      date: date,
                      stringAge: age,
                      stringCondition: condition,
                      memo: memo,
                      diffCondition: DiffCondition.toStringAsFixed(1));
                  ///ポップアップウインドウを出す
                  _addController.showMyDialog(context: context, text: 'データを記録しました');
                },
                height: 50.0,
                child: Icon(
                  Icons.add,
                  color: kMainColour,
                ),
                color: kAccentColour,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                elevation: 5.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

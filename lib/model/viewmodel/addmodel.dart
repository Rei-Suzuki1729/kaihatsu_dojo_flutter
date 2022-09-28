import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kaihatsu_dojo_flutter/constants/const.dart';
import 'package:kaihatsu_dojo_flutter/model/viewmodel/DiffConditionmodel.dart';

///provider
final userInfoModelProvider =
    StateNotifierProvider<UserInfoModelState, UserInfoModel>((ref) => UserInfoModelState());

///properties
class UserInfoModel {
  UserInfoModel({required this.nickname});

  String nickname;
}

///state
class UserInfoModelState extends StateNotifier<UserInfoModel> {
  UserInfoModelState() : super(UserInfoModel(nickname: ''));

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  ///体重記録
  Future<void> addRecord(
      {required email,
      required date,
      required stringAge,
      required stringCondition,
      required memo,
      required diffCondition}) async {
    ///ユーザーネーム（ニックネーム）と年齢をfirestoreから取得
    final _docs = await firestore.collection('user').doc(email).get();
    state = UserInfoModel(nickname: _docs.data()!['nickname']);
    final _month = DateTime.parse(date).month;
    final _year = DateTime.parse(date).year;
    String _stringym = _year.toString() + '-' + _month.toString();

    final _docs1 =
        firestore.collection('user').doc(email).collection(_stringym).doc(date);
    await _docs1.set({
      'nickname': state.nickname,
      'months': _stringym,
      'Age': stringAge,
      'Condition': stringCondition,
      'memo': memo,
      'date': Timestamp.fromDate(DateTime.parse(date)),
      'diffCondition': diffCondition,
    });
  }

  ///確認ダイアログ
  Future<void> showMyDialog({required context, required text}) async {

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('かくにん'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text, style: kBlackTextStyle),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: kBlackTextStyle),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
